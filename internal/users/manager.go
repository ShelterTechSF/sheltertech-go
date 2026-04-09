package users

import (
	"encoding/json"
	"log"
	"net/http"

	"github.com/MicahParks/keyfunc/v3"
	"github.com/sheltertechsf/sheltertech-go/internal/auth"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
)

type Manager struct {
	DbClient   *db.Manager
	JwtKeyfunc keyfunc.Keyfunc
}

func New(dbManager *db.Manager, jwtKeyfunc keyfunc.Keyfunc) *Manager {
	manager := &Manager{
		DbClient:   dbManager,
		JwtKeyfunc: jwtKeyfunc,
	}
	return manager
}

func (m *Manager) GetCurrent(w http.ResponseWriter, r *http.Request) {
	dbUser, err := auth.GetUserFromRequest(r, m.JwtKeyfunc, m.DbClient)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		writeJson(w, ApiError{err.Error()})
		return
	}
	user := FromDBType(dbUser)
	writeJson(w, user)
}

func writeJson(w http.ResponseWriter, object interface{}) {
	output, err := json.Marshal(object)
	if err != nil {
		log.Printf("error marshaling response: %v", err)
		http.Error(w, "internal server error", http.StatusInternalServerError)
		return
	}
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	if _, err = w.Write(output); err != nil {
		log.Printf("error writing response: %v", err)
	}
}
