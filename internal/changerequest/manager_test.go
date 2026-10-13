package changerequest

import (
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"

	"github.com/go-chi/chi/v5"
	"github.com/stretchr/testify/assert"
)

func TestUpdateNoteReturnsBadRequestForInvalidNoteID(t *testing.T) {
	manager := New(nil)
	router := chi.NewRouter()
	router.Post("/api/notes/{id}/change_requests", manager.UpdateNote)

	req := httptest.NewRequest(
		http.MethodPost,
		"/api/notes/not-a-number/change_requests",
		strings.NewReader(`{"change_request":{"note":"Updated note"}}`),
	)
	w := httptest.NewRecorder()

	router.ServeHTTP(w, req)

	assert.Equal(t, http.StatusBadRequest, w.Code)
}

func TestUpdateNoteReturnsBadRequestWhenNoteFieldIsMissing(t *testing.T) {
	manager := New(nil)
	router := chi.NewRouter()
	router.Post("/api/notes/{id}/change_requests", manager.UpdateNote)

	req := httptest.NewRequest(
		http.MethodPost,
		"/api/notes/12/change_requests",
		strings.NewReader(`{"change_request":{"id":12}}`),
	)
	w := httptest.NewRecorder()

	router.ServeHTTP(w, req)

	assert.Equal(t, http.StatusBadRequest, w.Code)
}
