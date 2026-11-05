package changerequest

import (
	"context"
	"database/sql"
	"encoding/json"
	"errors"
	"github.com/DATA-DOG/go-sqlmock"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
	"github.com/stretchr/testify/require"
	"net/http/httptest"
	"testing"
)

func expectParityFinalization(mock sqlmock.Sqlmock) {
	mock.ExpectQuery("UPDATE public.resources SET updated_at = NOW").WillReturnRows(sqlmock.NewRows([]string{"id"}).AddRow(34))
}

type changeIndex struct {
	operations []string
	err        error
}

func (i *changeIndex) SaveObject(id string, _ interface{}) error {
	i.operations = append(i.operations, "save:"+id)
	return i.err
}
func (i *changeIndex) DeleteObject(id string) error {
	i.operations = append(i.operations, "delete:"+id)
	return i.err
}
func TestChangeRequestFinalization(t *testing.T) {
	database, mock, err := sqlmock.New()
	require.NoError(t, err)
	defer database.Close()
	mock.ExpectQuery("UPDATE public.resources SET updated_at = NOW").WithArgs(99).WillReturnRows(sqlmock.NewRows([]string{"id"}).AddRow(34))
	mock.ExpectQuery("SELECT json_build_object").WithArgs(34).WillReturnRows(sqlmock.NewRows([]string{"json"}).AddRow(`{"resource":{"status":1}}`))
	mock.ExpectQuery("SELECT id FROM public.services").WithArgs(34).WillReturnRows(sqlmock.NewRows([]string{"id"}).AddRow(5).AddRow(6))
	mock.ExpectQuery("SELECT json_build_object").WithArgs(5).WillReturnRows(sqlmock.NewRows([]string{"json"}).AddRow(`{"service":{"status":1}}`))
	mock.ExpectQuery("SELECT json_build_object").WithArgs(6).WillReturnRows(sqlmock.NewRows([]string{"json"}).AddRow(`{"service":{"status":3}}`))
	index := &changeIndex{}
	m := New(&db.Manager{DB: database}, index)
	require.True(t, m.finishChangeRequest(context.Background(), httptest.NewRecorder(), 99))
	require.Equal(t, []string{"save:resource_34", "save:service_5", "delete:service_6"}, index.operations)
	require.NoError(t, mock.ExpectationsWereMet())
}
func TestFinalizationWithoutResourceOrWithFailure(t *testing.T) {
	for _, tc := range []struct {
		err  error
		want bool
	}{{sql.ErrNoRows, true}, {errors.New("database unavailable"), false}} {
		database, mock, err := sqlmock.New()
		require.NoError(t, err)
		mock.ExpectQuery("UPDATE public.resources").WithArgs(42).WillReturnError(tc.err)
		w := httptest.NewRecorder()
		require.Equal(t, tc.want, New(&db.Manager{DB: database}).finishChangeRequest(context.Background(), w, 42))
		if !tc.want {
			require.Equal(t, 500, w.Code)
		}
		require.NoError(t, mock.ExpectationsWereMet())
		database.Close()
	}
}
func TestFieldChangesFollowInputOrder(t *testing.T) {
	fields := []FieldChange{{FieldName: "name"}, {FieldName: "long_description"}}
	orderFieldChanges(fields, []byte(`{"field_changes":{"long_description":"first","name":"second"}}`))
	require.Equal(t, "long_description", fields[0].FieldName)
}

func TestChangeRequestPreservesSubmittedFieldOrder(t *testing.T) {
	var payload ChangeRequestPayload
	require.NoError(t, json.Unmarshal([]byte(`{"change_request":{"closes_at":1700,"opens_at":900}}`), &payload))
	fields := []FieldChange{{FieldName: "opens_at"}, {FieldName: "closes_at"}}
	orderFieldChanges(fields, payload.ChangeRequest.rawJSON)
	require.Equal(t, "closes_at", fields[0].FieldName)
}
