package changerequest

import (
	"database/sql"
	"net/http"
	"net/http/httptest"
	"regexp"
	"strings"
	"testing"

	"github.com/DATA-DOG/go-sqlmock"
	"github.com/go-chi/chi/v5"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestSubmitChangeRequest(t *testing.T) {
	_ = New(nil)

	// add mocks
	// manager.Submit(nil,nil)
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
