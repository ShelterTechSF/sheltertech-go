package changerequest

import (
	"bytes"
	"encoding/json"
	"errors"
	"io"
	"net/http"
	"strconv"

	"github.com/go-chi/chi/v5"
	"github.com/sheltertechsf/sheltertech-go/internal/common"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
)

type ServiceChangeRequest struct {
	ServiceChangeRequest ServiceChangeRequestResponse `json:"service_change_request"`
}

type ServiceChangeRequestResponse struct {
	Id           int                               `json:"id"`
	Status       string                            `json:"status"`
	Type         string                            `json:"type"`
	ObjectID     int                               `json:"object_id"`
	FieldChanges []ServiceChangeRequestFieldChange `json:"field_changes"`
}

type ServiceChangeRequestFieldChange struct {
	FieldName  string      `json:"field_name"`
	FieldValue interface{} `json:"field_value"`
}

type serviceChangeRequestPayload struct {
	ChangeRequest json.RawMessage `json:"change_request"`
}

type serviceChangeRequestParsedFields struct {
	serviceFields []db.ServiceChangeRequestServiceFieldInput
	associations  db.ServiceChangeRequestAssociationInputs
	fieldChanges  []db.ServiceChangeRequestServiceFieldInput
	response      []ServiceChangeRequestFieldChange
}

type serviceChangeRequestRelationshipItem struct {
	ID          int  `json:"id"`
	FeatureRank *int `json:"feature_rank"`
}

func (m *Manager) UpdateService(w http.ResponseWriter, r *http.Request) {
	defer r.Body.Close()

	serviceID, err := strconv.Atoi(chi.URLParam(r, "id"))
	if err != nil {
		common.WriteErrorJson(w, http.StatusBadRequest, "Invalid service ID")
		return
	}

	body, err := io.ReadAll(r.Body)
	if err != nil {
		common.WriteErrorJson(w, http.StatusBadRequest, err.Error())
		return
	}

	parsedFields, err := serviceChangeRequestParsePayload(body)
	if err != nil {
		common.WriteErrorJson(w, http.StatusBadRequest, err.Error())
		return
	}

	changeRequestID, err := m.DbClient.UpdateServiceChangeRequest(
		serviceID,
		parsedFields.serviceFields,
		parsedFields.associations,
		parsedFields.fieldChanges,
	)
	if err != nil {
		if errors.Is(err, db.ErrServiceChangeRequestInvalidServiceID) {
			common.WriteErrorJson(w, http.StatusBadRequest, "Invalid service ID")
			return
		}
		common.WriteErrorJson(w, http.StatusInternalServerError, err.Error())
		return
	}

	response := &ServiceChangeRequest{
		ServiceChangeRequest: ServiceChangeRequestResponse{
			Id:           *changeRequestID,
			Status:       "pending",
			Type:         "ServiceChangeRequest",
			ObjectID:     serviceID,
			FieldChanges: parsedFields.response,
		},
	}

	w.Header().Set("Content-Type", "application/json")
	writeStatus(w, http.StatusCreated)
	writeJson(w, response)
}

func serviceChangeRequestParsePayload(body []byte) (*serviceChangeRequestParsedFields, error) {
	var payload serviceChangeRequestPayload
	if err := json.Unmarshal(body, &payload); err != nil {
		return nil, err
	}
	if len(payload.ChangeRequest) == 0 || bytes.Equal(bytes.TrimSpace(payload.ChangeRequest), []byte("null")) {
		return nil, errors.New("change_request is required")
	}

	var changeRequestFields map[string]json.RawMessage
	if err := json.Unmarshal(payload.ChangeRequest, &changeRequestFields); err != nil {
		return nil, err
	}
	if rawFieldChanges, ok := changeRequestFields["field_changes"]; ok {
		changeRequestFields = map[string]json.RawMessage{}
		if err := json.Unmarshal(rawFieldChanges, &changeRequestFields); err != nil {
			return nil, err
		}
	}

	parsed := &serviceChangeRequestParsedFields{}
	serviceChangeRequestAppendScalarFields(changeRequestFields, parsed)
	if err := serviceChangeRequestAppendRelationshipFields(changeRequestFields, parsed); err != nil {
		return nil, err
	}

	return parsed, nil
}

func serviceChangeRequestAppendScalarFields(fields map[string]json.RawMessage, parsed *serviceChangeRequestParsedFields) {
	for _, fieldName := range []string{
		"name",
		"alternate_name",
		"short_description",
		"long_description",
		"eligibility",
		"required_documents",
		"fee",
		"application_process",
		"email",
		"interpretation_services",
		"url",
		"wait_time",
		"internal_note",
	} {
		rawValue, ok := fields[fieldName]
		if !ok {
			continue
		}

		serviceValue, responseValue := serviceChangeRequestScalarValues(rawValue)
		parsed.serviceFields = append(parsed.serviceFields, db.ServiceChangeRequestServiceFieldInput{
			FieldName:  fieldName,
			FieldValue: serviceValue,
		})
		parsed.fieldChanges = append(parsed.fieldChanges, db.ServiceChangeRequestServiceFieldInput{
			FieldName:  fieldName,
			FieldValue: serviceValue,
		})
		parsed.response = append(parsed.response, ServiceChangeRequestFieldChange{
			FieldName:  fieldName,
			FieldValue: responseValue,
		})
	}
}

func serviceChangeRequestAppendRelationshipFields(fields map[string]json.RawMessage, parsed *serviceChangeRequestParsedFields) error {
	if rawCategories, ok := serviceChangeRequestRelationshipRawField(fields, "categories", "category_ids"); ok {
		categories, responseValue, storageValue, err := serviceChangeRequestCategoryChanges(rawCategories)
		if err != nil {
			return err
		}
		parsed.associations.Categories = &categories
		parsed.fieldChanges = append(parsed.fieldChanges, db.ServiceChangeRequestServiceFieldInput{
			FieldName:  "categories",
			FieldValue: storageValue,
		})
		parsed.response = append(parsed.response, ServiceChangeRequestFieldChange{
			FieldName:  "categories",
			FieldValue: responseValue,
		})
	}

	if rawEligibilities, ok := serviceChangeRequestRelationshipRawField(fields, "eligibilities", "eligibility_ids"); ok {
		eligibilities, responseValue, storageValue, err := serviceChangeRequestEligibilityChanges(rawEligibilities)
		if err != nil {
			return err
		}
		parsed.associations.Eligibilities = &eligibilities
		parsed.fieldChanges = append(parsed.fieldChanges, db.ServiceChangeRequestServiceFieldInput{
			FieldName:  "eligibilities",
			FieldValue: storageValue,
		})
		parsed.response = append(parsed.response, ServiceChangeRequestFieldChange{
			FieldName:  "eligibilities",
			FieldValue: responseValue,
		})
	}

	return nil
}

func serviceChangeRequestRelationshipRawField(fields map[string]json.RawMessage, primaryKey string, fallbackKey string) (json.RawMessage, bool) {
	if rawValue, ok := fields[primaryKey]; ok {
		return rawValue, true
	}
	rawValue, ok := fields[fallbackKey]
	return rawValue, ok
}

func serviceChangeRequestScalarValues(rawValue json.RawMessage) (interface{}, interface{}) {
	if bytes.Equal(bytes.TrimSpace(rawValue), []byte("null")) {
		return nil, nil
	}

	var stringValue string
	if err := json.Unmarshal(rawValue, &stringValue); err == nil {
		return stringValue, stringValue
	}

	storageValue := serviceChangeRequestCompactRawJSON(rawValue)
	var responseValue interface{}
	if err := json.Unmarshal(rawValue, &responseValue); err != nil {
		responseValue = storageValue
	}

	return storageValue, responseValue
}

func serviceChangeRequestCategoryChanges(rawValue json.RawMessage) (
	[]db.ServiceChangeRequestCategoryAssociationInput,
	interface{},
	interface{},
	error,
) {
	var rawItems []json.RawMessage
	if err := json.Unmarshal(rawValue, &rawItems); err != nil {
		return nil, nil, nil, err
	}

	categories := make([]db.ServiceChangeRequestCategoryAssociationInput, 0, len(rawItems))
	for _, rawItem := range rawItems {
		item, err := serviceChangeRequestRelationshipItemFromRaw(rawItem)
		if err != nil {
			return nil, nil, nil, err
		}
		categories = append(categories, db.ServiceChangeRequestCategoryAssociationInput{
			ID:          item.ID,
			FeatureRank: item.FeatureRank,
		})
	}

	return categories, serviceChangeRequestResponseValue(rawValue), serviceChangeRequestCompactRawJSON(rawValue), nil
}

func serviceChangeRequestEligibilityChanges(rawValue json.RawMessage) ([]int, interface{}, interface{}, error) {
	var rawItems []json.RawMessage
	if err := json.Unmarshal(rawValue, &rawItems); err != nil {
		return nil, nil, nil, err
	}

	eligibilities := make([]int, 0, len(rawItems))
	for _, rawItem := range rawItems {
		item, err := serviceChangeRequestRelationshipItemFromRaw(rawItem)
		if err != nil {
			return nil, nil, nil, err
		}
		eligibilities = append(eligibilities, item.ID)
	}

	return eligibilities, serviceChangeRequestResponseValue(rawValue), serviceChangeRequestCompactRawJSON(rawValue), nil
}

func serviceChangeRequestRelationshipItemFromRaw(rawItem json.RawMessage) (*serviceChangeRequestRelationshipItem, error) {
	var id int
	if err := json.Unmarshal(rawItem, &id); err == nil {
		return &serviceChangeRequestRelationshipItem{ID: id}, nil
	}

	var item serviceChangeRequestRelationshipItem
	if err := json.Unmarshal(rawItem, &item); err == nil && item.ID != 0 {
		return &item, nil
	}

	var stringID string
	if err := json.Unmarshal(rawItem, &stringID); err == nil {
		parsedID, err := strconv.Atoi(stringID)
		if err != nil {
			return nil, err
		}
		return &serviceChangeRequestRelationshipItem{ID: parsedID}, nil
	}

	return nil, errors.New("relationship items require an id")
}

func serviceChangeRequestResponseValue(rawValue json.RawMessage) interface{} {
	var responseValue interface{}
	if err := json.Unmarshal(rawValue, &responseValue); err != nil {
		return serviceChangeRequestCompactRawJSON(rawValue)
	}
	return responseValue
}

func serviceChangeRequestCompactRawJSON(rawValue json.RawMessage) string {
	var compacted bytes.Buffer
	if err := json.Compact(&compacted, rawValue); err != nil {
		return string(rawValue)
	}
	return compacted.String()
}
