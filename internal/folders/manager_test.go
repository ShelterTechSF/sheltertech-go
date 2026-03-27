package folders

import (
	"context"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/go-chi/chi/v5"
	"github.com/sheltertechsf/sheltertech-go/internal/auth"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
	"github.com/stretchr/testify/assert"
)

func withUser(r *http.Request, user *db.User) *http.Request {
	return r.WithContext(auth.ContextWithUser(r.Context(), user))
}

func withChiParam(r *http.Request, key, value string) *http.Request {
	rctx := chi.NewRouteContext()
	rctx.URLParams.Add(key, value)
	return r.WithContext(context.WithValue(r.Context(), chi.RouteCtxKey, rctx))
}

// -- Get --

func TestGet_ReturnsUnauthorized_WhenNoUserInContext(t *testing.T) {
	mockDB := new(MockFolderDB)
	manager := &Manager{DbClient: mockDB}

	req := httptest.NewRequest(http.MethodGet, "/api/folders", nil)
	w := httptest.NewRecorder()

	manager.Get(w, req)

	assert.Equal(t, http.StatusUnauthorized, w.Code)
	mockDB.AssertNotCalled(t, "GetFolders")
}

func TestGet_ReturnsEmptyList_WhenUserHasNoFolders(t *testing.T) {
	mockDB := new(MockFolderDB)
	manager := &Manager{DbClient: mockDB}

	user := &db.User{Id: 1}
	mockDB.On("GetFolders", 1).Return([]*db.Folder{})

	req := withUser(httptest.NewRequest(http.MethodGet, "/api/folders", nil), user)
	w := httptest.NewRecorder()

	manager.Get(w, req)

	assert.Equal(t, http.StatusOK, w.Code)
	mockDB.AssertExpectations(t)
}

func TestGet_ReturnsFolders_ForAuthenticatedUser(t *testing.T) {
	mockDB := new(MockFolderDB)
	manager := &Manager{DbClient: mockDB}

	user := &db.User{Id: 1}
	mockDB.On("GetFolders", 1).Return([]*db.Folder{
		{Id: 10, UserId: 1, Name: "my folder"},
	})

	req := withUser(httptest.NewRequest(http.MethodGet, "/api/folders", nil), user)
	w := httptest.NewRecorder()

	manager.Get(w, req)

	assert.Equal(t, http.StatusOK, w.Code)
	assert.Contains(t, w.Body.String(), "my folder")
	mockDB.AssertExpectations(t)
}

// -- GetByID --

func TestGetByID_ReturnsForbidden_WhenUserDoesNotOwnFolder(t *testing.T) {
	mockDB := new(MockFolderDB)
	manager := &Manager{DbClient: mockDB}

	user := &db.User{Id: 1}
	mockDB.On("GetFolderById", 10).Return(&db.Folder{Id: 10, UserId: 2})

	req := withUser(httptest.NewRequest(http.MethodGet, "/api/folders/10", nil), user)
	req = withChiParam(req, "id", "10")
	w := httptest.NewRecorder()

	manager.GetByID(w, req)

	assert.Equal(t, http.StatusForbidden, w.Code)
	mockDB.AssertExpectations(t)
}

func TestGetByID_ReturnsNotFound_WhenFolderDoesNotExist(t *testing.T) {
	mockDB := new(MockFolderDB)
	manager := &Manager{DbClient: mockDB}

	user := &db.User{Id: 1}
	mockDB.On("GetFolderById", 10).Return(nil)

	req := withUser(httptest.NewRequest(http.MethodGet, "/api/folders/10", nil), user)
	req = withChiParam(req, "id", "10")
	w := httptest.NewRecorder()

	manager.GetByID(w, req)

	assert.Equal(t, http.StatusNotFound, w.Code)
	mockDB.AssertExpectations(t)
}

// -- Delete --

func TestDelete_ReturnsForbidden_WhenUserDoesNotOwnFolder(t *testing.T) {
	mockDB := new(MockFolderDB)
	manager := &Manager{DbClient: mockDB}

	user := &db.User{Id: 1}
	mockDB.On("GetFolderById", 10).Return(&db.Folder{Id: 10, UserId: 2})

	req := withUser(httptest.NewRequest(http.MethodDelete, "/api/folders/10", nil), user)
	req = withChiParam(req, "id", "10")
	w := httptest.NewRecorder()

	manager.Delete(w, req)

	assert.Equal(t, http.StatusForbidden, w.Code)
	mockDB.AssertNotCalled(t, "DeleteFolderById")
	mockDB.AssertExpectations(t)
}

func TestDelete_ReturnsNotFound_WhenFolderDoesNotExist(t *testing.T) {
	mockDB := new(MockFolderDB)
	manager := &Manager{DbClient: mockDB}

	user := &db.User{Id: 1}
	mockDB.On("GetFolderById", 10).Return(nil)

	req := withUser(httptest.NewRequest(http.MethodDelete, "/api/folders/10", nil), user)
	req = withChiParam(req, "id", "10")
	w := httptest.NewRecorder()

	manager.Delete(w, req)

	assert.Equal(t, http.StatusNotFound, w.Code)
	mockDB.AssertNotCalled(t, "DeleteFolderById")
	mockDB.AssertExpectations(t)
}
