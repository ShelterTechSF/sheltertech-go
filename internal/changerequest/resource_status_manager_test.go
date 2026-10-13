package changerequest

import (
	"context"
	"net/http"
	"net/http/httptest"
	"regexp"
	"strings"
	"testing"

	"github.com/DATA-DOG/go-sqlmock"
	"github.com/go-chi/chi/v5"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
	"github.com/stretchr/testify/assert"
)

func TestManager_UpdateResourceStatus(t *testing.T) {
	const updateResourceStatusQuery = `UPDATE public.resources SET status=$1, updated_at=now() WHERE id=$2`
	const insertChangeRequestQuery = `
INSERT INTO public.change_requests (type, object_id, status, action, resource_id, created_at, updated_at)
VALUES ($1, $2, $3, $4, $5, now(), now())
RETURNING id`
	const insertFieldChangeQuery = `
INSERT INTO public.field_changes (field_name, field_value, change_request_id)
VALUES ($1, $2, $3)`

	tests := []struct {
		name           string
		id             string
		body           string
		setupMock      func(sqlmock.Sqlmock)
		expectedStatus int
		expectedBody   string
	}{
		{
			name: "updates resource status from direct change request payload",
			id:   "123",
			body: `{"change_request":{"status":"approved"}}`,
			setupMock: func(mock sqlmock.Sqlmock) {
				mock.ExpectBegin()
				mock.ExpectExec(regexp.QuoteMeta(updateResourceStatusQuery)).
					WithArgs(1, 123).
					WillReturnResult(sqlmock.NewResult(0, 1))
				mock.ExpectQuery(regexp.QuoteMeta(insertChangeRequestQuery)).
					WithArgs("ResourceChangeRequest", 123, db.StatusPending, db.ActionEdit, 123).
					WillReturnRows(sqlmock.NewRows([]string{"id"}).AddRow(456))
				mock.ExpectExec(regexp.QuoteMeta(insertFieldChangeQuery)).
					WithArgs("status", "approved", 456).
					WillReturnResult(sqlmock.NewResult(0, 1))
				mock.ExpectCommit()
			},
			expectedStatus: http.StatusCreated,
			expectedBody:   `{"resource_change_request":{"id":456,"status":"pending","type":"ResourceChangeRequest","object_id":123,"field_changes":[{"field_name":"status","field_value":"approved"}]}}`,
		},
		{
			name: "updates resource status from nested field_changes payload",
			id:   "123",
			body: `{"change_request":{"action":"edit","field_changes":{"status":"inactive"}}}`,
			setupMock: func(mock sqlmock.Sqlmock) {
				mock.ExpectBegin()
				mock.ExpectExec(regexp.QuoteMeta(updateResourceStatusQuery)).
					WithArgs(3, 123).
					WillReturnResult(sqlmock.NewResult(0, 1))
				mock.ExpectQuery(regexp.QuoteMeta(insertChangeRequestQuery)).
					WithArgs("ResourceChangeRequest", 123, db.StatusPending, db.ActionEdit, 123).
					WillReturnRows(sqlmock.NewRows([]string{"id"}).AddRow(457))
				mock.ExpectExec(regexp.QuoteMeta(insertFieldChangeQuery)).
					WithArgs("status", "inactive", 457).
					WillReturnResult(sqlmock.NewResult(0, 1))
				mock.ExpectCommit()
			},
			expectedStatus: http.StatusCreated,
			expectedBody:   `{"resource_change_request":{"id":457,"status":"pending","type":"ResourceChangeRequest","object_id":123,"field_changes":[{"field_name":"status","field_value":"inactive"}]}}`,
		},
		{
			name:           "returns bad request for invalid status",
			id:             "123",
			body:           `{"change_request":{"status":"archived"}}`,
			setupMock:      func(mock sqlmock.Sqlmock) {},
			expectedStatus: http.StatusBadRequest,
			expectedBody:   `{"error":"invalid resource status: archived","status_code":400}`,
		},
		{
			name:           "returns bad request for invalid resource id",
			id:             "abc",
			body:           `{"change_request":{"status":"approved"}}`,
			setupMock:      func(mock sqlmock.Sqlmock) {},
			expectedStatus: http.StatusBadRequest,
			expectedBody:   "Invalid resource ID\n",
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			sqlDB, mock, err := sqlmock.New()
			assert.NoError(t, err)
			defer sqlDB.Close()

			tt.setupMock(mock)

			manager := New(&db.Manager{DB: sqlDB})
			req := requestWithResourceStatusID(tt.id, tt.body)
			w := httptest.NewRecorder()

			manager.UpdateResource(w, req)

			assert.Equal(t, tt.expectedStatus, w.Code)
			assert.Equal(t, tt.expectedBody, w.Body.String())
			assert.NoError(t, mock.ExpectationsWereMet())
		})
	}
}

func requestWithResourceStatusID(id, body string) *http.Request {
	req := httptest.NewRequest(http.MethodPost, "/api/resources/"+id+"/change_requests", strings.NewReader(body))
	routeContext := chi.NewRouteContext()
	routeContext.URLParams.Add("id", id)
	return req.WithContext(context.WithValue(req.Context(), chi.RouteCtxKey, routeContext))
}
