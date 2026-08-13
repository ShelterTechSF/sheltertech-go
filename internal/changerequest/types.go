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

type AddressFields struct {
	Attention     *string `json:"attention,omitempty"`
	Name          *string `json:"name,omitempty"`
	Address1      *string `json:"address_1,omitempty"`
	Address2      *string `json:"address_2,omitempty"`
	Address3      *string `json:"address_3,omitempty"`
	Address4      *string `json:"address_4,omitempty"`
	City          *string `json:"city,omitempty"`
	StateProvince *string `json:"state_province,omitempty"`
	PostalCode    *string `json:"postal_code,omitempty"`
	Latitude      *string `json:"latitude,omitempty"`
	Longitude     *string `json:"longitude,omitempty"`
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

type AddressChangeRequest struct {
	AddressChangeRequest ChangeRequestResponse `json:"address_change_request"`
}
