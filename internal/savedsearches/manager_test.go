package savedsearches

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

// withUser injects a *db.User into the request context,
// simulating what EnsureValidToken middleware does at runtime.
func withUser(r *http.Request, user *db.User) *http.Request {
	return r.WithContext(auth.ContextWithUser(r.Context(), user))
}

// withChiParam injects a chi URL parameter into the request context,
// simulating what chi's router does when it matches a route like /api/saved_searches/{id}.
func withChiParam(r *http.Request, key, value string) *http.Request {
	rctx := chi.NewRouteContext()
	rctx.URLParams.Add(key, value)
	return r.WithContext(context.WithValue(r.Context(), chi.RouteCtxKey, rctx))
}

// -- Get --

func TestGet_ReturnsUnauthorized_WhenNoUserInContext(t *testing.T) {
	mockDB := new(MockSavedSearchDB)
	manager := &Manager{DbClient: mockDB}

	req := httptest.NewRequest(http.MethodGet, "/api/saved_searches", nil)
	w := httptest.NewRecorder()

	manager.Get(w, req)

	assert.Equal(t, http.StatusUnauthorized, w.Code)
	mockDB.AssertNotCalled(t, "GetSavedSearches")
}

func TestGet_ReturnsEmptyList_WhenUserHasNoSavedSearches(t *testing.T) {
	mockDB := new(MockSavedSearchDB)
	manager := &Manager{DbClient: mockDB}

	user := &db.User{Id: 1}
	mockDB.On("GetSavedSearches", 1).Return([]*db.SavedSearch{})
	mockDB.On("GetEligibilitiesByIDs", []int(nil)).Return([]*db.Eligibility{})
	mockDB.On("GetCategoriesByIDs", []int(nil)).Return([]*db.Category{})

	req := withUser(httptest.NewRequest(http.MethodGet, "/api/saved_searches", nil), user)
	w := httptest.NewRecorder()

	manager.Get(w, req)

	assert.Equal(t, http.StatusOK, w.Code)
	mockDB.AssertExpectations(t)
}

func TestGet_ReturnsSavedSearches_ForAuthenticatedUser(t *testing.T) {
	mockDB := new(MockSavedSearchDB)
	manager := &Manager{DbClient: mockDB}

	user := &db.User{Id: 1}
	mockDB.On("GetSavedSearches", 1).Return([]*db.SavedSearch{
		{Id: 10, UserId: 1, Name: "test search"},
	})
	mockDB.On("GetEligibilitiesByIDs", []int(nil)).Return([]*db.Eligibility{})
	mockDB.On("GetCategoriesByIDs", []int(nil)).Return([]*db.Category{})

	req := withUser(httptest.NewRequest(http.MethodGet, "/api/saved_searches", nil), user)
	w := httptest.NewRecorder()

	manager.Get(w, req)

	assert.Equal(t, http.StatusOK, w.Code)
	assert.Contains(t, w.Body.String(), "test search")
	mockDB.AssertExpectations(t)
}

// -- GetByID --

func TestGetByID_ReturnsForbidden_WhenUserDoesNotOwnResource(t *testing.T) {
	mockDB := new(MockSavedSearchDB)
	manager := &Manager{DbClient: mockDB}

	// user ID 1 trying to access a saved search owned by user ID 2
	user := &db.User{Id: 1}
	mockDB.On("GetSavedSearchById", 99).Return(&db.SavedSearch{Id: 99, UserId: 2})

	req := withUser(httptest.NewRequest(http.MethodGet, "/api/saved_searches/99", nil), user)
	req = withChiParam(req, "id", "99")
	w := httptest.NewRecorder()

	manager.GetByID(w, req)

	assert.Equal(t, http.StatusForbidden, w.Code)
	mockDB.AssertExpectations(t)
}

func TestGetByID_ReturnsNotFound_WhenSavedSearchDoesNotExist(t *testing.T) {
	mockDB := new(MockSavedSearchDB)
	manager := &Manager{DbClient: mockDB}

	user := &db.User{Id: 1}
	mockDB.On("GetSavedSearchById", 99).Return(nil)

	req := withUser(httptest.NewRequest(http.MethodGet, "/api/saved_searches/99", nil), user)
	req = withChiParam(req, "id", "99")
	w := httptest.NewRecorder()

	manager.GetByID(w, req)

	assert.Equal(t, http.StatusNotFound, w.Code)
	mockDB.AssertExpectations(t)
}

// -- Delete --

func TestDelete_ReturnsNotFound_WhenSavedSearchDoesNotExist(t *testing.T) {
	mockDB := new(MockSavedSearchDB)
	manager := &Manager{DbClient: mockDB}

	user := &db.User{Id: 1}
	mockDB.On("GetSavedSearchById", 99).Return(nil)

	req := withUser(httptest.NewRequest(http.MethodDelete, "/api/saved_searches/99", nil), user)
	req = withChiParam(req, "id", "99")
	w := httptest.NewRecorder()

	manager.Delete(w, req)

	assert.Equal(t, http.StatusNotFound, w.Code)
	mockDB.AssertNotCalled(t, "DeleteSavedSearchById")
	mockDB.AssertExpectations(t)
}

func TestDelete_ReturnsForbidden_WhenUserDoesNotOwnResource(t *testing.T) {
	mockDB := new(MockSavedSearchDB)
	manager := &Manager{DbClient: mockDB}

	user := &db.User{Id: 1}
	mockDB.On("GetSavedSearchById", 99).Return(&db.SavedSearch{Id: 99, UserId: 2})

	req := withUser(httptest.NewRequest(http.MethodDelete, "/api/saved_searches/99", nil), user)
	req = withChiParam(req, "id", "99")
	w := httptest.NewRecorder()

	manager.Delete(w, req)

	assert.Equal(t, http.StatusForbidden, w.Code)
	mockDB.AssertNotCalled(t, "DeleteSavedSearchById")
	mockDB.AssertExpectations(t)
}
