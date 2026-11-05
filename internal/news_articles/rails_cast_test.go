package newsarticles

import (
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"
	"time"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

// The expected values in this file are what askdarcel-api (Rails 6.1,
// Ruby 2.7) stored or returned for the same input.

func decodeParam(t *testing.T, raw string) any {
	t.Helper()
	value, err := decodeOrderedJSON([]byte(raw))
	require.NoError(t, err)
	return normalizeParam(value)
}

func TestCastString(t *testing.T) {
	cases := map[string]any{
		`"Headline"`:           "Headline",
		`""`:                   "",
		`123`:                  "123",
		`true`:                 "t",
		`false`:                "f",
		`1.0e+20`:              "1.0e+20",
		`0.00001`:              "1.0e-05",
		`1E2`:                  "100.0",
		`-0.5`:                 "-0.5",
		`["a", 1, null, true]`: `["a", 1, true]`,
		`{"k": "v", "n": 2}`:   `{"k"=>"v", "n"=>2}`,
		`["a\"b\n", "é", "\u0001", "#{x}", [null]]`: `["a\"b\n", "é", "\u0001", "\#{x}", []]`,
		`null`: nil,
	}
	for raw, want := range cases {
		got := castString(decodeParam(t, raw))
		if want == nil {
			assert.Nil(t, got, raw)
			continue
		}
		require.NotNil(t, got, raw)
		assert.Equal(t, want, *got, raw)
	}
}

func TestRubyFloatToS(t *testing.T) {
	cases := map[float64]string{
		1e14: "100000000000000.0", 999999999999999.0: "999999999999999.0", 1e15: "1.0e+15",
		1234567890123456.0: "1.234567890123456e+15", 0.0001: "0.0001", 2.5e-5: "2.5e-05",
		123456789.123456789: "123456789.12345679", 1.0: "1.0",
	}
	for f, want := range cases {
		assert.Equal(t, want, rubyFloatToS(f), "%v", f)
	}
}

func TestCastInteger(t *testing.T) {
	cases := map[string]any{
		`"2"`: int64(2), `"abc"`: int64(0), `"2.7"`: int64(2), `2.7`: int64(2), `" 12abc"`: int64(12),
		`"-1_000"`: int64(-1000), `"0d12"`: int64(12), `"1__2"`: int64(1), `true`: int64(1),
		`""`: nil, `"  "`: nil, `null`: nil, `[1]`: nil, `{"a": 1}`: nil,
	}
	for raw, want := range cases {
		got, err := castInteger(decodeParam(t, raw))
		require.NoError(t, err, raw)
		if want == nil {
			assert.Nil(t, got, raw)
			continue
		}
		require.NotNil(t, got, raw)
		assert.Equal(t, want, *got, raw)
	}

	for _, raw := range []string{`"99999999999"`, `3000000000`} {
		_, err := castInteger(decodeParam(t, raw))
		assert.ErrorIs(t, err, errIntegerOutOfRange, raw)
	}
}

func TestCastDateTime(t *testing.T) {
	now := time.Date(2026, time.November, 4, 12, 0, 0, 0, time.UTC)
	cases := map[string]string{
		"2026-08-15":                      "2026-08-15T00:00:00.000Z",
		"2026-08-15T10:00:00-07:00":       "2026-08-15T17:00:00.000Z",
		"2099-01-02T03:04:05.123456Z":     "2099-01-02T03:04:05.123Z",
		"2026-08-15 10:30":                "2026-08-15T10:30:00.000Z",
		"Aug 15 2026":                     "2026-08-15T00:00:00.000Z",
		"2026-02-30":                      "2026-03-02T00:00:00.000Z",
		"2026-08-15abc":                   "2026-08-15T00:00:00.000Z",
		"Sat, 15 Aug 2026 10:00:00 -0700": "2026-08-15T17:00:00.000Z",
		"August 15, 2026 3:45 PM":         "2026-08-15T15:45:00.000Z",
		"2026-08-15T24:00:00":             "2026-08-16T00:00:00.000Z",
		"2026-08-15 10:00 PST":            "2026-08-15T18:00:00.000Z",
	}
	for input, want := range cases {
		got := castDateTime(input, now)
		require.NotNil(t, got, input)
		assert.Equal(t, want, got.UTC().Format(railsTimeLayout), input)
	}

	for _, input := range []any{"", "garbage", "2026-08-32", "2026-08-15" + strings.Repeat(" ", 125), json.Number("20260815"), true, nil} {
		assert.Nil(t, castDateTime(input, now), "%#v", input)
	}
}

func TestRequestParams(t *testing.T) {
	newRequest := func(target, contentType, body string) *http.Request {
		req := httptest.NewRequest(http.MethodPost, target, strings.NewReader(body))
		if contentType != "" {
			req.Header.Set("Content-Type", contentType)
		}
		return req
	}
	headline := func(t *testing.T, req *http.Request) any {
		t.Helper()
		params, err := requestParams(req)
		require.NoError(t, err)
		article, ok := params.get("news_article").(*paramHash)
		if !ok {
			return params.get("news_article")
		}
		return article.get("headline")
	}

	t.Run("wraps a flat JSON body", func(t *testing.T) {
		assert.Equal(t, "Flat", headline(t, newRequest("/", "application/json", `{"headline": "Flat"}`)))
	})
	t.Run("uses an explicit news_article key over top-level keys", func(t *testing.T) {
		assert.Equal(t, "Inner", headline(t, newRequest("/", "application/json", `{"news_article": {"headline": "Inner"}, "headline": "Outer"}`)))
	})
	t.Run("parses nested form keys", func(t *testing.T) {
		assert.Equal(t, "Form", headline(t, newRequest("/", "application/x-www-form-urlencoded", "news_article[headline]=Form")))
	})
	t.Run("reads the query string when there is no body", func(t *testing.T) {
		assert.Equal(t, "Q", headline(t, newRequest("/?news_article[headline]=Q", "", "")))
	})
	t.Run("does not wrap a body without a JSON content type", func(t *testing.T) {
		assert.Nil(t, headline(t, newRequest("/", "", `{"headline": "noct"}`)))
	})
	t.Run("rejects malformed input", func(t *testing.T) {
		for _, req := range []*http.Request{
			newRequest("/", "application/json", "{not json"),
			newRequest("/", "application/x-www-form-urlencoded", "news_article[headline]=a&news_article[headline][x]=b"),
			newRequest("/?a=%zz", "", ""),
		} {
			_, err := requestParams(req)
			assert.ErrorIs(t, err, errBadRequest)
		}
	})
}

func TestIsRubyPresent(t *testing.T) {
	for raw, want := range map[string]bool{`"true"`: true, `"false"`: true, `"yes"`: true, `[""]`: true, `""`: false, `" "`: false, `false`: false, `null`: false} {
		assert.Equal(t, want, isRubyPresent(decodeParam(t, raw)), raw)
	}
}
