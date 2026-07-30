package users

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"strings"

	"github.com/sheltertechsf/sheltertech-go/internal/auth"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
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

// Get the currently authenticated user. This endpoint is mounted behind auth.WithOptionalUser rather
// than a rejecting middleware, because the frontend calls it to find out whether anyone is logged in,
// so an unauthenticated request is an expected outcome to report rather than a request to reject.
func (m *Manager) GetCurrent(w http.ResponseWriter, r *http.Request) {
	dbUser, err := auth.UserFromContext(r.Context())
	if err != nil {
		writeError(w, http.StatusBadRequest, "No authenticated user")
		return
	}
	user := FromDBType(dbUser)
	writeJson(w, user)
}

func (m *Manager) SaveUser(w http.ResponseWriter, r *http.Request) {
	defer r.Body.Close()

	request := SaveUserRequest{}
	err := json.NewDecoder(r.Body).Decode(&request)
	if err != nil {
		writeError(w, http.StatusBadRequest, "Invalid request body")
		return
	}

	request.Email = strings.TrimSpace(request.Email)
	if request.Email == "" {
		writeError(w, http.StatusBadRequest, "Email is required")
		return
	}

	identity, err := auth.IdentityFromContext(r.Context())
	if err != nil {
		writeError(w, http.StatusBadRequest, err.Error())
		return
	}

	usersByExternalId := m.DbClient.GetUsersByUserExternalID(identity.Subject)
	if len(usersByExternalId) > 1 {
		writeError(w, http.StatusInternalServerError, "Multiple users found for external ID")
		return
	}

	if len(usersByExternalId) == 1 {
		err = m.reconcileUser(usersByExternalId[0], request, identity.Subject)
		if err != nil {
			log.Printf("failed to reconcile user by external id: %v", err)
			writeError(w, http.StatusInternalServerError, "Unable to save user")
			return
		}
		w.WriteHeader(http.StatusNoContent)
		return
	}

	usersByEmail := m.DbClient.GetUsersByEmail(request.Email)
	if len(usersByEmail) > 1 {
		writeError(w, http.StatusInternalServerError, "Multiple users found for email")
		return
	}

	if len(usersByEmail) == 1 {
		err = m.reconcileUser(usersByEmail[0], request, identity.Subject)
		if err != nil {
			log.Printf("failed to reconcile user by email: %v", err)
			writeError(w, http.StatusInternalServerError, "Unable to save user")
			return
		}
		w.WriteHeader(http.StatusNoContent)
		return
	}

	newUser := &db.User{
		Name:           normalizeOptionalField(request.Name, ""),
		Organization:   normalizeOptionalField(request.Organization, ""),
		UserExternalId: identity.Subject,
		Email:          request.Email,
	}

	_, err = m.DbClient.CreateUser(newUser)
	if err != nil {
		log.Printf("failed to create user: %v", err)
		writeError(w, http.StatusInternalServerError, "Unable to save user")
		return
	}

	w.WriteHeader(http.StatusNoContent)
}

func (m *Manager) reconcileUser(existingUser *db.User, request SaveUserRequest, subject string) error {
	updatedUser := *existingUser
	updatedUser.Name = normalizeOptionalField(request.Name, existingUser.Name)
	updatedUser.Organization = normalizeOptionalField(request.Organization, existingUser.Organization)
	updatedUser.UserExternalId = subject
	updatedUser.Email = strings.TrimSpace(request.Email)

	if updatedUser.Name == existingUser.Name &&
		updatedUser.Organization == existingUser.Organization &&
		updatedUser.UserExternalId == existingUser.UserExternalId &&
		strings.EqualFold(updatedUser.Email, existingUser.Email) {
		return nil
	}

	return m.DbClient.UpdateUser(&updatedUser)
}

func normalizeOptionalField(value *string, existing string) string {
	if value == nil {
		return existing
	}

	trimmed := strings.TrimSpace(*value)
	if trimmed == "" {
		return existing
	}

	return trimmed
}

func writeError(w http.ResponseWriter, statusCode int, message string) {
	output, err := json.Marshal(ApiError{Error: message})
	if err != nil {
		w.WriteHeader(statusCode)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(statusCode)
	_, _ = w.Write(output)
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
