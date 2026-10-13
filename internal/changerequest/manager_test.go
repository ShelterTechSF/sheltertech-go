package changerequest

import (
	"database/sql"
	"encoding/json"
	"github.com/DATA-DOG/go-sqlmock"
	"github.com/go-chi/chi/v5"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
	"net/http"
	"net/http/httptest"
	"regexp"
	"strings"
	"testing"
)

func TestUpdateNoteReturnsBadRequestForInvalidNoteID(t *testing.T) {
	manager := New(nil)
	router := chi.NewRouter()
	router.Post("/api/notes/{id}/change_requests", manager.UpdateNote)

	req := httptest.NewRequest(
		http.MethodPost,
		"/api/notes/not-a-number/change_requests",
		strings.NewReader(`{"change_request":{"note":"Updated note"}}`),
	)
	w := httptest.NewRecorder()

	router.ServeHTTP(w, req)

	assert.Equal(t, http.StatusBadRequest, w.Code)
}

func TestUpdateNoteReturnsBadRequestWhenNoteFieldIsMissing(t *testing.T) {
	manager := New(nil)
	router := chi.NewRouter()
	router.Post("/api/notes/{id}/change_requests", manager.UpdateNote)

	req := httptest.NewRequest(
		http.MethodPost,
		"/api/notes/12/change_requests",
		strings.NewReader(`{"change_request":{"id":12}}`),
	)
	w := httptest.NewRecorder()

	router.ServeHTTP(w, req)

	assert.Equal(t, http.StatusBadRequest, w.Code)
}

func TestUpdateAddressEditsAddressAndCreatesChangeRequest(t *testing.T) {
	sqlDB, mock, err := sqlmock.New()
	require.NoError(t, err)
	defer sqlDB.Close()

	manager := New(&db.Manager{DB: sqlDB})
	expectAddressEditChangeRequest(mock, 12, 34, 99)

	w := serveAddressChangeRequest(
		manager,
		"/api/addresses/12/change_requests",
		`{"change_request":{"city":"Oakland","address_1":"123 New St","postal_code":"94612"}}`,
	)

	assert.Equal(t, http.StatusCreated, w.Code)
	assert.JSONEq(t, `{
		"address_change_request": {
			"id": 99,
			"status": "pending",
			"type": "AddressChangeRequest",
			"object_id": 12,
			"field_changes": [
				{"field_name":"address_1","field_value":"123 New St"},
				{"field_name":"city","field_value":"Oakland"},
				{"field_name":"postal_code","field_value":"94612"}
			]
		}
	}`, w.Body.String())
	assert.NoError(t, mock.ExpectationsWereMet())
}

func TestUpdateAddressAcceptsNestedFieldChanges(t *testing.T) {
	sqlDB, mock, err := sqlmock.New()
	require.NoError(t, err)
	defer sqlDB.Close()

	manager := New(&db.Manager{DB: sqlDB})
	expectAddressEditChangeRequest(mock, 12, 34, 99)

	w := serveAddressChangeRequest(
		manager,
		"/api/addresses/12/change_requests",
		`{"change_request":{"action":"edit","field_changes":{"city":"Oakland","address_1":"123 New St","postal_code":"94612"}}}`,
	)

	assert.Equal(t, http.StatusCreated, w.Code)
	assert.JSONEq(t, `{
		"address_change_request": {
			"id": 99,
			"status": "pending",
			"type": "AddressChangeRequest",
			"object_id": 12,
			"field_changes": [
				{"field_name":"address_1","field_value":"123 New St"},
				{"field_name":"city","field_value":"Oakland"},
				{"field_name":"postal_code","field_value":"94612"}
			]
		}
	}`, w.Body.String())
	assert.NoError(t, mock.ExpectationsWereMet())
}

func TestUpdateAddressRemovesAddressAndCreatesChangeRequest(t *testing.T) {
	sqlDB, mock, err := sqlmock.New()
	require.NoError(t, err)
	defer sqlDB.Close()

	manager := New(&db.Manager{DB: sqlDB})
	expectAddressRemoveChangeRequest(mock, 12, 34, 100)

	w := serveAddressChangeRequest(
		manager,
		"/api/addresses/12/change_requests",
		`{"change_request":{"action":"remove"}}`,
	)

	assert.Equal(t, http.StatusCreated, w.Code)
	assert.JSONEq(t, `{
		"address_change_request": {
			"id": 100,
			"status": "pending",
			"type": "AddressChangeRequest",
			"object_id": 12,
			"field_changes": []
		}
	}`, w.Body.String())
	assert.NoError(t, mock.ExpectationsWereMet())
}

func TestUpdateAddressReturnsBadRequestForInvalidID(t *testing.T) {
	sqlDB, mock, err := sqlmock.New()
	require.NoError(t, err)
	defer sqlDB.Close()

	manager := New(&db.Manager{DB: sqlDB})

	w := serveAddressChangeRequest(
		manager,
		"/api/addresses/not-an-id/change_requests",
		`{"change_request":{"action":"remove"}}`,
	)

	assert.Equal(t, http.StatusBadRequest, w.Code)
	assert.NoError(t, mock.ExpectationsWereMet())
}

func TestUpdateAddressMissingAddressDoesNotUpdate(t *testing.T) {
	sqlDB, mock, err := sqlmock.New()
	require.NoError(t, err)
	defer sqlDB.Close()

	manager := New(&db.Manager{DB: sqlDB})

	mock.ExpectBegin()
	mock.ExpectQuery(regexp.QuoteMeta(addressResourceIDSelectSQLForTest)).
		WithArgs(404).
		WillReturnError(sql.ErrNoRows)
	mock.ExpectRollback()

	w := serveAddressChangeRequest(
		manager,
		"/api/addresses/404/change_requests",
		`{"change_request":{"city":"Oakland"}}`,
	)

	assert.Equal(t, http.StatusNotFound, w.Code)
	assert.NoError(t, mock.ExpectationsWereMet())
}

func serveAddressChangeRequest(manager *Manager, target string, body string) *httptest.ResponseRecorder {
	router := chi.NewRouter()
	router.Post("/api/addresses/{id}/change_requests", manager.UpdateAddress)

	req := httptest.NewRequest(http.MethodPost, target, strings.NewReader(body))
	w := httptest.NewRecorder()
	router.ServeHTTP(w, req)

	return w
}

func expectAddressEditChangeRequest(mock sqlmock.Sqlmock, addressID int, resourceID int, changeRequestID int) {
	mock.ExpectBegin()
	mock.ExpectQuery(regexp.QuoteMeta(addressResourceIDSelectSQLForTest)).
		WithArgs(addressID).
		WillReturnRows(sqlmock.NewRows([]string{"resource_id"}).AddRow(resourceID))
	mock.ExpectQuery(regexp.QuoteMeta(changeRequestInsertSQLForTest)).
		WithArgs("AddressChangeRequest", addressID, db.StatusPending, db.ActionEdit, resourceID).
		WillReturnRows(sqlmock.NewRows([]string{"id"}).AddRow(changeRequestID))
	mock.ExpectExec(regexp.QuoteMeta(fieldChangeInsertSQLForTest)).
		WithArgs("address_1", "123 New St", changeRequestID).
		WillReturnResult(sqlmock.NewResult(1, 1))
	mock.ExpectExec(regexp.QuoteMeta(fieldChangeInsertSQLForTest)).
		WithArgs("city", "Oakland", changeRequestID).
		WillReturnResult(sqlmock.NewResult(1, 1))
	mock.ExpectExec(regexp.QuoteMeta(fieldChangeInsertSQLForTest)).
		WithArgs("postal_code", "94612", changeRequestID).
		WillReturnResult(sqlmock.NewResult(1, 1))
	mock.ExpectExec(regexp.QuoteMeta("UPDATE public.addresses SET address_1=$1, city=$2, postal_code=$3, updated_at=now() WHERE id=$4")).
		WithArgs("123 New St", "Oakland", "94612", addressID).
		WillReturnResult(sqlmock.NewResult(0, 1))
	mock.ExpectExec(regexp.QuoteMeta(touchResourceForAddressChangeRequestSQLForTest)).
		WithArgs(int32(resourceID)).
		WillReturnResult(sqlmock.NewResult(0, 1))
	mock.ExpectCommit()
}

func expectAddressRemoveChangeRequest(mock sqlmock.Sqlmock, addressID int, resourceID int, changeRequestID int) {
	mock.ExpectBegin()
	mock.ExpectQuery(regexp.QuoteMeta(addressResourceIDSelectSQLForTest)).
		WithArgs(addressID).
		WillReturnRows(sqlmock.NewRows([]string{"resource_id"}).AddRow(resourceID))
	mock.ExpectQuery(regexp.QuoteMeta(changeRequestInsertSQLForTest)).
		WithArgs("AddressChangeRequest", addressID, db.StatusPending, db.ActionRemove, resourceID).
		WillReturnRows(sqlmock.NewRows([]string{"id"}).AddRow(changeRequestID))
	mock.ExpectExec(regexp.QuoteMeta("DELETE FROM public.addresses_services WHERE address_id = $1")).
		WithArgs(addressID).
		WillReturnResult(sqlmock.NewResult(0, 1))
	mock.ExpectExec(regexp.QuoteMeta("DELETE FROM public.addresses WHERE id = $1")).
		WithArgs(addressID).
		WillReturnResult(sqlmock.NewResult(0, 1))
	mock.ExpectExec(regexp.QuoteMeta(touchResourceForAddressChangeRequestSQLForTest)).
		WithArgs(int32(resourceID)).
		WillReturnResult(sqlmock.NewResult(0, 1))
	mock.ExpectCommit()
}

const addressResourceIDSelectSQLForTest = `
SELECT resource_id
FROM public.addresses
WHERE id = $1`

const changeRequestInsertSQLForTest = `
INSERT INTO public.change_requests (type, object_id, status, action, resource_id, created_at, updated_at)
VALUES ($1, $2, $3, $4, $5, now(), now())
RETURNING id`

const fieldChangeInsertSQLForTest = `
INSERT INTO public.field_changes (field_name, field_value, change_request_id)
VALUES ($1, $2, $3)`

const touchResourceForAddressChangeRequestSQLForTest = `
UPDATE public.resources
SET updated_at = now()
WHERE id = $1`

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
