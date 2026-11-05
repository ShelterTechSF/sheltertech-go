package newsarticles

import (
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"
	"time"

	"github.com/DATA-DOG/go-sqlmock"
	"github.com/go-chi/chi/v5"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

// The expected statuses, headers and bodies in this file are what
// askdarcel-api (Rails) returned for the same requests.

var articleColumns = []string{"id", "headline", "body", "priority", "url", "effective_date", "expiration_date"}

func newTestRouter(t *testing.T) (http.Handler, sqlmock.Sqlmock) {
	t.Helper()
	sqlDB, mock, err := sqlmock.New()
	require.NoError(t, err)
	t.Cleanup(func() {
		assert.NoError(t, mock.ExpectationsWereMet())
		sqlDB.Close()
	})
	manager := New(&db.Manager{DB: sqlDB})
	router := chi.NewRouter()
	manager.RegisterRoutes(router)
	return router, mock
}

func serve(router http.Handler, method, target, body string) *httptest.ResponseRecorder {
	req := httptest.NewRequest(method, target, strings.NewReader(body))
	req.Header.Set("Content-Type", "application/json")
	req.Header.Set("Accept", "application/json")
	w := httptest.NewRecorder()
	router.ServeHTTP(w, req)
	return w
}

func TestCreate_FrontendPayloadWithTrailingSlash(t *testing.T) {
	router, mock := newTestRouter(t)
	mock.ExpectQuery(`INSERT INTO public\.news_articles`).
		WithArgs("Headline", "Body", int64(2), "", time.Date(2026, time.August, 15, 0, 0, 0, 0, time.UTC), nil).
		WillReturnRows(sqlmock.NewRows([]string{"id"}).AddRow(1))

	w := serve(router, http.MethodPost, "/api/news_articles/",
		`{"id":"","body":"Body","effective_date":"2026-08-15","expiration_date":"","headline":"Headline","priority":"2","url":""}`)

	assert.Equal(t, http.StatusCreated, w.Code)
	assert.Equal(t, "application/json; charset=utf-8", w.Header().Get("Content-Type"))
	assert.Equal(t, "max-age=1, public", w.Header().Get("Cache-Control"))
	assert.Equal(t,
		`{"news_article":{"id":1,"headline":"Headline","effective_date":"2026-08-15T00:00:00.000Z","body":"Body","priority":2,"expiration_date":null,"url":""}}`,
		w.Body.String())
}

func TestCreate_PriorityOutOfRangeIsServerError(t *testing.T) {
	router, _ := newTestRouter(t)
	w := serve(router, http.MethodPost, "/api/news_articles", `{"headline":"big","priority":"99999999999"}`)
	assert.Equal(t, http.StatusInternalServerError, w.Code)
	assert.Equal(t, `{"status":500,"error":"Internal Server Error"}`, w.Body.String())
}

func TestCreate_InvalidJSONIsBadRequest(t *testing.T) {
	router, _ := newTestRouter(t)
	w := serve(router, http.MethodPost, "/api/news_articles", `{not json`)
	assert.Equal(t, http.StatusBadRequest, w.Code)
	assert.Equal(t, "application/json; charset=UTF-8", w.Header().Get("Content-Type"))
	assert.Equal(t, `{"status":400,"error":"Bad Request"}`, w.Body.String())
}

func TestUpdate_ClearsFieldsMissingFromTheRequest(t *testing.T) {
	router, mock := newTestRouter(t)
	mock.ExpectQuery(`SELECT .* FROM public\.news_articles WHERE id = \$1`).WithArgs(int64(2)).
		WillReturnRows(sqlmock.NewRows(articleColumns).
			AddRow(2, "Headline", "Body", 3, "https://x.org", time.Date(2026, time.August, 15, 0, 0, 0, 0, time.UTC), nil))
	mock.ExpectExec(`UPDATE public\.news_articles`).
		WithArgs(2, "Only headline", nil, nil, nil, nil, nil).
		WillReturnResult(sqlmock.NewResult(0, 1))

	w := serve(router, http.MethodPut, "/api/news_articles/2", `{"headline":"Only headline"}`)

	assert.Equal(t, http.StatusOK, w.Code)
	assert.Equal(t,
		`{"news_article":{"id":2,"headline":"Only headline","effective_date":null,"body":null,"priority":null,"expiration_date":null,"url":null}}`,
		w.Body.String())
}

func TestUpdate_UnchangedValuesSkipTheWrite(t *testing.T) {
	router, mock := newTestRouter(t)
	mock.ExpectQuery(`SELECT .* FROM public\.news_articles WHERE id = \$1`).WithArgs(int64(6)).
		WillReturnRows(sqlmock.NewRows(articleColumns).AddRow(6, "Six", nil, nil, nil, nil, nil))

	// The id "6abc" is read with Ruby's to_i, as Rails did.
	w := serve(router, http.MethodPatch, "/api/news_articles/6abc", `{"news_article":{"headline":"Six"}}`)

	assert.Equal(t, http.StatusOK, w.Code)
}

func TestUpdate_MissingArticleIsNotFound(t *testing.T) {
	router, mock := newTestRouter(t)
	mock.ExpectQuery(`SELECT .* FROM public\.news_articles WHERE id = \$1`).WithArgs(int64(0)).
		WillReturnRows(sqlmock.NewRows(articleColumns))

	w := serve(router, http.MethodPut, "/api/news_articles/abc", `{"headline":"Nope"}`)

	assert.Equal(t, http.StatusNotFound, w.Code)
	assert.Equal(t, `{"status":404,"error":"Not Found"}`, w.Body.String())
}

func TestDelete_RespondsWithASingleSpace(t *testing.T) {
	router, mock := newTestRouter(t)
	mock.ExpectQuery(`SELECT .* FROM public\.news_articles WHERE id = \$1`).WithArgs(int64(8)).
		WillReturnRows(sqlmock.NewRows(articleColumns).AddRow(8, "p1", nil, 0, nil, nil, nil))
	mock.ExpectExec(`DELETE FROM public\.news_articles WHERE id = \$1`).WithArgs(8).
		WillReturnResult(sqlmock.NewResult(0, 1))

	w := serve(router, http.MethodDelete, "/api/news_articles/8", "")

	assert.Equal(t, http.StatusOK, w.Code)
	assert.Equal(t, "text/plain; charset=utf-8", w.Header().Get("Content-Type"))
	assert.Equal(t, `W/"36a9e7f1c95b82ffb99743e0c5c4ce95"`, w.Header().Get("ETag"))
	assert.Equal(t, " ", w.Body.String())
}

func TestGet_ActiveParamAndConditionalGet(t *testing.T) {
	router, mock := newTestRouter(t)
	mock.ExpectQuery(`effective_date <= timezone\('UTC', NOW\(\)\)`).WillReturnRows(sqlmock.NewRows(articleColumns))
	mock.ExpectQuery(`SELECT .* FROM public\.news_articles$`).WillReturnRows(sqlmock.NewRows(articleColumns))

	// Any non-blank value, even "false", selects active articles.
	w := serve(router, http.MethodGet, "/api/news_articles?active=false&unknown=1", "")
	assert.Equal(t, http.StatusOK, w.Code)
	assert.Equal(t, `{"news_articles":[]}`, w.Body.String())

	req := httptest.NewRequest(http.MethodGet, "/api/news_articles.json", nil)
	req.Header.Set("If-None-Match", w.Header().Get("ETag"))
	conditional := httptest.NewRecorder()
	router.ServeHTTP(conditional, req)
	assert.Equal(t, http.StatusNotModified, conditional.Code)
	assert.Empty(t, conditional.Body.String())
}

func TestRoutes_UnknownActionsAreNotFound(t *testing.T) {
	router, _ := newTestRouter(t)
	for _, method := range []string{http.MethodGet, http.MethodPost} {
		w := serve(router, method, "/api/news_articles/1", "{}")
		assert.Equal(t, http.StatusNotFound, w.Code, method)
		assert.Equal(t, `{"status":404,"error":"Not Found"}`, w.Body.String(), method)
	}
}
