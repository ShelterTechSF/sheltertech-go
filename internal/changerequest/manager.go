package changerequest

import (
	"encoding/json"
	"fmt"
	"io"
	"log"
	"net/http"
	"strconv"
	"strings"

	"github.com/go-chi/chi/v5"
	"github.com/nyaruka/phonenumbers"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
	fieldchanges "github.com/sheltertechsf/sheltertech-go/internal/field_changes"
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

func (m *Manager) UpdatePhone(w http.ResponseWriter, r *http.Request) {
	defer r.Body.Close()
	body, _ := io.ReadAll(r.Body)
	idStr := chi.URLParam(r, "id")
	phoneId, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid phone ID", http.StatusBadRequest)
		return
	}

	phone, err := m.DbClient.GetPhoneByID(phoneId)
	if err != nil {
		http.Error(w, "Phone not found", http.StatusBadRequest)
		return
	}

	changeRequestPayload := &ChangeRequestPayload{}
	err = json.Unmarshal(body, changeRequestPayload)
	if err != nil {
		log.Printf("Error: %v", err)
		w.WriteHeader(http.StatusBadRequest)
	}

	number := changeRequestPayload.ChangeRequest.FieldChanges.Number
	serviceType := changeRequestPayload.ChangeRequest.FieldChanges.ServiceType

	dbChangeRequest, err := m.DbClient.InsertChangeRequest(&db.ChangeRequest{
		Type:       "PhoneChangeRequest",
		ObjectId:   phoneId,
		Status:     0,
		Action:     1,
		ResourceId: phone.ResourceId,
	})
	if err != nil {
		http.Error(w, "Error inserting change request", http.StatusInternalServerError)
	}

	var fieldChanges []*fieldchanges.FieldChange

	if number != nil {
		parsed, err := phonenumbers.Parse(strings.TrimSpace(*number), "US")
		if err != nil {
			http.Error(w, "Error parsing phone number", http.StatusInternalServerError)
		}
		phone.Number = phonenumbers.Format(parsed, phonenumbers.E164)
		numberFieldChange := &db.FieldChange{
			FieldName:       "number",
			FieldValue:      phone.Number,
			ChangeRequestId: dbChangeRequest.Id,
		}
		err = m.DbClient.InsertFieldChange(*numberFieldChange)
		if err != nil {
			http.Error(w, "Error inserting number field change", http.StatusInternalServerError)
			return
		}
		fieldChanges = append(
			fieldChanges,
			fieldchanges.FromDBType(numberFieldChange),
		)
	}
	if serviceType != nil {
		phone.ServiceType = *serviceType
		servicedTypeFieldChange := &db.FieldChange{
			FieldName:       "service_type",
			FieldValue:      *serviceType,
			ChangeRequestId: dbChangeRequest.Id,
		}
		err = m.DbClient.InsertFieldChange(*servicedTypeFieldChange)
		if err != nil {
			http.Error(w, "Error inserting field change", http.StatusInternalServerError)
			return
		}
		fieldChanges = append(
			fieldChanges,
			fieldchanges.FromDBType(servicedTypeFieldChange),
		)
	}

	err = m.DbClient.UpdatePhone(phone)
	if err != nil {
		log.Printf("Update phone error %v", err)
		http.Error(w, "Error updating phone", http.StatusInternalServerError)
		return
	}

	response := &PhoneChangeRequest{
		PhoneChangeRequest: ChangeRequestResponse{
			Id:           dbChangeRequest.Id,
			Status:       "pending",
			Type:         dbChangeRequest.Type,
			ObjectID:     phone.Id,
			FieldChanges: fieldChanges,
		},
	}
	writeJson(w, response)
	writeStatus(w, http.StatusCreated)
}

func writeStatus(w http.ResponseWriter, responseStatus int) {
	w.WriteHeader(responseStatus)
}

func writeJson(w http.ResponseWriter, object interface{}) {
	output, err := json.Marshal(object)
	if err != nil {
		fmt.Println("error:", err)
	}
	w.Header().Set("Content-Type", "application/json")
	_, err = w.Write(output)
	if err != nil {
		panic(err)
	}
}
