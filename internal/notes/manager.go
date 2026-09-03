package notes

import (
	"net/http"
	"strconv"

	"github.com/go-chi/chi/v5"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
)

type Manager struct {
	DbClient *db.Manager
}

func New(dbManager *db.Manager) *Manager {
	return &Manager{
		DbClient: dbManager,
	}
}

// Deletes a notes table row given its id.
//
//	@Summary		Delete Note
//	@Description	delete a note row given its id
//	@Tags			notes
//	@Accept			json
//	@Produce		None
//	@Success		204 No Content
//	@Router			/notes/{id} [delete]
func (m *Manager) Delete(w http.ResponseWriter, r *http.Request) {
	idStr := chi.URLParam(r, "id")
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid note ID", http.StatusBadRequest)
		return
	}

	deleted, err := m.DbClient.DeleteNoteByID(id)
	if err != nil {
		http.Error(w, "Failed to delete note", http.StatusInternalServerError)
		return
	}

	if !deleted {
		http.Error(w, "404: Note not found for ID: "+idStr, http.StatusNotFound)
		return
	}

	w.WriteHeader(http.StatusNoContent)
}
