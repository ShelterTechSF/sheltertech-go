package services

import (
	"context"
	"database/sql"
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

func TestManager_Delete(t *testing.T) {
	const serviceStatusQuery = `
SELECT status
FROM public.services
WHERE id = $1
`
	const deactivateServiceQuery = `
UPDATE public.services
SET status = $2, updated_at = NOW()
WHERE id = $1`

	tests := []struct {
		name           string
		id             string
		setupMock      func(sqlmock.Sqlmock)
		expectedStatus int
		expectedBody   string
	}{
		{
			name: "deactivates approved service",
			id:   "123",
			setupMock: func(mock sqlmock.Sqlmock) {
				mock.ExpectQuery(regexp.QuoteMeta(serviceStatusQuery)).
					WithArgs(123).
					WillReturnRows(sqlmock.NewRows([]string{"status"}).AddRow(db.ServiceStatusApproved))
				mock.ExpectExec(regexp.QuoteMeta(deactivateServiceQuery)).
					WithArgs(123, db.ServiceStatusInactive).
					WillReturnResult(sqlmock.NewResult(0, 1))
			},
			expectedStatus: http.StatusOK,
			expectedBody:   "",
		},
		{
			name: "returns precondition failed when service is not approved",
			id:   "123",
			setupMock: func(mock sqlmock.Sqlmock) {
				mock.ExpectQuery(regexp.QuoteMeta(serviceStatusQuery)).
					WithArgs(123).
					WillReturnRows(sqlmock.NewRows([]string{"status"}).AddRow(0))
			},
			expectedStatus: http.StatusPreconditionFailed,
			expectedBody:   "",
		},
		{
			name: "returns not found when service does not exist",
			id:   "123",
			setupMock: func(mock sqlmock.Sqlmock) {
				mock.ExpectQuery(regexp.QuoteMeta(serviceStatusQuery)).
					WithArgs(123).
					WillReturnError(sql.ErrNoRows)
			},
			expectedStatus: http.StatusNotFound,
			expectedBody:   "404: Service not found for ID: 123\n",
		},
		{
			name:           "returns bad request for invalid id",
			id:             "abc",
			setupMock:      func(mock sqlmock.Sqlmock) {},
			expectedStatus: http.StatusBadRequest,
			expectedBody:   "Invalid service ID\n",
		},
		{
			name: "returns internal server error when status lookup fails",
			id:   "123",
			setupMock: func(mock sqlmock.Sqlmock) {
				mock.ExpectQuery(regexp.QuoteMeta(serviceStatusQuery)).
					WithArgs(123).
					WillReturnError(errors.New("database unavailable"))
			},
			expectedStatus: http.StatusInternalServerError,
			expectedBody:   "Database error\n",
		},
		{
			name: "returns internal server error when deactivation fails",
			id:   "123",
			setupMock: func(mock sqlmock.Sqlmock) {
				mock.ExpectQuery(regexp.QuoteMeta(serviceStatusQuery)).
					WithArgs(123).
					WillReturnRows(sqlmock.NewRows([]string{"status"}).AddRow(db.ServiceStatusApproved))
				mock.ExpectExec(regexp.QuoteMeta(deactivateServiceQuery)).
					WithArgs(123, db.ServiceStatusInactive).
					WillReturnError(errors.New("database unavailable"))
			},
			expectedStatus: http.StatusInternalServerError,
			expectedBody:   "Failed to deactivate service\n",
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			sqlDB, mock, err := sqlmock.New()
			assert.NoError(t, err)
			defer sqlDB.Close()

			tt.setupMock(mock)

			manager := NewWithDependencies(
				&db.Manager{DB: sqlDB},
				nil,
				nil,
				GoogleConfig{},
				PDFCrowdConfig{},
			)
			req := requestWithServiceID(http.MethodDelete, tt.id)
			w := httptest.NewRecorder()

			manager.Delete(w, req)

			assert.Equal(t, tt.expectedStatus, w.Code)
			assert.Equal(t, tt.expectedBody, w.Body.String())
			assert.NoError(t, mock.ExpectationsWereMet())
		})
	}
}

func requestWithServiceID(method, id string) *http.Request {
	req := httptest.NewRequest(method, "/api/services/"+id, nil)
	routeContext := chi.NewRouteContext()
	routeContext.URLParams.Add("id", id)
	return req.WithContext(context.WithValue(req.Context(), chi.RouteCtxKey, routeContext))
}
