// Package newsarticles serves the breaking-news endpoints. They reproduce the
// Rails NewsArticlesController (askdarcel-api) request for request: the same
// params parsing and type casting, routes, status codes, headers and response
// bodies, and the same database writes.
package newsarticles

import (
	"crypto/sha256"
	"encoding/hex"
	"encoding/json"
	"errors"
	"fmt"
	"log"
	"math"
	"math/big"
	"net/http"
	"strconv"
	"time"

	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
)

type Manager struct {
	DbClient *db.Manager
	// now supplies the date Rails filled in for partial dates such as "10:30".
	now func() time.Time
}

func New(dbManager *db.Manager) *Manager {
	return &Manager{DbClient: dbManager, now: time.Now}
}

// RegisterRoutes registers every URL Rails routed to NewsArticlesController:
// the resource routes, the extra /{news_article_id}/create|index|update|destroy
// routes that askdarcel-api's config/routes.rb generated, an optional trailing
// slash, and an optional format suffix such as ".json". Any other method or
// path under /api/news_articles gets Rails' 404.
func (m *Manager) RegisterRoutes(r chi.Router) {
	r.Get("/api/news_articles.{format}", m.Get)
	r.Post("/api/news_articles.{format}", m.Create)
	r.Route("/api/news_articles", func(r chi.Router) {
		r.Use(middleware.GetHead)
		r.NotFound(writeRailsNotFound)
		r.MethodNotAllowed(writeRailsNotFound)

		r.Get("/", m.Get)
		r.Post("/", m.Create)
		// The id segment may carry a format suffix ("7.json"); Rails' to_i
		// conversion of the id ignores it.
		for _, suffix := range []string{"", "/"} {
			r.Put("/{id}"+suffix, m.Update)
			r.Patch("/{id}"+suffix, m.Update)
			r.Delete("/{id}"+suffix, m.Delete)
		}
		for _, suffix := range []string{"", "/", ".{format}", ".{format}/"} {
			r.Post("/{news_article_id}/create"+suffix, m.Create)
			r.Get("/{news_article_id}/index"+suffix, m.Get)
			// These two read the id from the query string or body, as Rails did.
			r.Put("/{news_article_id}/update"+suffix, m.Update)
			r.Delete("/{news_article_id}/destroy"+suffix, m.Delete)
		}
	})
}

// Get lists news articles
//
//	@Summary        Get News Articles
//	@Description    List news articles. Any non-blank `active` value limits the list to articles in effect now.
//	@Tags           news_articles
//	@Produce        json
//	@Param          active query string false "Any non-blank value returns only active articles"
//	@Success        200 {object} newsarticles.NewsArticles
//	@Router         /news_articles [get]
func (m *Manager) Get(w http.ResponseWriter, r *http.Request) {
	params, ok := parseParams(w, r)
	if !ok {
		return
	}
	var articles []*db.NewsArticle
	var err error
	if isRubyPresent(params.get("active")) {
		articles, err = m.DbClient.GetActiveNewsArticles()
	} else {
		articles, err = m.DbClient.GetNewsArticles()
	}
	if err != nil {
		writeRailsServerError(w, err)
		return
	}
	writeRailsJSON(w, r, http.StatusOK, NewsArticles{NewsArticles: FromNewsArticlesDBTypeArray(articles)})
}

// Create creates a news article
//
//	@Summary        Create News Article
//	@Description    Create a news article from a JSON body (flat, or wrapped in `news_article`) or form fields `news_article[...]`.
//	@Tags           news_articles
//	@Accept         json
//	@Produce        json
//	@Success        201 {object} newsarticles.NewsArticleResponse
//	@Failure        400 "Malformed request body"
//	@Router         /news_articles [post]
func (m *Manager) Create(w http.ResponseWriter, r *http.Request) {
	params, ok := parseParams(w, r)
	if !ok {
		return
	}
	fields, err := m.fieldsFromParams(params)
	if err != nil {
		writeRailsServerError(w, err)
		return
	}
	id, err := m.DbClient.CreateNewsArticle(fields)
	if err != nil {
		writeRailsServerError(w, err)
		return
	}
	writeRailsJSON(w, r, http.StatusCreated, NewsArticleResponse{NewsArticle: newsArticleFromFields(id, fields)})
}

// Update replaces a news article
//
//	@Summary        Update News Article
//	@Description    Overwrite every field of a news article. Fields missing from the request are cleared.
//	@Tags           news_articles
//	@Accept         json
//	@Produce        json
//	@Param          id path integer true "News Article ID"
//	@Success        200 {object} newsarticles.NewsArticleResponse
//	@Failure        400 "Malformed request body"
//	@Failure        404 "News article not found"
//	@Router         /news_articles/{id} [put]
func (m *Manager) Update(w http.ResponseWriter, r *http.Request) {
	params, ok := parseParams(w, r)
	if !ok {
		return
	}
	article, ok := m.findArticle(w, params.get("id"))
	if !ok {
		return
	}
	fields, err := m.fieldsFromParams(params)
	if err != nil {
		writeRailsServerError(w, err)
		return
	}
	// Like ActiveRecord#save, write (and bump updated_at) only when a value changed.
	if !sameFields(fields, fieldsFromDBType(article)) {
		if err := m.DbClient.UpdateNewsArticle(article.Id, fields); err != nil {
			writeRailsServerError(w, err)
			return
		}
	}
	writeRailsJSON(w, r, http.StatusOK, NewsArticleResponse{NewsArticle: newsArticleFromFields(article.Id, fields)})
}

// Delete deletes a news article
//
//	@Summary        Delete News Article
//	@Description    Delete a news article. The response body is a single space, as Rails sent.
//	@Tags           news_articles
//	@Param          id path integer true "News Article ID"
//	@Success        200
//	@Failure        404 "News article not found"
//	@Router         /news_articles/{id} [delete]
func (m *Manager) Delete(w http.ResponseWriter, r *http.Request) {
	params, ok := parseParams(w, r)
	if !ok {
		return
	}
	article, ok := m.findArticle(w, params.get("id"))
	if !ok {
		return
	}
	if err := m.DbClient.DeleteNewsArticle(article.Id); err != nil {
		writeRailsServerError(w, err)
		return
	}
	writeRailsBody(w, r, http.StatusOK, "text/plain; charset=utf-8", []byte(" "))
}

// errNewsArticleNotAHash is the NoMethodError or TypeError Rails raised (500)
// when params["news_article"] was missing or not a hash.
var errNewsArticleNotAHash = errors.New("news_article param is not a hash")

// errFoundMultipleArticles is the NoMethodError Rails raised (500) when an
// array of ids found several records and the action called a record method on
// the array.
var errFoundMultipleArticles = errors.New("id param is an array")

func (m *Manager) fieldsFromParams(params *paramHash) (db.NewsArticleFields, error) {
	article, ok := params.get("news_article").(*paramHash)
	if !ok {
		return db.NewsArticleFields{}, errNewsArticleNotAHash
	}
	priority, err := castInteger(article.get("priority"))
	if err != nil {
		return db.NewsArticleFields{}, err
	}
	now := m.now()
	return db.NewsArticleFields{
		Headline:       castString(article.get("headline")),
		Body:           castString(article.get("body")),
		Priority:       priority,
		Url:            castString(article.get("url")),
		EffectiveDate:  castDateTime(article.get("effective_date"), now),
		ExpirationDate: castDateTime(article.get("expiration_date"), now),
	}, nil
}

// findArticle ports NewsArticle.find(params[:id]) and writes the 404 or 500
// Rails returned when it did not produce a single record.
func (m *Manager) findArticle(w http.ResponseWriter, idParam any) (*db.NewsArticle, bool) {
	ids, isArray := castIDs(idParam)
	if isArray && len(ids) == 0 {
		writeRailsServerError(w, errFoundMultipleArticles)
		return nil, false
	}
	var found *db.NewsArticle
	for _, id := range ids {
		if id == nil {
			writeRailsNotFound(w, nil)
			return nil, false
		}
		article, err := m.DbClient.GetNewsArticleByID(*id)
		if err != nil {
			writeRailsServerError(w, err)
			return nil, false
		}
		if article == nil {
			writeRailsNotFound(w, nil)
			return nil, false
		}
		found = article
	}
	if found == nil {
		writeRailsNotFound(w, nil)
		return nil, false
	}
	if isArray {
		writeRailsServerError(w, errFoundMultipleArticles)
		return nil, false
	}
	return found, true
}

// castIDs converts an id param the way ActiveRecord cast it for a bigint
// primary key. A nil entry is an id that cannot match a row (blank, or out of
// range). An array param returns each distinct element.
func castIDs(value any) ([]*int64, bool) {
	if items, ok := value.([]any); ok {
		seen := map[string]bool{}
		ids := []*int64{}
		for _, item := range items {
			key := fmt.Sprint(item)
			if !seen[key] {
				seen[key] = true
				ids = append(ids, castID(item))
			}
		}
		return ids, true
	}
	if value == nil {
		return nil, false
	}
	return []*int64{castID(value)}, false
}

func castID(value any) *int64 {
	var n *big.Int
	switch v := value.(type) {
	case string:
		if isRubyBlank(v) {
			return nil
		}
		n = rubyStringToI(v)
	case bool:
		n = big.NewInt(0)
		if v {
			n = big.NewInt(1)
		}
	case json.Number:
		if isIntegerLiteral(v) {
			n, _ = new(big.Int).SetString(v.String(), 10)
			break
		}
		f, _ := strconv.ParseFloat(v.String(), 64)
		if math.IsInf(f, 0) {
			return nil
		}
		n, _ = big.NewFloat(f).Int(nil)
	default:
		return nil
	}
	if !n.IsInt64() {
		return nil
	}
	id := n.Int64()
	return &id
}

func sameFields(a, b db.NewsArticleFields) bool {
	sameString := func(x, y *string) bool { return (x == nil) == (y == nil) && (x == nil || *x == *y) }
	sameTime := func(x, y *time.Time) bool { return (x == nil) == (y == nil) && (x == nil || x.Equal(*y)) }
	samePriority := (a.Priority == nil) == (b.Priority == nil) && (a.Priority == nil || *a.Priority == *b.Priority)
	return sameString(a.Headline, b.Headline) && sameString(a.Body, b.Body) && sameString(a.Url, b.Url) &&
		samePriority && sameTime(a.EffectiveDate, b.EffectiveDate) && sameTime(a.ExpirationDate, b.ExpirationDate)
}

// parseParams builds the Rails params hash, writing Rails' 400 when the query
// string or body could not be parsed.
func parseParams(w http.ResponseWriter, r *http.Request) (*paramHash, bool) {
	params, err := requestParams(r)
	if err != nil {
		log.Printf("news articles: rejecting unparseable request: %v", err)
		writeRailsError(w, http.StatusBadRequest)
		return nil, false
	}
	return params, true
}

func writeRailsJSON(w http.ResponseWriter, r *http.Request, status int, value interface{}) {
	body, err := json.Marshal(value)
	if err != nil {
		writeRailsServerError(w, err)
		return
	}
	writeRailsBody(w, r, status, "application/json; charset=utf-8", body)
}

// writeRailsBody writes a successful response with the headers Rails added:
// Cache-Control from the controller's `expires_in 1.second, public: true`, and
// Rack's weak ETag (the first 32 hex digits of the body's SHA-256), answering a
// matching If-None-Match on GET or HEAD with 304.
func writeRailsBody(w http.ResponseWriter, r *http.Request, status int, contentType string, body []byte) {
	header := w.Header()
	header.Set("Cache-Control", "max-age=1, public")
	if (status == http.StatusOK || status == http.StatusCreated) && len(body) > 0 {
		digest := sha256.Sum256(body)
		etag := `W/"` + hex.EncodeToString(digest[:])[:32] + `"`
		header.Set("ETag", etag)
		isRead := r.Method == http.MethodGet || r.Method == http.MethodHead
		if status == http.StatusOK && isRead && r.Header.Get("If-None-Match") == etag {
			w.WriteHeader(http.StatusNotModified)
			return
		}
	}
	header.Set("Content-Type", contentType)
	w.WriteHeader(status)
	if _, err := w.Write(body); err != nil {
		log.Printf("news articles: writing response: %v", err)
	}
}

// writeRailsError writes the body Rails' public exceptions app rendered for
// JSON requests, e.g. {"status":404,"error":"Not Found"}.
func writeRailsError(w http.ResponseWriter, status int) {
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")
	w.WriteHeader(status)
	body := fmt.Sprintf(`{"status":%d,"error":%q}`, status, http.StatusText(status))
	if _, err := w.Write([]byte(body)); err != nil {
		log.Printf("news articles: writing error response: %v", err)
	}
}

func writeRailsNotFound(w http.ResponseWriter, _ *http.Request) {
	writeRailsError(w, http.StatusNotFound)
}

func writeRailsServerError(w http.ResponseWriter, err error) {
	log.Printf("news articles: %v", err)
	writeRailsError(w, http.StatusInternalServerError)
}
