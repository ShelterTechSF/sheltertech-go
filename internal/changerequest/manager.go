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
	"github.com/sheltertechsf/sheltertech-go/internal/algolia"
	"github.com/sheltertechsf/sheltertech-go/internal/common"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
)

type Manager struct {
	DbClient      *db.Manager
	SearchService algolia.SearchService
}

func New(dbManager *db.Manager, searchService algolia.SearchService) *Manager {
	manager := &Manager{
		DbClient:      dbManager,
		SearchService: searchService,
	}
	return manager
}

func (m *Manager) Create(w http.ResponseWriter, r *http.Request) {
	defer r.Body.Close()
	changeRequestPayload := unmarshalPayload(w, r)

	switch changeRequestPayload.Type {
	case "phones":
		m.createPhone(w, changeRequestPayload)
	}
}

func (m *Manager) UpdatePhone(w http.ResponseWriter, r *http.Request) {
	defer r.Body.Close()
	changeRequestPayload := unmarshalPayload(w, r)
	idStr := chi.URLParam(r, "id")
	phoneId, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid phone ID", http.StatusBadRequest)
		return
	}

	phoneFields := unmarshalPhoneFields(w, changeRequestPayload.ChangeRequest.FieldChanges)
	fieldChangesMap := make(map[string]interface{})
	var fieldChangesResponse []FieldChange

	if phoneFields.Number != nil {
		formatted, err := formatPhoneNumber(*phoneFields.Number)
		if err != nil {
			common.WriteErrorJson(w, http.StatusBadRequest, err.Error())
		}
		fieldChangesMap["number"] = formatted
		fieldChangesResponse = append(fieldChangesResponse, FieldChange{
			FieldName:  "number",
			FieldValue: formatted,
		})
	}
	if phoneFields.ServiceType != nil {
		fieldChangesMap["service_type"] = *phoneFields.ServiceType
		fieldChangesResponse = append(fieldChangesResponse, FieldChange{
			FieldName:  "service_type",
			FieldValue: *phoneFields.ServiceType,
		})
	}

	changeRequestId, err := m.DbClient.UpdatePhone(phoneId, fieldChangesMap)
	if err != nil {
		common.WriteErrorJson(w, http.StatusInternalServerError, err.Error())
		return
	}

	m.approveAndReindex(*changeRequestId)

	response := &PhoneChangeRequest{
		PhoneChangeRequest: ChangeRequestResponse{
			Id:           *changeRequestId,
			Status:       "approved",
			Type:         "PhoneChangeRequest",
			ObjectID:     phoneId,
			FieldChanges: fieldChangesResponse,
		},
	}

	writeJson(w, response)
	writeStatus(w, http.StatusCreated)
}

func (m *Manager) createPhone(w http.ResponseWriter, payload ChangeRequestPayload) {
	phoneFields := unmarshalPhoneFields(w, payload.ChangeRequest.FieldChanges)
	fieldChangesMap := make(map[string]interface{})
	var fieldChangesResponse []FieldChange

	if phoneFields.Number == nil || phoneFields.ServiceType == nil {
		common.WriteErrorJson(w, http.StatusBadRequest, "Missing Required Fields")
		return
	}

	formatted, err := formatPhoneNumber(*phoneFields.Number)
	if err != nil {
		common.WriteErrorJson(w, http.StatusBadRequest, err.Error())
		return
	}
	fieldChangesMap["number"] = formatted
	fieldChangesResponse = append(fieldChangesResponse, FieldChange{
		FieldName:  "number",
		FieldValue: formatted,
	})

	fieldChangesMap["service_type"] = *phoneFields.ServiceType
	fieldChangesResponse = append(fieldChangesResponse, FieldChange{
		FieldName:  "service_type",
		FieldValue: *phoneFields.ServiceType,
	})

	fieldChangesMap["resource_id"] = payload.ParentResourceID

	changeRequestId, objectId, err := m.DbClient.InsertPhone(fieldChangesMap)

	if err != nil {
		common.WriteErrorJson(w, http.StatusInternalServerError, err.Error())
		return
	}

	m.approveAndReindex(*changeRequestId)

	response := &PhoneChangeRequest{
		PhoneChangeRequest: ChangeRequestResponse{
			Id:           *changeRequestId,
			Status:       "approved",
			Type:         "PhoneChangeRequest",
			ObjectID:     *objectId,
			FieldChanges: fieldChangesResponse,
		},
	}

	writeJson(w, response)
	writeStatus(w, http.StatusCreated)
}

func unmarshalPhoneFields(w http.ResponseWriter, fieldChanges json.RawMessage) PhoneFields {
	phoneFields := &PhoneFields{}
	err := json.Unmarshal(fieldChanges, phoneFields)
	if err != nil {
		common.WriteErrorJson(w, http.StatusBadRequest, err.Error())
	}

	return *phoneFields
}

func unmarshalPayload(w http.ResponseWriter, r *http.Request) ChangeRequestPayload {
	body, _ := io.ReadAll(r.Body)
	changeRequestPayload := &ChangeRequestPayload{}
	err := json.Unmarshal(body, changeRequestPayload)
	if err != nil {
		common.WriteErrorJson(w, http.StatusBadRequest, err.Error())
	}

	return *changeRequestPayload
}

func formatPhoneNumber(number string) (string, error) {
	parsed, err := phonenumbers.Parse(strings.TrimSpace(number), "US")

	if err != nil {
		return "", err
	}

	return phonenumbers.Format(parsed, phonenumbers.E164), nil
}

func (m *Manager) approveAndReindex(changeRequestId int) {
	approved, err := m.DbClient.ApproveChangeRequest(changeRequestId)
	if err != nil {
		log.Printf("Auto-approve failed for change request %d: %v", changeRequestId, err)
		return
	}
	if approved.ResourceId.Valid {
		resourceId := int(approved.ResourceId.Int32)
		if err := m.SearchService.IndexResourceAndServices(resourceId); err != nil {
			log.Printf("Algolia reindex failed for resource %d: %v", resourceId, err)
		}
	}
}

func writeStatus(w http.ResponseWriter, responseStatus int) {
	w.WriteHeader(responseStatus)
}

func (m *Manager) Approve(w http.ResponseWriter, r *http.Request) {
	idStr := chi.URLParam(r, "id")
	id, err := strconv.Atoi(idStr)
	if err != nil {
		common.WriteErrorJson(w, http.StatusBadRequest, "Invalid change request ID")
		return
	}

	cr, err := m.DbClient.GetChangeRequestByID(id)
	if err != nil {
		common.WriteErrorJson(w, http.StatusInternalServerError, err.Error())
		return
	}
	if cr == nil {
		common.WriteErrorJson(w, http.StatusNotFound, "Change request not found")
		return
	}
	if cr.Status != db.StatusPending {
		common.WriteErrorJson(w, http.StatusBadRequest, "Change request is not pending")
		return
	}

	approved, err := m.DbClient.ApproveChangeRequest(id)
	if err != nil {
		common.WriteErrorJson(w, http.StatusInternalServerError, err.Error())
		return
	}

	if approved.ResourceId.Valid {
		resourceId := int(approved.ResourceId.Int32)
		if err := m.SearchService.IndexResourceAndServices(resourceId); err != nil {
			log.Printf("Algolia reindex failed for resource %d: %v", resourceId, err)
		}
	}

	response := &ApproveResponse{
		ChangeRequest: ChangeRequestResponse{
			Id:       approved.Id,
			Status:   "approved",
			Type:     approved.Type,
			ObjectID: approved.ObjectId,
		},
	}

	writeJson(w, response)
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
