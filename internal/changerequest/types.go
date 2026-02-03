package changerequest

// ChangeRequest is the API request/response shape for a single change request.
type ChangeRequest struct {
	Type        string             `json:"type"`
	ObjectID    int                `json:"object_id"`
	Status      int                `json:"status"`
	Action      int                `json:"action"`
	FieldName   string             `json:"field_name,omitempty"`
	FieldValue  string             `json:"field_value,omitempty"`
	FieldChanges map[string]interface{} `json:"field_changes,omitempty"`
}

// CreateRequest is the request body for POST change_requests (Ruby: params with change_request key).
type CreateRequest struct {
	ChangeRequest *ChangeRequestPayload `json:"change_request"`
	Type          string                `json:"type,omitempty"`           // for insert: "addresses", "phones", "schedule_days"
	ParentResourceID *int                `json:"parent_resource_id,omitempty"`
	ScheduleID      *int                `json:"schedule_id,omitempty"`
}

// ChangeRequestPayload can be either flat fields or a field_changes object.
type ChangeRequestPayload struct {
	FieldChanges map[string]interface{} `json:"field_changes"`
	Action       interface{}           `json:"action,omitempty"` // "remove" for address
	// Flat fields (when field_changes is absent) are merged as field_changes
	Website string `json:"website,omitempty"`
	Name    string `json:"name,omitempty"`
	Note    string `json:"note,omitempty"`
	Number  string `json:"number,omitempty"`
	ServiceType string `json:"service_type,omitempty"`
	Address1    string `json:"address_1,omitempty"`
	City        string `json:"city,omitempty"`
	StateProvince string `json:"state_province,omitempty"`
	PostalCode   string `json:"postal_code,omitempty"`
	OpensAt   interface{} `json:"opens_at,omitempty"`
	ClosesAt  interface{} `json:"closes_at,omitempty"`
	Day      string `json:"day,omitempty"`
	Categories []struct{ Id int `json:"id"` } `json:"categories,omitempty"`
}

// CreateResponse is the 201 response (Ruby ChangeRequestsPresenter).
type CreateResponse struct {
	ID         int              `json:"id"`
	Status     int              `json:"status"`
	Type       string           `json:"type"`
	ObjectID   int              `json:"object_id"`
	FieldChanges []FieldChangeResponse `json:"field_changes"`
}

type FieldChangeResponse struct {
	FieldName  string `json:"field_name"`
	FieldValue string `json:"field_value"`
}

// CreateContext identifies which entity the change request targets (from URL path).
type CreateContext struct {
	ResourceID    *int
	ServiceID     *int
	AddressID     *int
	PhoneID       *int
	NoteID        *int
	ScheduleDayID *int
	// For POST /change_requests insert flow
	InsertType    string
	ParentResourceID *int
	ScheduleID    *int
}
