package instructions

import (
	"errors"
	"net/http"
	"net/http/httptest"
	"regexp"
	"strings"
	"testing"

	"github.com/DATA-DOG/go-sqlmock"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
	"github.com/stretchr/testify/assert"
)

func TestManager_Create(t *testing.T) {
	const createInstructionQuery = `
INSERT INTO public.instructions (service_id, instruction, created_at, updated_at)
VALUES ($1, $2, NOW(), NOW())
RETURNING id, instruction
`

	tests := []struct {
		name           string
		body           string
		setupMock      func(sqlmock.Sqlmock)
		expectedStatus int
		expectedBody   string
	}{
		{
			name: "creates instruction",
			body: `{"instruction":{"service_id":123,"instruction":"Bring ID"}}`,
			setupMock: func(mock sqlmock.Sqlmock) {
				mock.ExpectQuery(regexp.QuoteMeta(createInstructionQuery)).
					WithArgs(123, "Bring ID").
					WillReturnRows(sqlmock.NewRows([]string{"id", "instruction"}).AddRow(456, "Bring ID"))
			},
			expectedStatus: http.StatusCreated,
			expectedBody:   `{"instruction":"Bring ID","id":456}`,
		},
		{
			name:           "returns bad request for malformed json",
			body:           `{"instruction":`,
			setupMock:      func(mock sqlmock.Sqlmock) {},
			expectedStatus: http.StatusBadRequest,
			expectedBody:   `{"error":"Invalid request body","status_code":400}`,
		},
		{
			name:           "returns bad request when service id is missing",
			body:           `{"instruction":{"instruction":"Bring ID"}}`,
			setupMock:      func(mock sqlmock.Sqlmock) {},
			expectedStatus: http.StatusBadRequest,
			expectedBody:   `{"error":"Service ID is required","status_code":400}`,
		},
		{
			name: "returns internal server error when create fails",
			body: `{"instruction":{"service_id":123,"instruction":"Bring ID"}}`,
			setupMock: func(mock sqlmock.Sqlmock) {
				mock.ExpectQuery(regexp.QuoteMeta(createInstructionQuery)).
					WithArgs(123, "Bring ID").
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
			req := httptest.NewRequest(http.MethodPost, "/api/instructions", strings.NewReader(tt.body))
			w := httptest.NewRecorder()

			manager.Create(w, req)

			assert.Equal(t, tt.expectedStatus, w.Code)
			assert.Equal(t, tt.expectedBody, w.Body.String())
			assert.NoError(t, mock.ExpectationsWereMet())
		})
	}
}
