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
//	@Summary		Delete Phones
//	@Description	delete a phones row given its id
//	@Tags			phones
//	@Accept			json
//	@Produce		None
//	@Success		200
//	@Router			/phones [delete]
func (m *Manager) Delete(w http.ResponseWriter, r *http.Request) {
    idStr := chi.URLParam(r, "id")
    id, err := strconv.Atoi(idStr)
    if err != nil {
        http.Error(w, "Invalid phone ID", http.StatusBadRequest)
        return
    }

    err = m.DbClient.DeletePhoneByID(id)
    if err != nil {
        http.Error(w, "Failed to delete phone", http.StatusInternalServerError)
        return
    }

    w.WriteHeader(http.StatusNoContent)
}
