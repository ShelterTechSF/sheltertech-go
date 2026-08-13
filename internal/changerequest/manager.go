package changerequest

import (
	"encoding/json"
	"errors"
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

var addressChangeRequestFields = []string{
	"attention",
	"name",
	"address_1",
	"address_2",
	"address_3",
	"address_4",
	"city",
	"state_province",
	"postal_code",
	"latitude",
	"longitude",
}

func New(dbManager *db.Manager) *Manager {
	manager := &Manager{
		DbClient: dbManager,
	}
	return manager
}

func (m *Manager) Create(w http.ResponseWriter, r *http.Request) {
	defer r.Body.Close()
	changeRequestPayload := unmarshalPayload(w, r)

	switch changeRequestPayload.Type {
	case "phones":
		createPhone(w, m.DbClient, changeRequestPayload)
	}
}

func (m *Manager) UpdateResource(w http.ResponseWriter, r *http.Request) {
	defer r.Body.Close()

	payload := unmarshalPayload(w, r)

	idStr := chi.URLParam(r, "id")
	resourceId, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid resource ID", http.StatusBadRequest)
		return
	}

	resourceFields := &ResourceFields{}
	err = json.Unmarshal(payload.ChangeRequest.FieldChanges, resourceFields)
	if err != nil {
		common.WriteErrorJson(w, http.StatusBadRequest, err.Error())
		return
	}

	fieldChangesMap := make(map[string]interface{})
	fieldChangesResponse := []FieldChange{}

	if resourceFields.Name != nil {
		fieldChangesMap["name"] = *resourceFields.Name
		fieldChangesResponse = append(fieldChangesResponse, FieldChange{FieldName: "name", FieldValue: *resourceFields.Name})
	}
	if resourceFields.AlternateName != nil {
		fieldChangesMap["alternate_name"] = *resourceFields.AlternateName
		fieldChangesResponse = append(fieldChangesResponse, FieldChange{FieldName: "alternate_name", FieldValue: *resourceFields.AlternateName})
	}
	if resourceFields.ShortDescription != nil {
		fieldChangesMap["short_description"] = *resourceFields.ShortDescription
		fieldChangesResponse = append(fieldChangesResponse, FieldChange{FieldName: "short_description", FieldValue: *resourceFields.ShortDescription})
	}
	if resourceFields.LongDescription != nil {
		fieldChangesMap["long_description"] = *resourceFields.LongDescription
		fieldChangesResponse = append(fieldChangesResponse, FieldChange{FieldName: "long_description", FieldValue: *resourceFields.LongDescription})
	}
	if resourceFields.Website != nil {
		fieldChangesMap["website"] = *resourceFields.Website
		fieldChangesResponse = append(fieldChangesResponse, FieldChange{FieldName: "website", FieldValue: *resourceFields.Website})
	}
	if resourceFields.Email != nil {
		fieldChangesMap["email"] = *resourceFields.Email
		fieldChangesResponse = append(fieldChangesResponse, FieldChange{FieldName: "email", FieldValue: *resourceFields.Email})
	}
	if resourceFields.LegalStatus != nil {
		fieldChangesMap["legal_status"] = *resourceFields.LegalStatus
		fieldChangesResponse = append(fieldChangesResponse, FieldChange{FieldName: "legal_status", FieldValue: *resourceFields.LegalStatus})
	}
	if resourceFields.InternalNote != nil {
		fieldChangesMap["internal_note"] = *resourceFields.InternalNote
		fieldChangesResponse = append(fieldChangesResponse, FieldChange{FieldName: "internal_note", FieldValue: *resourceFields.InternalNote})
	}

	changeRequestId, err := m.DbClient.UpdateResource(resourceId, fieldChangesMap)
	if err != nil {
		common.WriteErrorJson(w, http.StatusInternalServerError, err.Error())
		return
	}

	response := &ResourceChangeRequest{
		ResourceChangeRequest: ChangeRequestResponse{
			Id:           *changeRequestId,
			Status:       "pending",
			Type:         "ResourceChangeRequest",
			ObjectID:     resourceId,
			FieldChanges: fieldChangesResponse,
		},
	}

	w.Header().Set("Content-Type", "application/json")
	writeStatus(w, http.StatusCreated)
	writeJson(w, response)
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

func (m *Manager) UpdateAddress(w http.ResponseWriter, r *http.Request) {
	defer r.Body.Close()

	idStr := chi.URLParam(r, "id")
	addressId, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid address ID", http.StatusBadRequest)
		return
	}

	payload, ok := decodeAddressChangeRequestPayload(w, r)
	if !ok {
		return
	}

	removeAddress, err := addressChangeRequestRemovesAddress(payload.ChangeRequest)
	if err != nil {
		common.WriteErrorJson(w, http.StatusBadRequest, err.Error())
		return
	}

	var changeRequestId *int
	fieldChangesResponse := []FieldChange{}
	if removeAddress {
		changeRequestId, err = m.DbClient.RemoveAddress(addressId)
	} else {
		var fieldChangesMap map[string]interface{}
		var responseChanges []FieldChange
		fieldChangesMap, responseChanges, err = addressFieldChangesFromPayload(payload.ChangeRequest)
		if err != nil {
			common.WriteErrorJson(w, http.StatusBadRequest, err.Error())
			return
		}
		fieldChangesResponse = responseChanges
		changeRequestId, err = m.DbClient.UpdateAddress(addressId, fieldChangesMap)
	}

	if errors.Is(err, db.ErrAddressNotFound) {
		common.WriteErrorJson(w, http.StatusNotFound, "404: Address not found for ID: "+idStr)
		return
	}
	if err != nil {
		common.WriteErrorJson(w, http.StatusInternalServerError, err.Error())
		return
	}

	response := &AddressChangeRequest{
		AddressChangeRequest: ChangeRequestResponse{
			Id:           *changeRequestId,
			Status:       "pending",
			Type:         "AddressChangeRequest",
			ObjectID:     addressId,
			FieldChanges: fieldChangesResponse,
		},
	}

	w.Header().Set("Content-Type", "application/json")
	writeStatus(w, http.StatusCreated)
	writeJson(w, response)
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

func decodeAddressChangeRequestPayload(w http.ResponseWriter, r *http.Request) (AddressChangeRequestPayload, bool) {
	body, err := io.ReadAll(r.Body)
	if err != nil {
		common.WriteErrorJson(w, http.StatusBadRequest, err.Error())
		return AddressChangeRequestPayload{}, false
	}

	payload := AddressChangeRequestPayload{}
	err = json.Unmarshal(body, &payload)
	if err != nil {
		common.WriteErrorJson(w, http.StatusBadRequest, err.Error())
		return AddressChangeRequestPayload{}, false
	}
	if len(payload.ChangeRequest) == 0 || string(payload.ChangeRequest) == "null" {
		common.WriteErrorJson(w, http.StatusBadRequest, "Missing change_request")
		return AddressChangeRequestPayload{}, false
	}

	return payload, true
}

func addressChangeRequestRemovesAddress(changeRequest json.RawMessage) (bool, error) {
	requestFields := map[string]json.RawMessage{}
	if err := json.Unmarshal(changeRequest, &requestFields); err != nil {
		return false, err
	}

	actionJSON, ok := requestFields["action"]
	if !ok {
		return false, nil
	}

	var action string
	if err := json.Unmarshal(actionJSON, &action); err != nil {
		return false, fmt.Errorf("Invalid address change request action")
	}

	switch action {
	case "remove":
		return true, nil
	case "", "edit":
		return false, nil
	default:
		return false, fmt.Errorf("Unsupported address change request action: %s", action)
	}
}

func addressFieldChangesFromPayload(changeRequest json.RawMessage) (map[string]interface{}, []FieldChange, error) {
	requestFields := map[string]json.RawMessage{}
	if err := json.Unmarshal(changeRequest, &requestFields); err != nil {
		return nil, nil, err
	}

	fieldChangesMap := make(map[string]interface{})
	fieldChangesResponse := []FieldChange{}

	for _, fieldName := range addressChangeRequestFields {
		fieldJSON, ok := requestFields[fieldName]
		if !ok {
			continue
		}

		dbValue, responseValue, err := addressChangeRequestFieldValue(fieldName, fieldJSON)
		if err != nil {
			return nil, nil, err
		}
		fieldChangesMap[fieldName] = dbValue
		fieldChangesResponse = append(fieldChangesResponse, FieldChange{
			FieldName:  fieldName,
			FieldValue: responseValue,
		})
	}

	return fieldChangesMap, fieldChangesResponse, nil
}

func addressChangeRequestFieldValue(fieldName string, rawValue json.RawMessage) (interface{}, string, error) {
	if string(rawValue) == "null" {
		return nil, "", nil
	}

	var stringValue string
	if err := json.Unmarshal(rawValue, &stringValue); err == nil {
		return stringValue, stringValue, nil
	}

	var numberValue json.Number
	decoder := json.NewDecoder(strings.NewReader(string(rawValue)))
	decoder.UseNumber()
	if err := decoder.Decode(&numberValue); err == nil {
		value := numberValue.String()
		return value, value, nil
	}

	return nil, "", fmt.Errorf("Invalid address field value for %s", fieldName)
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
