package resources

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
	"github.com/sheltertechsf/sheltertech-go/internal/searchindex"
	"github.com/stretchr/testify/assert"
)

type fakeSearchIndexer struct {
	deletedObjectIDs []string
	err              error
}

func (f *fakeSearchIndexer) DeleteObject(objectID string) error {
	f.deletedObjectIDs = append(f.deletedObjectIDs, objectID)
	return f.err
}

func TestManager_Delete(t *testing.T) {
	const resourceStatusQuery = `
SELECT status
FROM public.resources
WHERE id = $1
`
	const deactivateResourceQuery = `
UPDATE public.resources
SET status = $2, updated_at = NOW()
WHERE id = $1
`
	const deactivateServicesQuery = `
UPDATE public.services
SET status = $2, updated_at = NOW()
WHERE resource_id = $1
  AND status = $3
RETURNING id
`

	tests := []struct {
		name                     string
		id                       string
		setupMock                func(sqlmock.Sqlmock)
		searchIndexErr           error
		expectedStatus           int
		expectedBody             string
		expectedDeletedObjectIDs []string
	}{
		{
			name: "deactivates approved resource and approved child services",
			id:   "123",
			setupMock: func(mock sqlmock.Sqlmock) {
				mock.ExpectQuery(regexp.QuoteMeta(resourceStatusQuery)).
					WithArgs(123).
					WillReturnRows(sqlmock.NewRows([]string{"status"}).AddRow(db.ResourceStatusApproved))
				mock.ExpectBegin()
				mock.ExpectExec(regexp.QuoteMeta(deactivateResourceQuery)).
					WithArgs(123, db.ResourceStatusInactive).
					WillReturnResult(sqlmock.NewResult(0, 1))
				mock.ExpectQuery(regexp.QuoteMeta(deactivateServicesQuery)).
					WithArgs(123, db.ResourceStatusInactive, db.ResourceStatusApproved).
					WillReturnRows(sqlmock.NewRows([]string{"id"}).AddRow(456).AddRow(789))
				mock.ExpectCommit()
			},
			expectedStatus:           http.StatusOK,
			expectedBody:             "",
			expectedDeletedObjectIDs: []string{"resource_123", "service_456", "service_789"},
		},
		{
			name: "keeps Rails-compatible success when search index removal fails",
			id:   "123",
			setupMock: func(mock sqlmock.Sqlmock) {
				mock.ExpectQuery(regexp.QuoteMeta(resourceStatusQuery)).
					WithArgs(123).
					WillReturnRows(sqlmock.NewRows([]string{"status"}).AddRow(db.ResourceStatusApproved))
				mock.ExpectBegin()
				mock.ExpectExec(regexp.QuoteMeta(deactivateResourceQuery)).
					WithArgs(123, db.ResourceStatusInactive).
					WillReturnResult(sqlmock.NewResult(0, 1))
				mock.ExpectQuery(regexp.QuoteMeta(deactivateServicesQuery)).
					WithArgs(123, db.ResourceStatusInactive, db.ResourceStatusApproved).
					WillReturnRows(sqlmock.NewRows([]string{"id"}).AddRow(456))
				mock.ExpectCommit()
			},
			searchIndexErr:           errors.New("search index unavailable"),
			expectedStatus:           http.StatusOK,
			expectedBody:             "",
			expectedDeletedObjectIDs: []string{"resource_123", "service_456"},
		},
		{
			name: "returns precondition failed when resource is not approved",
			id:   "123",
			setupMock: func(mock sqlmock.Sqlmock) {
				mock.ExpectQuery(regexp.QuoteMeta(resourceStatusQuery)).
					WithArgs(123).
					WillReturnRows(sqlmock.NewRows([]string{"status"}).AddRow(0))
			},
			expectedStatus: http.StatusPreconditionFailed,
			expectedBody:   "",
		},
		{
			name: "returns not found when resource does not exist",
			id:   "123",
			setupMock: func(mock sqlmock.Sqlmock) {
				mock.ExpectQuery(regexp.QuoteMeta(resourceStatusQuery)).
					WithArgs(123).
					WillReturnError(sql.ErrNoRows)
			},
			expectedStatus: http.StatusNotFound,
			expectedBody:   "404: Resource not found for ID: 123\n",
		},
		{
			name:           "returns bad request for invalid id",
			id:             "abc",
			setupMock:      func(mock sqlmock.Sqlmock) {},
			expectedStatus: http.StatusBadRequest,
			expectedBody:   "Invalid resource ID\n",
		},
		{
			name: "returns internal server error when status lookup fails",
			id:   "123",
			setupMock: func(mock sqlmock.Sqlmock) {
				mock.ExpectQuery(regexp.QuoteMeta(resourceStatusQuery)).
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
				mock.ExpectQuery(regexp.QuoteMeta(resourceStatusQuery)).
					WithArgs(123).
					WillReturnRows(sqlmock.NewRows([]string{"status"}).AddRow(db.ResourceStatusApproved))
				mock.ExpectBegin()
				mock.ExpectExec(regexp.QuoteMeta(deactivateResourceQuery)).
					WithArgs(123, db.ResourceStatusInactive).
					WillReturnError(errors.New("database unavailable"))
				mock.ExpectRollback()
			},
			expectedStatus: http.StatusInternalServerError,
			expectedBody:   "Failed to deactivate resource\n",
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			sqlDB, mock, err := sqlmock.New()
			assert.NoError(t, err)
			defer sqlDB.Close()

			tt.setupMock(mock)

			indexer := &fakeSearchIndexer{err: tt.searchIndexErr}
			manager := NewWithDependencies(&db.Manager{DB: sqlDB}, indexer)
			req := requestWithResourceDeleteID(http.MethodDelete, tt.id)
			w := httptest.NewRecorder()

			manager.Delete(w, req)

			assert.Equal(t, tt.expectedStatus, w.Code)
			assert.Equal(t, tt.expectedBody, w.Body.String())
			assert.Equal(t, tt.expectedDeletedObjectIDs, indexer.deletedObjectIDs)
			assert.NoError(t, mock.ExpectationsWereMet())
		})
	}
}

func TestNewWithDependenciesDefaultsSearchIndex(t *testing.T) {
	manager := NewWithDependencies(nil, nil)
	assert.IsType(t, searchindex.NoopIndexer{}, manager.SearchIndex)
}

func requestWithResourceDeleteID(method, id string) *http.Request {
	req := httptest.NewRequest(method, "/api/resources/"+id, nil)
	routeContext := chi.NewRouteContext()
	routeContext.URLParams.Add("id", id)
	return req.WithContext(context.WithValue(req.Context(), chi.RouteCtxKey, routeContext))
}
