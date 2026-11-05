package newsarticles

import (
	"github.com/DATA-DOG/go-sqlmock"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
	"github.com/stretchr/testify/require"
	"net/http/httptest"
	"testing"
	"time"
)

func TestNewsListRailsDatesAndDatabaseOrder(t *testing.T) {
	for _, query := range []string{"", "?active=true", "?unused=ignored", "?active=%20"} {
		t.Run(query, func(t *testing.T) {
			database, mock, err := sqlmock.New()
			require.NoError(t, err)
			defer database.Close()
			sql := "SELECT na.id.*FROM public.news_articles na"
			if query == "?active=true" {
				sql += " WHERE.*NOW"
			}
			mock.ExpectPrepare(sql).ExpectQuery().WillReturnRows(sqlmock.NewRows([]string{"id", "headline", "body", "priority", "url", "effective_date", "expiration_date"}).AddRow(2, "First", nil, 1, nil, time.Date(2026, 1, 1, 0, 0, 0, 0, time.UTC), nil).AddRow(1, "Second", nil, 99, nil, nil, nil))
			w := httptest.NewRecorder()
			New(&db.Manager{DB: database}).Get(w, httptest.NewRequest("GET", "/api/news_articles"+query, nil))
			require.Equal(t, 200, w.Code)
			require.JSONEq(t, `{"news_articles":[{"id":2,"headline":"First","body":null,"priority":1,"url":null,"effective_date":"2026-01-01T00:00:00.000Z","expiration_date":null},{"id":1,"headline":"Second","body":null,"priority":99,"url":null,"effective_date":null,"expiration_date":null}]}`, w.Body.String())
			require.NoError(t, mock.ExpectationsWereMet())
		})
	}
}
