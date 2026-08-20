package instructions

import (
	"context"
	"database/sql"
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
)

func TestManager_Update(t *testing.T) {
	const updateInstructionQuery = `
UPDATE public.instructions
SET instruction = $2, updated_at = NOW()
WHERE id = $1
RETURNING id, instruction
`

	tests := []struct {
		name           string
		id             string
		body           string
		setupMock      func(sqlmock.Sqlmock)
		expectedStatus int
		expectedBody   string
	}{
		{
			name: "updates instruction",
			id:   "456",
			body: `{"instruction":{"instruction":"Bring proof of address"}}`,
			setupMock: func(mock sqlmock.Sqlmock) {
				mock.ExpectQuery(regexp.QuoteMeta(updateInstructionQuery)).
					WithArgs(456, "Bring proof of address").
					WillReturnRows(sqlmock.NewRows([]string{"id", "instruction"}).AddRow(456, "Bring proof of address"))
			},
			expectedStatus: http.StatusOK,
			expectedBody:   `{"instruction":"Bring proof of address","id":456}`,
		},
		{
			name: "preserves missing instruction as null",
			id:   "456",
			body: `{"instruction":{}}`,
			setupMock: func(mock sqlmock.Sqlmock) {
				mock.ExpectQuery(regexp.QuoteMeta(updateInstructionQuery)).
					WithArgs(456, nil).
					WillReturnRows(sqlmock.NewRows([]string{"id", "instruction"}).AddRow(456, nil))
			},
			expectedStatus: http.StatusOK,
			expectedBody:   `{"instruction":null,"id":456}`,
		},
		{
			name: "preserves null instruction as null",
			id:   "456",
			body: `{"instruction":{"instruction":null}}`,
			setupMock: func(mock sqlmock.Sqlmock) {
				mock.ExpectQuery(regexp.QuoteMeta(updateInstructionQuery)).
					WithArgs(456, nil).
					WillReturnRows(sqlmock.NewRows([]string{"id", "instruction"}).AddRow(456, nil))
			},
			expectedStatus: http.StatusOK,
			expectedBody:   `{"instruction":null,"id":456}`,
		},
		{
			name:           "returns bad request for invalid id",
			id:             "abc",
			body:           `{"instruction":{"instruction":"Bring ID"}}`,
			setupMock:      func(mock sqlmock.Sqlmock) {},
			expectedStatus: http.StatusBadRequest,
			expectedBody:   `{"error":"Invalid instruction ID format","status_code":400}`,
		},
		{
			name:           "returns bad request for malformed json",
			id:             "456",
			body:           `{"instruction":`,
			setupMock:      func(mock sqlmock.Sqlmock) {},
			expectedStatus: http.StatusBadRequest,
			expectedBody:   `{"error":"Invalid request body","status_code":400}`,
		},
		{
			name: "returns not found when instruction does not exist",
			id:   "456",
			body: `{"instruction":{"instruction":"Bring ID"}}`,
			setupMock: func(mock sqlmock.Sqlmock) {
				mock.ExpectQuery(regexp.QuoteMeta(updateInstructionQuery)).
					WithArgs(456, "Bring ID").
					WillReturnError(sql.ErrNoRows)
			},
			expectedStatus: http.StatusNotFound,
			expectedBody:   `{"error":"Instruction not found","status_code":404}`,
		},
		{
			name: "returns internal server error when update fails",
			id:   "456",
			body: `{"instruction":{"instruction":"Bring ID"}}`,
			setupMock: func(mock sqlmock.Sqlmock) {
				mock.ExpectQuery(regexp.QuoteMeta(updateInstructionQuery)).
					WithArgs(456, "Bring ID").
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
			req := requestWithInstructionID(tt.id, tt.body)
			w := httptest.NewRecorder()

			manager.Update(w, req)

			assert.Equal(t, tt.expectedStatus, w.Code)
			assert.Equal(t, tt.expectedBody, w.Body.String())
			assert.NoError(t, mock.ExpectationsWereMet())
		})
	}
}

func requestWithInstructionID(id, body string) *http.Request {
	req := httptest.NewRequest(http.MethodPut, "/api/instructions/"+id, strings.NewReader(body))
	routeContext := chi.NewRouteContext()
	routeContext.URLParams.Add("id", id)
	return req.WithContext(context.WithValue(req.Context(), chi.RouteCtxKey, routeContext))
}
