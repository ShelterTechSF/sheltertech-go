package resources

import (
	"context"
	"database/sql"
	"net/http"
	"net/http/httptest"
	"regexp"
	"strings"
	"testing"
	"time"

	"github.com/DATA-DOG/go-sqlmock"
	"github.com/go-chi/chi/v5"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
	"github.com/stretchr/testify/assert"
)

const resourceByIDQuery = `SELECT id, name, short_description, long_description, website, verified_at, email, status, certified, alternate_name, legal_status, contact_id, funding_id, certified_at, featured, source_attribution, internal_note, updated_at
FROM public.resources
WHERE id = $1`

const createResourceNoteQuery = `INSERT INTO public.notes (note, resource_id, created_at, updated_at)
VALUES ($1, $2, NOW(), NOW())
RETURNING id, note, created_at, updated_at`

func TestManager_CreateNote(t *testing.T) {
	tests := []struct {
		name           string
		resourceID     string
		body           string
		setupMock      func(sqlmock.Sqlmock)
		expectedStatus int
		expectedBody   string
	}{
		{
			name:       "creates a note for the resource",
			resourceID: "7",
			body:       `{"note":{"note":"harro"}}`,
			setupMock: func(mock sqlmock.Sqlmock) {
				mock.ExpectQuery(regexp.QuoteMeta(resourceByIDQuery)).
					WithArgs(7).
					WillReturnRows(resourceRows().AddRow(7, "Mission Resource", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, time.Now()))
				mock.ExpectQuery(regexp.QuoteMeta(createResourceNoteQuery)).
					WithArgs("harro", 7).
					WillReturnRows(sqlmock.NewRows([]string{"id", "note", "created_at", "updated_at"}).AddRow(42, "harro", time.Now(), time.Now()))
			},
			expectedStatus: http.StatusCreated,
			expectedBody:   `{"id":42,"note":"harro"}`,
		},
		{
			name:       "returns bad request for invalid resource ID",
			resourceID: "not-a-number",
			body:       `{"note":{"note":"harro"}}`,
			setupMock: func(mock sqlmock.Sqlmock) {
			},
			expectedStatus: http.StatusBadRequest,
			expectedBody:   `{"error":"Invalid resource ID format","status_code":400}`,
		},
		{
			name:       "does not create a note when resource is missing",
			resourceID: "99",
			body:       `{"note":{"note":"harro"}}`,
			setupMock: func(mock sqlmock.Sqlmock) {
				mock.ExpectQuery(regexp.QuoteMeta(resourceByIDQuery)).
					WithArgs(99).
					WillReturnError(sql.ErrNoRows)
			},
			expectedStatus: http.StatusNotFound,
			expectedBody:   `{"error":"Resource not found","status_code":404}`,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			sqlDB, mock, err := sqlmock.New()
			assert.NoError(t, err)
			defer sqlDB.Close()

			tt.setupMock(mock)

			manager := New(&db.Manager{DB: sqlDB})
			req := requestWithResourceID(tt.resourceID, tt.body)
			w := httptest.NewRecorder()

			manager.CreateNote(w, req)

			assert.Equal(t, tt.expectedStatus, w.Code)
			assert.Equal(t, "application/json", w.Header().Get("Content-Type"))
			assert.Equal(t, tt.expectedBody, w.Body.String())
			assert.NoError(t, mock.ExpectationsWereMet())
		})
	}
}

func requestWithResourceID(resourceID string, body string) *http.Request {
	req := httptest.NewRequest(http.MethodPost, "/api/resources/"+resourceID+"/notes", strings.NewReader(body))
	routeContext := chi.NewRouteContext()
	routeContext.URLParams.Add("id", resourceID)
	return req.WithContext(context.WithValue(req.Context(), chi.RouteCtxKey, routeContext))
}

func resourceRows() *sqlmock.Rows {
	return sqlmock.NewRows([]string{
		"id",
		"name",
		"short_description",
		"long_description",
		"website",
		"verified_at",
		"email",
		"status",
		"certified",
		"alternate_name",
		"legal_status",
		"contact_id",
		"funding_id",
		"certified_at",
		"featured",
		"source_attribution",
		"internal_note",
		"updated_at",
	})
}
