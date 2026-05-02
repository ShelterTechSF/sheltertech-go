package phones

import (
	"net/http"
	"strconv"

	"github.com/sheltertechsf/sheltertech-go/internal/db"

	"github.com/go-chi/chi/v5"
)

type Manager struct {
	DbClient *db.Manager
}

func New(dbManager *db.Manager) *Manager {
	manager := &Manager{
		DbClient: dbManager,
	}
	return manager
}

// Deletes a phones table row given its id
//
//	@Summary		Delete Phone
//	@Description	delete a phone record by its ID
//	@Tags			phones
//	@Accept			json
//	@Param			id	path	int	true	"Phone ID"
//	@Success		204
//	@Failure		400
//	@Failure		404
//	@Failure		500
//	@Router			/phones/{id} [delete]
func (m *Manager) Delete(w http.ResponseWriter, r *http.Request) {
	idStr := chi.URLParam(r, "id")
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid phone ID", http.StatusBadRequest)
		return
	}

	phone, err := m.DbClient.GetPhoneByID(id)
	if err != nil {
		http.Error(w, "Database error", http.StatusInternalServerError)
		return
	}
	if phone == nil {
		http.Error(w, "404: Phone not found for ID: "+idStr, http.StatusNotFound)
		return
	}

	err = m.DbClient.DeletePhoneByID(id)
	if err != nil {
		http.Error(w, "Failed to delete phone", http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusNoContent)
}
