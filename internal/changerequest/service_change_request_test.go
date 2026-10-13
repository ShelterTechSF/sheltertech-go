package changerequest

import (
	"context"
	"database/sql"
	"encoding/json"
	"errors"
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

const serviceChangeRequestResourceIDQuery = `
SELECT resource_id
FROM public.services
WHERE id = $1
`

const serviceChangeRequestInsertQuery = `
INSERT INTO public.change_requests (type, object_id, status, action, resource_id, created_at, updated_at)
VALUES ($1, $2, $3, $4, $5, now(), now())
RETURNING id`

const serviceChangeRequestInsertFieldChangeQuery = `
INSERT INTO public.field_changes (field_name, field_value, change_request_id)
VALUES ($1, $2, $3)`

func TestUpdateServiceChangeRequestCreatesRequestAndAppliesChanges(t *testing.T) {
	sqlDB, mock, err := sqlmock.New()
	require.NoError(t, err)
	defer sqlDB.Close()

	mock.ExpectBegin()
	mock.ExpectQuery(regexp.QuoteMeta(serviceChangeRequestResourceIDQuery)).
		WithArgs(42).
		WillReturnRows(sqlmock.NewRows([]string{"resource_id"}).AddRow(7))
	mock.ExpectExec(regexp.QuoteMeta("UPDATE public.services SET name=$1, long_description=$2, updated_at=now() WHERE id=$3")).
		WithArgs("Fresh service", "Details", 42).
		WillReturnResult(sqlmock.NewResult(0, 1))
	mock.ExpectExec(regexp.QuoteMeta(`
DELETE FROM public.categories_services
WHERE service_id = $1`)).
		WithArgs(42).
		WillReturnResult(sqlmock.NewResult(0, 2))
	mock.ExpectExec(regexp.QuoteMeta(`
INSERT INTO public.categories_services (service_id, category_id, feature_rank)
VALUES ($1, $2, $3)`)).
		WithArgs(42, 2, nil).
		WillReturnResult(sqlmock.NewResult(0, 1))
	mock.ExpectExec(regexp.QuoteMeta(`
INSERT INTO public.categories_services (service_id, category_id, feature_rank)
VALUES ($1, $2, $3)`)).
		WithArgs(42, 3, 1).
		WillReturnResult(sqlmock.NewResult(0, 1))
	mock.ExpectExec(regexp.QuoteMeta(`
DELETE FROM public.eligibilities_services
WHERE service_id = $1`)).
		WithArgs(42).
		WillReturnResult(sqlmock.NewResult(0, 2))
	mock.ExpectExec(regexp.QuoteMeta(`
INSERT INTO public.eligibilities_services (service_id, eligibility_id)
VALUES ($1, $2)`)).
		WithArgs(42, 1004).
		WillReturnResult(sqlmock.NewResult(0, 1))
	mock.ExpectExec(regexp.QuoteMeta(`
INSERT INTO public.eligibilities_services (service_id, eligibility_id)
VALUES ($1, $2)`)).
		WithArgs(42, 1058).
		WillReturnResult(sqlmock.NewResult(0, 1))
	mock.ExpectQuery(regexp.QuoteMeta(serviceChangeRequestInsertQuery)).
		WithArgs("ServiceChangeRequest", 42, db.StatusPending, db.ActionEdit, 7).
		WillReturnRows(sqlmock.NewRows([]string{"id"}).AddRow(99))
	mock.ExpectExec(regexp.QuoteMeta(serviceChangeRequestInsertFieldChangeQuery)).
		WithArgs("name", "Fresh service", 99).
		WillReturnResult(sqlmock.NewResult(0, 1))
	mock.ExpectExec(regexp.QuoteMeta(serviceChangeRequestInsertFieldChangeQuery)).
		WithArgs("long_description", "Details", 99).
		WillReturnResult(sqlmock.NewResult(0, 1))
	mock.ExpectExec(regexp.QuoteMeta(serviceChangeRequestInsertFieldChangeQuery)).
		WithArgs("categories", `[{"id":2,"name":"Food"},{"id":3,"name":"Health","feature_rank":1}]`, 99).
		WillReturnResult(sqlmock.NewResult(0, 1))
	mock.ExpectExec(regexp.QuoteMeta(serviceChangeRequestInsertFieldChangeQuery)).
		WithArgs("eligibilities", `[{"id":1004},{"id":1058}]`, 99).
		WillReturnResult(sqlmock.NewResult(0, 1))
	mock.ExpectCommit()

	manager := New(&db.Manager{DB: sqlDB})
	req := serviceChangeRequestTestRequest("42", `{
		"change_request": {
			"name": "Fresh service",
			"long_description": "Details",
			"categories": [{"id":2,"name":"Food"},{"id":3,"name":"Health","feature_rank":1}],
			"eligibilities": [{"id":1004},{"id":1058}]
		}
	}`)
	w := httptest.NewRecorder()

	manager.UpdateService(w, req)

	assert.Equal(t, http.StatusCreated, w.Code)

	var response ServiceChangeRequest
	require.NoError(t, json.Unmarshal(w.Body.Bytes(), &response))
	assert.Equal(t, 99, response.ServiceChangeRequest.Id)
	assert.Equal(t, "pending", response.ServiceChangeRequest.Status)
	assert.Equal(t, "ServiceChangeRequest", response.ServiceChangeRequest.Type)
	assert.Equal(t, 42, response.ServiceChangeRequest.ObjectID)
	assert.Len(t, response.ServiceChangeRequest.FieldChanges, 4)
	assert.NoError(t, mock.ExpectationsWereMet())
}

func TestUpdateServiceChangeRequestRejectsInvalidServiceID(t *testing.T) {
	sqlDB, mock, err := sqlmock.New()
	require.NoError(t, err)
	defer sqlDB.Close()

	manager := New(&db.Manager{DB: sqlDB})
	req := serviceChangeRequestTestRequest("not-an-id", `{"change_request":{"name":"Fresh service"}}`)
	w := httptest.NewRecorder()

	manager.UpdateService(w, req)

	assert.Equal(t, http.StatusBadRequest, w.Code)
	assert.JSONEq(t, `{"error":"Invalid service ID","status_code":400}`, w.Body.String())
	assert.NoError(t, mock.ExpectationsWereMet())
}

func TestUpdateServiceChangeRequestReturnsBadRequestForMissingService(t *testing.T) {
	sqlDB, mock, err := sqlmock.New()
	require.NoError(t, err)
	defer sqlDB.Close()

	mock.ExpectBegin()
	mock.ExpectQuery(regexp.QuoteMeta(serviceChangeRequestResourceIDQuery)).
		WithArgs(77).
		WillReturnError(sql.ErrNoRows)
	mock.ExpectRollback()

	manager := New(&db.Manager{DB: sqlDB})
	req := serviceChangeRequestTestRequest("77", `{"change_request":{"name":"Fresh service"}}`)
	w := httptest.NewRecorder()

	manager.UpdateService(w, req)

	assert.Equal(t, http.StatusBadRequest, w.Code)
	assert.JSONEq(t, `{"error":"Invalid service ID","status_code":400}`, w.Body.String())
	assert.NoError(t, mock.ExpectationsWereMet())
}

func TestUpdateServiceChangeRequestReturnsServerErrorForDatabaseFailure(t *testing.T) {
	sqlDB, mock, err := sqlmock.New()
	require.NoError(t, err)
	defer sqlDB.Close()

	mock.ExpectBegin()
	mock.ExpectQuery(regexp.QuoteMeta(serviceChangeRequestResourceIDQuery)).
		WithArgs(55).
		WillReturnRows(sqlmock.NewRows([]string{"resource_id"}).AddRow(7))
	mock.ExpectExec(regexp.QuoteMeta("UPDATE public.services SET name=$1, updated_at=now() WHERE id=$2")).
		WithArgs("Broken", 55).
		WillReturnError(errors.New("update failed"))
	mock.ExpectRollback()

	manager := New(&db.Manager{DB: sqlDB})
	req := serviceChangeRequestTestRequest("55", `{"change_request":{"name":"Broken"}}`)
	w := httptest.NewRecorder()

	manager.UpdateService(w, req)

	assert.Equal(t, http.StatusInternalServerError, w.Code)
	assert.JSONEq(t, `{"error":"update failed","status_code":500}`, w.Body.String())
	assert.NoError(t, mock.ExpectationsWereMet())
}

func serviceChangeRequestTestRequest(serviceID string, body string) *http.Request {
	req := httptest.NewRequest(http.MethodPost, "/api/services/"+serviceID+"/change_requests", strings.NewReader(body))
	routeContext := chi.NewRouteContext()
	routeContext.URLParams.Add("id", serviceID)
	return req.WithContext(context.WithValue(req.Context(), chi.RouteCtxKey, routeContext))
}
