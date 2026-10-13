package resources

import (
	"context"
	"errors"
	"net/http"
	"net/http/httptest"
	"regexp"
	"testing"

	"github.com/DATA-DOG/go-sqlmock"
	"github.com/go-chi/chi/v5"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
	"github.com/stretchr/testify/assert"
)

func TestManager_Certify(t *testing.T) {
	const certifyResourceQuery = `
UPDATE public.resources
SET certified = true, certified_at = now(), updated_at = now()
WHERE id = $1
`

	tests := []struct {
		name           string
		id             string
		setupMock      func(sqlmock.Sqlmock)
		expectedStatus int
		expectedBody   string
	}{
		{
			name: "certifies resource",
			id:   "123",
			setupMock: func(mock sqlmock.Sqlmock) {
				mock.ExpectExec(regexp.QuoteMeta(certifyResourceQuery)).
					WithArgs(123).
					WillReturnResult(sqlmock.NewResult(0, 1))
			},
			expectedStatus: http.StatusOK,
			expectedBody:   "",
		},
		{
			name:           "returns bad request for invalid id",
			id:             "abc",
			setupMock:      func(mock sqlmock.Sqlmock) {},
			expectedStatus: http.StatusBadRequest,
			expectedBody:   `{"error":"Invalid resource ID format","status_code":400}`,
		},
		{
			name: "returns not found when resource does not exist",
			id:   "123",
			setupMock: func(mock sqlmock.Sqlmock) {
				mock.ExpectExec(regexp.QuoteMeta(certifyResourceQuery)).
					WithArgs(123).
					WillReturnResult(sqlmock.NewResult(0, 0))
			},
			expectedStatus: http.StatusNotFound,
			expectedBody:   `{"error":"Resource not found","status_code":404}`,
		},
		{
			name: "returns internal server error when certify fails",
			id:   "123",
			setupMock: func(mock sqlmock.Sqlmock) {
				mock.ExpectExec(regexp.QuoteMeta(certifyResourceQuery)).
					WithArgs(123).
					WillReturnError(errors.New("database unavailable"))
			},
			expectedStatus: http.StatusInternalServerError,
			expectedBody:   `{"error":"Internal Server Error","status_code":500}`,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			sqlDB, mock, err := sqlmock.New()
			assert.NoError(t, err)
			defer sqlDB.Close()

			tt.setupMock(mock)

			manager := New(&db.Manager{DB: sqlDB})
			req := requestWithResourceID(http.MethodPost, "/api/resources/"+tt.id+"/certify", tt.id)
			w := httptest.NewRecorder()

			manager.Certify(w, req)

			assert.Equal(t, tt.expectedStatus, w.Code)
			assert.Equal(t, tt.expectedBody, w.Body.String())
			assert.NoError(t, mock.ExpectationsWereMet())
		})
	}
}

func requestWithResourceID(method string, target string, id string) *http.Request {
	req := httptest.NewRequest(method, target, nil)
	routeContext := chi.NewRouteContext()
	routeContext.URLParams.Add("id", id)
	return req.WithContext(context.WithValue(req.Context(), chi.RouteCtxKey, routeContext))
}
