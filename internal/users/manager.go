package users

import (
	"encoding/json"
	"fmt"
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

// Get the currently authenticated user
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
		fmt.Println("error:", err)
	}
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	_, err = w.Write(output)
	if err != nil {
		panic(err)
	}
}
