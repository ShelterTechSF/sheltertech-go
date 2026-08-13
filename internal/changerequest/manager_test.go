package changerequest

import (
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"regexp"
	"strings"
	"testing"

	"github.com/DATA-DOG/go-sqlmock"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestManagerCreateRoutesAddressInsertChangeRequest(t *testing.T) {
	sqlDB, mock, err := sqlmock.New()
	require.NoError(t, err)
	defer sqlDB.Close()

	mock.ExpectBegin()
	mock.ExpectQuery(regexp.QuoteMeta("INSERT INTO public.addresses")).
		WithArgs(sqlmock.AnyArg(), sqlmock.AnyArg(), sqlmock.AnyArg(), sqlmock.AnyArg(), sqlmock.AnyArg()).
		WillReturnRows(sqlmock.NewRows([]string{"id"}).AddRow(42))
	mock.ExpectQuery(regexp.QuoteMeta(insertChangeRequestSQLForTest())).
		WithArgs("AddressChangeRequest", 42, db.StatusPending, db.ActionAdd, 1).
		WillReturnRows(sqlmock.NewRows([]string{"id"}).AddRow(77))
	for i := 0; i < 4; i++ {
		mock.ExpectExec(regexp.QuoteMeta(insertFieldChangeSQLForTest())).
			WithArgs(sqlmock.AnyArg(), sqlmock.AnyArg(), 77).
			WillReturnResult(sqlmock.NewResult(1, 1))
	}
	mock.ExpectCommit()

	manager := New(&db.Manager{DB: sqlDB})
	req := httptest.NewRequest(http.MethodPost, "/api/change_requests", strings.NewReader(`{
		"change_request": {
			"action": "insert",
			"field_changes": {
				"address_1": "601 4th Street",
				"city": "San Francisco",
				"state_province": "CA",
				"postal_code": "49032"
			}
		},
		"type": "addresses",
		"parent_resource_id": 1
	}`))
	w := httptest.NewRecorder()

	manager.Create(w, req)

	assert.Equal(t, http.StatusCreated, w.Code)

	var response AddressChangeRequest
	require.NoError(t, json.Unmarshal(w.Body.Bytes(), &response))
	assert.Equal(t, ChangeRequestResponse{
		Id:       77,
		Status:   "pending",
		Type:     "AddressChangeRequest",
		ObjectID: 42,
		FieldChanges: []FieldChange{
			{FieldName: "address_1", FieldValue: "601 4th Street"},
			{FieldName: "city", FieldValue: "San Francisco"},
			{FieldName: "state_province", FieldValue: "CA"},
			{FieldName: "postal_code", FieldValue: "49032"},
		},
	}, response.AddressChangeRequest)
	assert.NoError(t, mock.ExpectationsWereMet())
}

func TestManagerCreateAddressInsertRequiresAddressFields(t *testing.T) {
	manager := New(&db.Manager{})
	req := httptest.NewRequest(http.MethodPost, "/api/change_requests", strings.NewReader(`{
		"change_request": {
			"action": "insert",
			"field_changes": {
				"address_1": "601 4th Street",
				"city": "San Francisco",
				"state_province": "CA"
			}
		},
		"type": "addresses",
		"parent_resource_id": 1
	}`))
	w := httptest.NewRecorder()

	manager.Create(w, req)

	assert.Equal(t, http.StatusBadRequest, w.Code)
	assert.JSONEq(t, `{"error":"Missing Required Fields","status_code":400}`, w.Body.String())
}

func insertChangeRequestSQLForTest() string {
	return `
INSERT INTO public.change_requests (type, object_id, status, action, resource_id, created_at, updated_at)
VALUES ($1, $2, $3, $4, $5, now(), now())
RETURNING id`
}

func insertFieldChangeSQLForTest() string {
	return `
INSERT INTO public.field_changes (field_name, field_value, change_request_id)
VALUES ($1, $2, $3)`
}
