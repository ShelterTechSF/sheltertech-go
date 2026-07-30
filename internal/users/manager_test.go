package users

import (
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/sheltertechsf/sheltertech-go/internal/auth"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
)

func TestGetCurrentReturnsUserFromContext(t *testing.T) {
	manager := New(nil)

	req := httptest.NewRequest("GET", "/api/users/current", nil)
	req = req.WithContext(auth.ContextWithUser(req.Context(), &db.User{
		Id:           7,
		Name:         "Any Name",
		Email:        "person@example.org",
		Organization: "Any Org",
	}))
	recorder := httptest.NewRecorder()

	manager.GetCurrent(recorder, req)

	if recorder.Code != http.StatusOK {
		t.Fatalf("status = %d, want %d, body: %s", recorder.Code, http.StatusOK, recorder.Body.String())
	}

	user := User{}
	if err := json.Unmarshal(recorder.Body.Bytes(), &user); err != nil {
		t.Fatalf("failed to unmarshal body %q: %v", recorder.Body.String(), err)
	}
	want := User{Id: 7, Name: "Any Name", Email: "person@example.org", Organization: "Any Org"}
	if user != want {
		t.Errorf("response = %+v, want %+v", user, want)
	}
}

// WithOptionalUser lets unauthenticated requests through, so this is the logged-out response the
// frontend relies on rather than a defensive branch.
func TestGetCurrentWithoutUserInContext(t *testing.T) {
	manager := New(nil)

	recorder := httptest.NewRecorder()
	manager.GetCurrent(recorder, httptest.NewRequest("GET", "/api/users/current", nil))

	if recorder.Code != http.StatusBadRequest {
		t.Fatalf("status = %d, want %d", recorder.Code, http.StatusBadRequest)
	}

	apiError := ApiError{}
	if err := json.Unmarshal(recorder.Body.Bytes(), &apiError); err != nil {
		t.Fatalf("failed to unmarshal body %q: %v", recorder.Body.String(), err)
	}
	if apiError.Error == "" {
		t.Errorf("response body %q should carry an error message", recorder.Body.String())
	}
}
