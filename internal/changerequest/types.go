package changerequest

import "encoding/json"

type ChangeRequestPayload struct {
	ChangeRequest    ChangeRequest `json:"change_request"`
	ParentResourceID int           `json:"parent_resource_id"`
	ScheduleID       int           `json:"schedule_id"`
	Type             string        `json:"type"`
}

type ChangeRequest struct {
	Action       string          `json:"action"`
	FieldChanges json.RawMessage `json:"field_changes"`
	rawFields    map[string]json.RawMessage
}

func (cr *ChangeRequest) UnmarshalJSON(data []byte) error {
	type changeRequestFields struct {
		Action       string          `json:"action"`
		FieldChanges json.RawMessage `json:"field_changes"`
	}

	var fields changeRequestFields
	if err := json.Unmarshal(data, &fields); err != nil {
		return err
	}

	var rawFields map[string]json.RawMessage
	if err := json.Unmarshal(data, &rawFields); err != nil {
		return err
	}

	cr.Action = fields.Action
	cr.FieldChanges = fields.FieldChanges
	cr.rawFields = rawFields
	return nil
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

type ScheduleDayChangeRequest struct {
	ScheduleDayChangeRequest ChangeRequestResponse `json:"schedule_day_change_request"`
}

type PhoneFields struct {
	Number      *string `json:"number,omitempty"`
	ServiceType *string `json:"service_type,omitempty"`
}

type ResourceFields struct {
	Name             *string `json:"name,omitempty"`
	AlternateName    *string `json:"alternate_name,omitempty"`
	ShortDescription *string `json:"short_description,omitempty"`
	LongDescription  *string `json:"long_description,omitempty"`
	Website          *string `json:"website,omitempty"`
	Email            *string `json:"email,omitempty"`
	LegalStatus      *string `json:"legal_status,omitempty"`
	InternalNote     *string `json:"internal_note,omitempty"`
}

type ResourceChangeRequest struct {
	ResourceChangeRequest ChangeRequestResponse `json:"resource_change_request"`
}
