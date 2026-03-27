package users

import (
	"encoding/json"
	"fmt"
	"net/http"

	"github.com/sheltertechsf/sheltertech-go/internal/auth"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
)

type Manager struct {
	DbClient *db.Manager
}

func New(dbManager *db.Manager) *Manager {
	return &Manager{DbClient: dbManager}
}

// Get the currently authenticated user
func (m *Manager) GetCurrent(w http.ResponseWriter, r *http.Request) {
	dbUser, err := auth.UserFromContext(r.Context())
	if err != nil {
		w.WriteHeader(http.StatusUnauthorized)
		writeJson(w, ApiError{err.Error()})
		return
	}
	user := FromDBType(dbUser)
	writeJson(w, user)
}

func writeJson(w http.ResponseWriter, object interface{}) {
	output, err := json.Marshal(object)
	if err != nil {
		fmt.Println("error:", err)
	}
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	_, err = w.Write(output)
	if err != nil {
		panic(err)
	}
}
