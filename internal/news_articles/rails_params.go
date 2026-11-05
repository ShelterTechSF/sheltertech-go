package newsarticles

// This file rebuilds the `params` hash the Rails NewsArticlesController read,
// so the Go handlers see the same values for the same request. It covers the
// work Rack and Rails did before the controller ran:
//
//   - query-string and form-body parsing, including Rack's nested keys
//     (`news_article[headline]`, `a[]`), for urlencoded and multipart bodies
//   - JSON body parsing, keeping key order the way a Ruby Hash does
//   - removing nils from arrays (Rails' "deep munge")
//   - wrap_parameters, which copies the top-level keys of a JSON body under
//     "news_article" when the body does not already have that key
//
// Param values are nil, string, bool, json.Number, []any or *paramHash.

import (
	"bytes"
	"encoding/json"
	"errors"
	"io"
	"mime"
	"mime/multipart"
	"net/http"
	"net/url"
	"regexp"
	"strings"
	"unicode/utf8"

	"github.com/go-chi/chi/v5"
)

// errBadRequest marks input that Rails rejected with 400 before the controller
// ran: malformed JSON, bad percent-encoding, or conflicting nested form keys.
var errBadRequest = errors.New("bad request")

// newsArticleAttributes are NewsArticle.attribute_names, which wrap_parameters
// copies from a JSON body into params["news_article"].
var newsArticleAttributes = []string{
	"id", "headline", "effective_date", "body", "priority", "expiration_date", "created_at", "updated_at", "url",
}

// jsonMediaTypes are the content types Rails registers for its JSON params parser.
var jsonMediaTypes = map[string]bool{"application/json": true, "text/x-json": true, "application/jsonrequest": true}

// paramHash is an insertion-ordered map, like a Ruby Hash: setting an existing
// key keeps its original position.
type paramHash struct {
	keys   []string
	values map[string]any
}

func newParamHash() *paramHash {
	return &paramHash{values: map[string]any{}}
}

func (h *paramHash) has(key string) bool {
	_, ok := h.values[key]
	return ok
}

// get returns nil for a missing key, as Ruby does.
func (h *paramHash) get(key string) any {
	return h.values[key]
}

func (h *paramHash) set(key string, value any) {
	if !h.has(key) {
		h.keys = append(h.keys, key)
	}
	h.values[key] = value
}

// paramArray is a mutable array used while parsing Rack form keys, where
// `a[]=1&a[]=2` appends to an array already stored in the hash. normalizeParam
// turns it into a plain []any.
type paramArray struct {
	items []any
}

// requestParams builds the params hash for a request, or returns errBadRequest
// when Rails would have answered 400.
func requestParams(r *http.Request) (*paramHash, error) {
	query, err := parseRackQuery(r.URL.RawQuery, "&;")
	if err != nil {
		return nil, err
	}
	body, isJSON, err := parseRequestBody(r)
	if err != nil {
		return nil, err
	}

	// params is query_parameters.merge(request_parameters), then path parameters.
	params := newParamHash()
	for _, source := range []*paramHash{query, body} {
		for _, key := range source.keys {
			params.set(key, source.get(key))
		}
	}
	if isJSON && !params.has("news_article") {
		wrapped := newParamHash()
		for _, key := range newsArticleAttributes {
			if body.has(key) {
				wrapped.set(key, body.get(key))
			}
		}
		params.set("news_article", wrapped)
	}
	if routeContext := chi.RouteContext(r.Context()); routeContext != nil {
		for i, key := range routeContext.URLParams.Keys {
			params.set(key, routeContext.URLParams.Values[i])
		}
	}
	return normalizeParam(params).(*paramHash), nil
}

func mediaType(r *http.Request) string {
	contentType := r.Header.Get("Content-Type")
	if i := strings.IndexAny(contentType, ";,"); i >= 0 {
		contentType = contentType[:i]
	}
	return strings.ToLower(strings.TrimSpace(contentType))
}

// parseRequestBody returns request_parameters and whether Rails parsed the body
// as JSON (which is what turns on wrap_parameters).
func parseRequestBody(r *http.Request) (*paramHash, bool, error) {
	if r.Body == nil {
		return newParamHash(), false, nil
	}
	data, err := io.ReadAll(r.Body)
	if err != nil {
		return nil, false, errBadRequest
	}
	media := mediaType(r)

	switch {
	case jsonMediaTypes[media]:
		if len(data) == 0 {
			return newParamHash(), true, nil
		}
		value, err := decodeOrderedJSON(data)
		if err != nil {
			return nil, true, errBadRequest
		}
		if hash, ok := value.(*paramHash); ok {
			return hash, true, nil
		}
		// A non-object JSON body is stored under "_json".
		hash := newParamHash()
		hash.set("_json", value)
		return hash, true, nil

	// Rack treats a POST with no content type as a urlencoded form.
	case media == "application/x-www-form-urlencoded" || (media == "" && r.Method == http.MethodPost):
		form := strings.TrimSuffix(string(data), "\x00")
		hash, err := parseRackQuery(form, "&")
		return hash, false, err

	case media == "multipart/form-data" || media == "multipart/related" || media == "multipart/mixed":
		hash, err := parseMultipart(r.Header.Get("Content-Type"), data)
		return hash, false, err
	}
	return newParamHash(), false, nil
}

// decodeOrderedJSON parses JSON keeping object key order, with numbers as json.Number.
func decodeOrderedJSON(data []byte) (any, error) {
	decoder := json.NewDecoder(bytes.NewReader(data))
	decoder.UseNumber()
	value, err := decodeJSONValue(decoder)
	if err != nil {
		return nil, err
	}
	if _, err := decoder.Token(); err != io.EOF {
		return nil, errors.New("unexpected data after JSON value")
	}
	return value, nil
}

func decodeJSONValue(decoder *json.Decoder) (any, error) {
	token, err := decoder.Token()
	if err != nil {
		return nil, err
	}
	delim, isDelim := token.(json.Delim)
	if !isDelim {
		return token, nil
	}
	switch delim {
	case '{':
		hash := newParamHash()
		for decoder.More() {
			keyToken, err := decoder.Token()
			if err != nil {
				return nil, err
			}
			value, err := decodeJSONValue(decoder)
			if err != nil {
				return nil, err
			}
			hash.set(keyToken.(string), value)
		}
		_, err = decoder.Token()
		return hash, err
	case '[':
		items := []any{}
		for decoder.More() {
			value, err := decodeJSONValue(decoder)
			if err != nil {
				return nil, err
			}
			items = append(items, value)
		}
		_, err = decoder.Token()
		return items, err
	}
	return nil, errors.New("unexpected JSON delimiter")
}

// parseRackQuery ports Rack::QueryParser#parse_nested_query. separators is "&;"
// for query strings and "&" for form bodies, as in Rack 2.2.
func parseRackQuery(query string, separators string) (*paramHash, error) {
	params := newParamHash()
	if query == "" {
		return params, nil
	}
	splitter := regexp.MustCompile("[" + regexp.QuoteMeta(separators) + "] *")
	for _, pair := range splitter.Split(query, -1) {
		if pair == "" {
			continue
		}
		rawKey, rawValue, hasValue := strings.Cut(pair, "=")
		key, err := url.QueryUnescape(rawKey)
		if err != nil || !utf8.ValidString(key) {
			return nil, errBadRequest
		}
		var value any
		if hasValue {
			unescaped, err := url.QueryUnescape(rawValue)
			if err != nil || !utf8.ValidString(unescaped) {
				return nil, errBadRequest
			}
			value = unescaped
		}
		if _, err := normalizeRackParams(params, key, value); err != nil {
			return nil, err
		}
	}
	return params, nil
}

func parseMultipart(contentType string, data []byte) (*paramHash, error) {
	_, mediaParams, err := mime.ParseMediaType(contentType)
	if err != nil || mediaParams["boundary"] == "" {
		return nil, errBadRequest
	}
	params := newParamHash()
	reader := multipart.NewReader(bytes.NewReader(data), mediaParams["boundary"])
	for {
		part, err := reader.NextPart()
		if err == io.EOF {
			return params, nil
		}
		if err != nil {
			return nil, errBadRequest
		}
		// File uploads became ActionDispatch::Http::UploadedFile objects, which
		// none of the news article fields can use, so they are skipped.
		if part.FormName() == "" || part.FileName() != "" {
			continue
		}
		value, err := io.ReadAll(part)
		if err != nil {
			return nil, errBadRequest
		}
		if _, err := normalizeRackParams(params, part.FormName(), string(value)); err != nil {
			return nil, err
		}
	}
}

var (
	rackKeyPattern          = regexp.MustCompile(`^[\[\]]*([^\[\]]+)\]*`)
	rackArrayOfHashPattern  = regexp.MustCompile(`^\[\]\[([^\[\]]+)\]$`)
	rackArrayOfHashFallback = regexp.MustCompile(`^\[\](.+)$`)
	rackKeySplitPattern     = regexp.MustCompile(`[\[\]]+`)
)

// normalizeRackParams ports Rack::QueryParser#normalize_params. A key used as
// both a scalar and a nested hash (or array) is a ParameterTypeError, which
// Rails answered with 400.
func normalizeRackParams(params *paramHash, name string, value any) (any, error) {
	var key, after string
	if match := rackKeyPattern.FindStringSubmatchIndex(name); match != nil {
		key = name[match[2]:match[3]]
		after = name[match[1]:]
	}
	if key == "" {
		if value != nil && name == "[]" {
			return []any{value}, nil
		}
		return nil, nil
	}

	switch {
	case after == "":
		params.set(key, value)
	case after == "[":
		params.set(name, value)
	case after == "[]":
		array, err := rackArray(params, key)
		if err != nil {
			return nil, err
		}
		array.items = append(array.items, value)
	default:
		childMatch := rackArrayOfHashPattern.FindStringSubmatch(after)
		if childMatch == nil {
			childMatch = rackArrayOfHashFallback.FindStringSubmatch(after)
		}
		if childMatch != nil {
			childKey := childMatch[1]
			array, err := rackArray(params, key)
			if err != nil {
				return nil, err
			}
			last, lastIsHash := lastItem(array).(*paramHash)
			if lastIsHash && !rackHashHasKey(last, childKey) {
				if _, err := normalizeRackParams(last, childKey, value); err != nil {
					return nil, err
				}
			} else {
				child, err := normalizeRackParams(newParamHash(), childKey, value)
				if err != nil {
					return nil, err
				}
				array.items = append(array.items, child)
			}
			break
		}
		existing := params.get(key)
		if existing == nil {
			existing = newParamHash()
			params.set(key, existing)
		}
		child, ok := existing.(*paramHash)
		if !ok {
			return nil, errBadRequest
		}
		if _, err := normalizeRackParams(child, after, value); err != nil {
			return nil, err
		}
	}
	return params, nil
}

func rackArray(params *paramHash, key string) (*paramArray, error) {
	existing := params.get(key)
	if existing == nil {
		array := &paramArray{}
		params.set(key, array)
		return array, nil
	}
	array, ok := existing.(*paramArray)
	if !ok {
		return nil, errBadRequest
	}
	return array, nil
}

func lastItem(array *paramArray) any {
	if len(array.items) == 0 {
		return nil
	}
	return array.items[len(array.items)-1]
}

func rackHashHasKey(hash *paramHash, key string) bool {
	if strings.Contains(key, "[]") {
		return false
	}
	var current any = hash
	for _, part := range rackKeySplitPattern.Split(key, -1) {
		if part == "" {
			continue
		}
		currentHash, ok := current.(*paramHash)
		if !ok || !currentHash.has(part) {
			return false
		}
		current = currentHash.get(part)
	}
	return true
}

// normalizeParam ports ActionDispatch's NoNilParamEncoder: it walks the params
// and drops nils from every array.
func normalizeParam(value any) any {
	switch v := value.(type) {
	case *paramArray:
		return normalizeParam(v.items)
	case []any:
		items := []any{}
		for _, item := range v {
			if normalized := normalizeParam(item); normalized != nil {
				items = append(items, normalized)
			}
		}
		return items
	case *paramHash:
		hash := newParamHash()
		for _, key := range v.keys {
			hash.set(key, normalizeParam(v.get(key)))
		}
		return hash
	}
	return value
}
