package changerequest

import (
	"encoding/json"
	"github.com/DATA-DOG/go-sqlmock"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
	"github.com/stretchr/testify/require"
	"net/http/httptest"
	"strings"
	"testing"
)

func TestPhoneCreatePreservesAuditNumberAndDistinctIDs(t *testing.T) {
	database, mock, err := sqlmock.New()
	require.NoError(t, err)
	defer database.Close()
	mock.MatchExpectationsInOrder(false)
	mock.ExpectBegin()
	mock.ExpectQuery("INSERT INTO public.phones").WithArgs(sqlmock.AnyArg(), sqlmock.AnyArg(), sqlmock.AnyArg()).WillReturnRows(sqlmock.NewRows([]string{"id"}).AddRow(12))
	mock.ExpectQuery("INSERT INTO public.change_requests").WithArgs("PhoneChangeRequest", 12, db.StatusPending, db.ActionEdit, 34).WillReturnRows(sqlmock.NewRows([]string{"id"}).AddRow(99))
	mock.ExpectExec("INSERT INTO public.field_changes").WithArgs("number", "4155550101", 99).WillReturnResult(sqlmock.NewResult(0, 1))
	mock.ExpectExec("INSERT INTO public.field_changes").WithArgs("service_type", "Business", 99).WillReturnResult(sqlmock.NewResult(0, 1))
	mock.ExpectCommit()
	expectParityFinalization(mock)
	w := httptest.NewRecorder()
	New(&db.Manager{DB: database}).Create(w, httptest.NewRequest("POST", "/api/change_requests", strings.NewReader(`{"type":"phones","parent_resource_id":34,"change_request":{"field_changes":{"service_type":"Business","number":"4155550101"}}}`)))
	require.Equal(t, 201, w.Code)
	var response PhoneChangeRequest
	require.NoError(t, json.Unmarshal(w.Body.Bytes(), &response))
	require.Equal(t, 99, response.PhoneChangeRequest.Id)
	require.Equal(t, 12, response.PhoneChangeRequest.ObjectID)
	require.Equal(t, []FieldChange{{FieldName: "service_type", FieldValue: "Business"}, {FieldName: "number", FieldValue: "4155550101"}}, response.PhoneChangeRequest.FieldChanges)
	require.NoError(t, mock.ExpectationsWereMet())
}
