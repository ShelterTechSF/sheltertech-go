package users

import (
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"strings"
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

// SaveUser rejects a malformed request before it touches the DB, so these cases need neither a
// database nor a signed token, only an identity in the context as RequireIdentity would supply.
// This used to be covered by integration tests that posted with no Authorization header, which
// stopped reaching the handler once RequireIdentity moved in front of the route.
func TestSaveUserRejectsInvalidRequests(t *testing.T) {
	tests := []struct {
		name string
		body string
	}{
		{name: "invalid body", body: "not-json"},
		{name: "missing email", body: `{"name":"Any Name","organization":"Any Org"}`},
		{name: "empty email", body: `{"email":"","name":"Any Name"}`},
		{name: "whitespace email", body: `{"email":"   ","name":"Any Name"}`},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			manager := New(nil)

			req := httptest.NewRequest("POST", "/api/users", strings.NewReader(tt.body))
			req = req.WithContext(auth.ContextWithIdentity(req.Context(), &auth.TokenIdentity{Subject: "auth0|abc"}))
			recorder := httptest.NewRecorder()

			manager.SaveUser(recorder, req)

			if recorder.Code != http.StatusBadRequest {
				t.Fatalf("status = %d, want %d, body: %s", recorder.Code, http.StatusBadRequest, recorder.Body.String())
			}

			apiError := ApiError{}
			if err := json.Unmarshal(recorder.Body.Bytes(), &apiError); err != nil {
				t.Fatalf("failed to unmarshal body %q: %v", recorder.Body.String(), err)
			}
			if apiError.Error == "" {
				t.Errorf("response body %q should carry an error message", recorder.Body.String())
			}
		})
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
