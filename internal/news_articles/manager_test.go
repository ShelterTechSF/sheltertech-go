package newsarticles

import (
	"database/sql"
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

func TestManager_CreateAcceptsDateOnlyPayload(t *testing.T) {
	sqlDB, mock, err := sqlmock.New()
	require.NoError(t, err)
	defer sqlDB.Close()

	effectiveDate := time.Date(2026, time.August, 15, 0, 0, 0, 0, time.UTC)
	expirationDate := time.Date(2026, time.September, 15, 0, 0, 0, 0, time.UTC)

	mock.ExpectQuery(`INSERT INTO public\.news_articles \(`).
		WithArgs(
			"Date-only create",
			"Body",
			1,
			"https://example.com/news",
			effectiveDate,
			expirationDate,
		).
		WillReturnRows(sqlmock.NewRows([]string{
			"id",
			"headline",
			"body",
			"priority",
			"url",
			"effective_date",
			"expiration_date",
		}).AddRow(
			10,
			sql.NullString{String: "Date-only create", Valid: true},
			sql.NullString{String: "Body", Valid: true},
			sql.NullInt32{Int32: 1, Valid: true},
			sql.NullString{String: "https://example.com/news", Valid: true},
			sql.NullTime{Time: effectiveDate, Valid: true},
			sql.NullTime{Time: expirationDate, Valid: true},
		))

	manager := New(&db.Manager{DB: sqlDB})
	req := httptest.NewRequest(http.MethodPost, "/api/news_articles", strings.NewReader(`{
		"headline": "Date-only create",
		"body": "Body",
		"priority": 1,
		"url": "https://example.com/news",
		"effective_date": "2026-08-15",
		"expiration_date": "2026-09-15"
	}`))
	w := httptest.NewRecorder()

	manager.Create(w, req)

	assert.Equal(t, http.StatusCreated, w.Code)
	assert.JSONEq(t, `{
		"id": 10,
		"headline": "Date-only create",
		"body": "Body",
		"priority": 1,
		"url": "https://example.com/news",
		"effective_date": "2026-08-15T00:00:00Z",
		"expiration_date": "2026-09-15T00:00:00Z"
	}`, w.Body.String())
	assert.NoError(t, mock.ExpectationsWereMet())
}

func TestManager_UpdateAcceptsDateOnlyPayload(t *testing.T) {
	sqlDB, mock, err := sqlmock.New()
	require.NoError(t, err)
	defer sqlDB.Close()

	effectiveDate := time.Date(2026, time.October, 1, 0, 0, 0, 0, time.UTC)
	expirationDate := time.Date(2026, time.October, 31, 0, 0, 0, 0, time.UTC)

	mock.ExpectPrepare(`SELECT na\.id, na\.headline, na\.body, na\.priority, na\.url, na\.effective_date, na\.expiration_date\s+FROM public\.news_articles na\s+WHERE na\.id = ANY \(\$1\)`).
		ExpectQuery().
		WithArgs(sqlmock.AnyArg()).
		WillReturnRows(sqlmock.NewRows([]string{
			"id",
			"headline",
			"body",
			"priority",
			"url",
			"effective_date",
			"expiration_date",
		}).AddRow(
			35,
			sql.NullString{String: "Existing", Valid: true},
			sql.NullString{String: "Existing body", Valid: true},
			sql.NullInt32{Int32: 2, Valid: true},
			sql.NullString{String: "https://example.com/existing", Valid: true},
			sql.NullTime{},
			sql.NullTime{},
		))

	mock.ExpectQuery(`UPDATE public\.news_articles`).
		WithArgs(
			35,
			nil,
			nil,
			nil,
			nil,
			effectiveDate,
			expirationDate,
		).
		WillReturnRows(sqlmock.NewRows([]string{
			"id",
			"headline",
			"body",
			"priority",
			"url",
			"effective_date",
			"expiration_date",
		}).AddRow(
			35,
			sql.NullString{String: "Existing", Valid: true},
			sql.NullString{String: "Existing body", Valid: true},
			sql.NullInt32{Int32: 2, Valid: true},
			sql.NullString{String: "https://example.com/existing", Valid: true},
			sql.NullTime{Time: effectiveDate, Valid: true},
			sql.NullTime{Time: expirationDate, Valid: true},
		))

	manager := New(&db.Manager{DB: sqlDB})
	router := chi.NewRouter()
	router.Put("/api/news_articles/{id}", manager.Update)

	req := httptest.NewRequest(http.MethodPut, "/api/news_articles/35", strings.NewReader(`{
		"effective_date": "2026-10-01",
		"expiration_date": "2026-10-31"
	}`))
	w := httptest.NewRecorder()

	router.ServeHTTP(w, req)

	assert.Equal(t, http.StatusOK, w.Code)
	assert.JSONEq(t, `{
		"id": 35,
		"headline": "Existing",
		"body": "Existing body",
		"priority": 2,
		"url": "https://example.com/existing",
		"effective_date": "2026-10-01T00:00:00Z",
		"expiration_date": "2026-10-31T00:00:00Z"
	}`, w.Body.String())
	assert.NoError(t, mock.ExpectationsWereMet())
}
