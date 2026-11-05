package searchindex

import (
	"context"
	"encoding/json"
	"errors"
	"os"
	"testing"

	"github.com/DATA-DOG/go-sqlmock"
	"github.com/stretchr/testify/require"
)

type resourceRecordingIndex struct {
	savedID   string
	record    interface{}
	deletedID string
	err       error
}

func (i *resourceRecordingIndex) SaveObject(id string, record interface{}) error {
	i.savedID, i.record = id, record
	return i.err
}
func (i *resourceRecordingIndex) DeleteObject(id string) error { i.deletedID = id; return i.err }

func TestRebuildResourceMatchesRailsRecord(t *testing.T) {
	// Captured from the Rails model serializer, with synthetic fixture data.
	source, err := os.ReadFile("testdata/resource_source.json")
	require.NoError(t, err)
	expected, err := os.ReadFile("testdata/resource_rails.json")
	require.NoError(t, err)
	database, mock, err := sqlmock.New()
	require.NoError(t, err)
	defer database.Close()
	mock.ExpectQuery("SELECT json_build_object").WithArgs(1700000013).
		WillReturnRows(sqlmock.NewRows([]string{"json"}).AddRow(source))
	index := &resourceRecordingIndex{}
	require.NoError(t, RebuildResource(context.Background(), database, index, 1700000013))
	require.Equal(t, "resource_1700000013", index.savedID)
	actual, err := json.Marshal(index.record)
	require.NoError(t, err)
	require.JSONEq(t, string(expected), string(actual))
	require.NoError(t, mock.ExpectationsWereMet())
}

func TestRebuildResourceVisibilityAndErrors(t *testing.T) {
	for _, status := range []interface{}{0, 2, 3, nil} {
		database, mock, err := sqlmock.New()
		require.NoError(t, err)
		source, err := json.Marshal(map[string]interface{}{"resource": map[string]interface{}{"status": status}})
		require.NoError(t, err)
		mock.ExpectQuery("SELECT json_build_object").WithArgs(42).
			WillReturnRows(sqlmock.NewRows([]string{"json"}).AddRow(source))
		index := &resourceRecordingIndex{}
		require.NoError(t, RebuildResource(context.Background(), database, index, 42))
		require.Equal(t, "resource_42", index.deletedID)
		require.Empty(t, index.savedID)
		require.NoError(t, mock.ExpectationsWereMet())
		database.Close()
	}
	database, mock, err := sqlmock.New()
	require.NoError(t, err)
	defer database.Close()
	index := &resourceRecordingIndex{}
	mock.ExpectQuery("SELECT json_build_object").WillReturnError(errors.New("database unavailable"))
	require.Error(t, RebuildResource(context.Background(), database, index, 42))
	require.Empty(t, index.savedID)
	mock.ExpectQuery("SELECT json_build_object").WillReturnRows(sqlmock.NewRows([]string{"json"}).AddRow(`{"resource":{"status":1}}`))
	index.err = errors.New("Algolia unavailable")
	require.ErrorIs(t, RebuildResource(context.Background(), database, index, 42), index.err)
	require.NoError(t, mock.ExpectationsWereMet())
	require.NoError(t, RebuildResource(context.Background(), nil, NoopIndexer{}, 42))
}
