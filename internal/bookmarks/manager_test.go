package bookmarks

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
	mockDB := new(MockBookmarkDB)
	manager := &Manager{DbClient: mockDB}

	req := httptest.NewRequest(http.MethodGet, "/api/bookmarks", nil)
	w := httptest.NewRecorder()

	manager.Get(w, req)

	assert.Equal(t, http.StatusUnauthorized, w.Code)
	mockDB.AssertNotCalled(t, "GetBookmarksByUserID")
}

func TestGet_ReturnsEmptyList_WhenUserHasNoBookmarks(t *testing.T) {
	mockDB := new(MockBookmarkDB)
	manager := &Manager{DbClient: mockDB}

	user := &db.User{Id: 1}
	mockDB.On("GetBookmarksByUserID", 1).Return([]*db.Bookmark{}, nil)

	req := withUser(httptest.NewRequest(http.MethodGet, "/api/bookmarks", nil), user)
	w := httptest.NewRecorder()

	manager.Get(w, req)

	assert.Equal(t, http.StatusOK, w.Code)
	mockDB.AssertExpectations(t)
}

func TestGet_ReturnsBookmarks_ForAuthenticatedUser(t *testing.T) {
	mockDB := new(MockBookmarkDB)
	manager := &Manager{DbClient: mockDB}

	user := &db.User{Id: 1}
	userID := 1
	mockDB.On("GetBookmarksByUserID", 1).Return([]*db.Bookmark{
		{Id: 10, UserID: &userID, Name: "my bookmark"},
	}, nil)

	req := withUser(httptest.NewRequest(http.MethodGet, "/api/bookmarks", nil), user)
	w := httptest.NewRecorder()

	manager.Get(w, req)

	assert.Equal(t, http.StatusOK, w.Code)
	assert.Contains(t, w.Body.String(), "my bookmark")
	mockDB.AssertExpectations(t)
}

// -- GetByID --

func TestGetByID_ReturnsUnauthorized_WhenNoUserInContext(t *testing.T) {
	mockDB := new(MockBookmarkDB)
	manager := &Manager{DbClient: mockDB}

	req := withChiParam(httptest.NewRequest(http.MethodGet, "/api/bookmarks/10", nil), "id", "10")
	w := httptest.NewRecorder()

	manager.GetByID(w, req)

	assert.Equal(t, http.StatusUnauthorized, w.Code)
	mockDB.AssertNotCalled(t, "GetBookmarkByID")
}

func TestGetByID_ReturnsForbidden_WhenUserDoesNotOwnBookmark(t *testing.T) {
	mockDB := new(MockBookmarkDB)
	manager := &Manager{DbClient: mockDB}

	user := &db.User{Id: 1}
	ownerID := 2
	mockDB.On("GetBookmarkByID", 10).Return(&db.Bookmark{Id: 10, UserID: &ownerID}, nil)

	req := withUser(httptest.NewRequest(http.MethodGet, "/api/bookmarks/10", nil), user)
	req = withChiParam(req, "id", "10")
	w := httptest.NewRecorder()

	manager.GetByID(w, req)

	assert.Equal(t, http.StatusForbidden, w.Code)
	mockDB.AssertExpectations(t)
}

// -- DeleteByID --

func TestDeleteByID_ReturnsNotFound_WhenBookmarkDoesNotExist(t *testing.T) {
	mockDB := new(MockBookmarkDB)
	manager := &Manager{DbClient: mockDB}

	user := &db.User{Id: 1}
	mockDB.On("GetBookmarkByID", 10).Return(nil, nil)

	req := withUser(httptest.NewRequest(http.MethodDelete, "/api/bookmarks/10", nil), user)
	req = withChiParam(req, "id", "10")
	w := httptest.NewRecorder()

	manager.DeleteByID(w, req)

	assert.Equal(t, http.StatusNotFound, w.Code)
	mockDB.AssertNotCalled(t, "DeleteBookmarkByID")
	mockDB.AssertExpectations(t)
}

func TestDeleteByID_ReturnsForbidden_WhenUserDoesNotOwnBookmark(t *testing.T) {
	mockDB := new(MockBookmarkDB)
	manager := &Manager{DbClient: mockDB}

	user := &db.User{Id: 1}
	ownerID := 2
	mockDB.On("GetBookmarkByID", 10).Return(&db.Bookmark{Id: 10, UserID: &ownerID}, nil)

	req := withUser(httptest.NewRequest(http.MethodDelete, "/api/bookmarks/10", nil), user)
	req = withChiParam(req, "id", "10")
	w := httptest.NewRecorder()

	manager.DeleteByID(w, req)

	assert.Equal(t, http.StatusForbidden, w.Code)
	mockDB.AssertNotCalled(t, "DeleteBookmarkByID")
	mockDB.AssertExpectations(t)
}
