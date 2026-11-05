package db

import (
	"github.com/DATA-DOG/go-sqlmock"
	"github.com/stretchr/testify/require"
	"testing"
)

func TestCategoryEligibilitiesPreserveAssociationOrder(t *testing.T) {
	database, mock, err := sqlmock.New()
	require.NoError(t, err)
	defer database.Close()
	// Rails does not order the category-filtered query by name (report case 19).
	require.NotContains(t, eligibilitiesByCategoryIDSql, "ORDER BY")
	mock.ExpectPrepare("SELECT e.id, e.name, e.feature_rank").ExpectQuery().WithArgs(9).WillReturnRows(sqlmock.NewRows([]string{"id", "name", "feature_rank"}).AddRow(4, "Seniors", 1).AddRow(2, "Families", 3))
	id := 9
	got := (&Manager{DB: database}).GetEligibilitiesByCategoryId(&id)
	require.Len(t, got, 2)
	require.Equal(t, 4, got[0].Id)
	require.Equal(t, 2, got[1].Id)
	require.NoError(t, mock.ExpectationsWereMet())
}
