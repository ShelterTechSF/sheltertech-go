package changerequest

import "encoding/json"

type ChangeRequestPayload struct {
	ChangeRequest    ChangeRequest `json:"change_request"`
	ParentResourceID int           `json:"parent_resource_id"`
	Type             string        `json:"type"`
}

type ChangeRequest struct {
	Action       string          `json:"action"`
	FieldChanges json.RawMessage `json:"field_changes"`
}
type FieldChange struct {
	FieldName  string `json:"field_name"`
	FieldValue string `json:"field_value"`
}

type ChangeRequestResponse struct {
	Id           int           `json:"id"`
	Status       string        `json:"status"`
	Type         string        `json:"type"`
	ObjectID     int           `json:"object_id"`
	FieldChanges []FieldChange `json:"field_changes"`
}

type PhoneChangeRequest struct {
	PhoneChangeRequest ChangeRequestResponse `json:"phone_change_request"`
}

type PhoneFields struct {
	Number      *string `json:"number,omitempty"`
	ServiceType *string `json:"service_type,omitempty"`
}
