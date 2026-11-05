package eligibilities

import (
	"github.com/DATA-DOG/go-sqlmock"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
	"github.com/stretchr/testify/require"
	"net/http/httptest"
	"testing"
)

func TestFeaturedIncludesRailsCountsAndNulls(t *testing.T) {
	database, mock, err := sqlmock.New()
	require.NoError(t, err)
	defer database.Close()
	mock.ExpectQuery("SELECT e.id, e.name, e.feature_rank").WillReturnRows(sqlmock.NewRows([]string{"id", "name", "feature_rank", "service_count", "resource_count"}).AddRow(1, "Seniors", 1, 3, 2).AddRow(2, "Families", 2, nil, nil))
	w := httptest.NewRecorder()
	New(&db.Manager{DB: database}).GetFeaturedEligibilities(w, httptest.NewRequest("GET", "/api/eligibilities/featured", nil))
	require.Equal(t, 200, w.Code)
	require.JSONEq(t, `{"eligibilities":[{"id":1,"name":"Seniors","feature_rank":1,"service_count":3,"resource_count":2},{"id":2,"name":"Families","feature_rank":2,"service_count":null,"resource_count":null}]}`, w.Body.String())
	require.NoError(t, mock.ExpectationsWereMet())
}
