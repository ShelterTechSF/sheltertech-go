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

func (m *Manager) Create(w http.ResponseWriter, r *http.Request) {
	defer r.Body.Close()
	changeRequestPayload := unmarshalPayload(w, r)

	switch changeRequestPayload.Type {
	case "phones":
		createPhone(w, m.DbClient, changeRequestPayload)
	case "schedule_days":
		createScheduleDay(w, m.DbClient, changeRequestPayload)
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

func (m *Manager) UpdateScheduleDay(w http.ResponseWriter, r *http.Request) {
	defer r.Body.Close()
	changeRequestPayload := unmarshalPayload(w, r)
	idStr := chi.URLParam(r, "id")
	scheduleDayId, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid schedule day ID", http.StatusBadRequest)
		return
	}

	scheduleDayChanges, fieldChangesResponse, err := scheduleDayChangeInputFromPayload(changeRequestPayload)
	if err != nil {
		common.WriteErrorJson(w, http.StatusBadRequest, err.Error())
		return
	}

	changeRequestId, err := m.DbClient.UpdateScheduleDayChangeRequest(scheduleDayId, scheduleDayChanges)
	if err != nil {
		common.WriteErrorJson(w, http.StatusInternalServerError, err.Error())
		return
	}

	response := &ScheduleDayChangeRequest{
		ScheduleDayChangeRequest: ChangeRequestResponse{
			Id:           *changeRequestId,
			Status:       "pending",
			Type:         "ScheduleDayChangeRequest",
			ObjectID:     scheduleDayId,
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

func createScheduleDay(w http.ResponseWriter, dbClient *db.Manager, payload ChangeRequestPayload) {
	if payload.ScheduleID == 0 {
		common.WriteErrorJson(w, http.StatusBadRequest, "Missing Required Fields")
		return
	}

	scheduleDayChanges, fieldChangesResponse, err := scheduleDayChangeInputFromPayload(payload)
	if err != nil {
		common.WriteErrorJson(w, http.StatusBadRequest, err.Error())
		return
	}

	changeRequestId, scheduleDayId, err := dbClient.InsertScheduleDayChangeRequest(payload.ScheduleID, scheduleDayChanges)
	if err != nil {
		common.WriteErrorJson(w, http.StatusInternalServerError, err.Error())
		return
	}

	response := &ScheduleDayChangeRequest{
		ScheduleDayChangeRequest: ChangeRequestResponse{
			Id:           *changeRequestId,
			Status:       "pending",
			Type:         "ScheduleDayChangeRequest",
			ObjectID:     *scheduleDayId,
			FieldChanges: fieldChangesResponse,
		},
	}

	w.Header().Set("Content-Type", "application/json")
	writeStatus(w, http.StatusCreated)
	writeJson(w, response)
}

func unmarshalPhoneFields(w http.ResponseWriter, fieldChanges json.RawMessage) PhoneFields {
	phoneFields := &PhoneFields{}
	err := json.Unmarshal(fieldChanges, phoneFields)
	if err != nil {
		common.WriteErrorJson(w, http.StatusBadRequest, err.Error())
	}

	return *phoneFields
}

func scheduleDayChangeInputFromPayload(payload ChangeRequestPayload) (db.ScheduleDayChangeInput, []FieldChange, error) {
	rawFields, err := scheduleDayPayloadFieldMap(payload.ChangeRequest)
	if err != nil {
		return db.ScheduleDayChangeInput{}, nil, err
	}

	for fieldName := range rawFields {
		if !isScheduleDayChangeField(fieldName) {
			return db.ScheduleDayChangeInput{}, nil, fmt.Errorf("Unknown attribute in request: %q", fieldName)
		}
	}

	scheduleDayChanges := db.ScheduleDayChangeInput{}
	fieldChangesResponse := []FieldChange{}
	for _, fieldName := range []string{"day", "opens_at", "closes_at"} {
		rawValue, ok := rawFields[fieldName]
		if !ok {
			continue
		}

		switch fieldName {
		case "day":
			day, fieldValue, err := scheduleDayPayloadDay(rawValue)
			if err != nil {
				return db.ScheduleDayChangeInput{}, nil, err
			}
			scheduleDayChanges.Day = day
			scheduleDayChanges.FieldChanges = append(scheduleDayChanges.FieldChanges, db.ScheduleDayFieldChangeInput{
				FieldName:  fieldName,
				FieldValue: fieldValue,
			})
			fieldChangesResponse = append(fieldChangesResponse, FieldChange{FieldName: fieldName, FieldValue: fieldValue})
		case "opens_at":
			opensAt, fieldValue, err := scheduleDayPayloadTime(rawValue)
			if err != nil {
				return db.ScheduleDayChangeInput{}, nil, err
			}
			scheduleDayChanges.OpensAt = opensAt
			scheduleDayChanges.OpensAtProvided = true
			scheduleDayChanges.FieldChanges = append(scheduleDayChanges.FieldChanges, db.ScheduleDayFieldChangeInput{
				FieldName:  fieldName,
				FieldValue: nilableScheduleDayFieldValue(fieldValue),
			})
			fieldChangesResponse = append(fieldChangesResponse, FieldChange{FieldName: fieldName, FieldValue: fieldValue})
		case "closes_at":
			closesAt, fieldValue, err := scheduleDayPayloadTime(rawValue)
			if err != nil {
				return db.ScheduleDayChangeInput{}, nil, err
			}
			scheduleDayChanges.ClosesAt = closesAt
			scheduleDayChanges.ClosesAtProvided = true
			scheduleDayChanges.FieldChanges = append(scheduleDayChanges.FieldChanges, db.ScheduleDayFieldChangeInput{
				FieldName:  fieldName,
				FieldValue: nilableScheduleDayFieldValue(fieldValue),
			})
			fieldChangesResponse = append(fieldChangesResponse, FieldChange{FieldName: fieldName, FieldValue: fieldValue})
		}
	}

	return scheduleDayChanges, fieldChangesResponse, nil
}

func scheduleDayPayloadFieldMap(changeRequest ChangeRequest) (map[string]json.RawMessage, error) {
	if len(changeRequest.FieldChanges) != 0 && strings.TrimSpace(string(changeRequest.FieldChanges)) != "null" {
		var rawFields map[string]json.RawMessage
		err := json.Unmarshal(changeRequest.FieldChanges, &rawFields)
		return rawFields, err
	}

	rawFields := map[string]json.RawMessage{}
	for fieldName, rawValue := range changeRequest.rawFields {
		if fieldName == "action" || fieldName == "field_changes" || fieldName == "type" {
			continue
		}
		rawFields[fieldName] = rawValue
	}
	return rawFields, nil
}

func isScheduleDayChangeField(fieldName string) bool {
	return fieldName == "day" || fieldName == "opens_at" || fieldName == "closes_at"
}

func scheduleDayPayloadDay(rawValue json.RawMessage) (*string, string, error) {
	if strings.TrimSpace(string(rawValue)) == "null" {
		return nil, "", fmt.Errorf("day cannot be null")
	}

	var day string
	if err := json.Unmarshal(rawValue, &day); err != nil {
		return nil, "", err
	}
	return &day, day, nil
}

func scheduleDayPayloadTime(rawValue json.RawMessage) (*int, string, error) {
	if strings.TrimSpace(string(rawValue)) == "null" {
		return nil, "", nil
	}

	var timeValue int
	if err := json.Unmarshal(rawValue, &timeValue); err == nil {
		return &timeValue, strconv.Itoa(timeValue), nil
	}

	var timeString string
	if err := json.Unmarshal(rawValue, &timeString); err != nil {
		return nil, "", err
	}

	timeValue, err := strconv.Atoi(timeString)
	if err != nil {
		return nil, "", err
	}
	return &timeValue, timeString, nil
}

func nilableScheduleDayFieldValue(fieldValue string) interface{} {
	if fieldValue == "" {
		return nil
	}
	return fieldValue
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
