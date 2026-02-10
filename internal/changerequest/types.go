package changerequest

import (
	fieldchanges "github.com/sheltertechsf/sheltertech-go/internal/field_changes"
)

type ChangeRequestPayload struct {
	ChangeRequest    ChangeRequest `json:"change_request"`
	ParentResourceID int           `json:"parent_resource_id"`
	Type             string        `json:"type"`
}

type ChangeRequest struct {
	Action       string              `json:"action"`
	FieldChanges ChangeRequestFields `json:"field_changes"`
}

type ChangeRequestFields struct {
	Number      *string `json:"number"`
	ServiceType *string `json:"service_type"`
}

type ChangeRequestResponse struct {
	Id           int                         `json:"id"`
	Status       string                      `json:"status"`
	Type         string                      `json:"type"`
	ObjectID     int                         `json:"object_id"`
	FieldChanges []*fieldchanges.FieldChange `json:"field_changes"`
}

type PhoneChangeRequest struct {
	PhoneChangeRequest ChangeRequestResponse `json:"phone_change_request"`
}
