package changerequest

import (
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"strconv"
	"strings"

	"github.com/go-chi/chi/v5"
	"github.com/nyaruka/phonenumbers"
	"github.com/sheltertechsf/sheltertech-go/internal/common"
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

// Create creates a new change request
//
//	@Summary		Create Change Request
//	@Description	create a new change request (e.g. for phones)
//	@Tags			change_requests
//	@Accept			json
//	@Produce		json
//	@Param			change_request	body		changerequest.ChangeRequestPayload	true	"Change request payload"
//	@Success		201				{object}	changerequest.PhoneChangeRequest
//	@Failure		400				{object}	common.Error
//	@Failure		500				{object}	common.Error
//	@Router			/change_requests [post]
func (m *Manager) Create(w http.ResponseWriter, r *http.Request) {
	defer r.Body.Close()
	changeRequestPayload := unmarshalPayload(w, r)

	switch changeRequestPayload.Type {
	case "phones":
		createPhone(w, m.DbClient, changeRequestPayload)
	}
}

// UpdatePhone updates a phone via a change request
//
//	@Summary		Update Phone Change Request
//	@Description	create a change request to update phone fields
//	@Tags			change_requests
//	@Accept			json
//	@Produce		json
//	@Param			id				path		int									true	"Phone ID"
//	@Param			change_request	body		changerequest.ChangeRequestPayload	true	"Change request payload"
//	@Success		201				{object}	changerequest.PhoneChangeRequest
//	@Failure		400				{object}	common.Error
//	@Failure		500				{object}	common.Error
//	@Router			/phones/{id}/change_requests [post]
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

	response := &PhoneChangeRequest{
		PhoneChangeRequest: ChangeRequestResponse{
			Id:           *changeRequestId,
			Status:       "pending",
			Type:         "PhoneChangeRequest",
			ObjectID:     phoneId,
			FieldChanges: fieldChangesResponse,
		},
	}

	writeJson(w, response)
	writeStatus(w, http.StatusCreated)
}

func createPhone(w http.ResponseWriter, dbClient *db.Manager, payload ChangeRequestPayload) {
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

	changeRequestId, objectId, err := dbClient.InsertPhone(fieldChangesMap)

	if err != nil {
		common.WriteErrorJson(w, http.StatusInternalServerError, err.Error())
		return
	}

	response := &PhoneChangeRequest{
		PhoneChangeRequest: ChangeRequestResponse{
			Id:           *changeRequestId,
			Status:       "pending",
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
