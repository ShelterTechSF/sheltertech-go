package changerequest

type ChangeRequest struct {
	Type       string `json:"type"`
	ObjectID   int    `json:"object_id"`
	Status     int    `json:"status"`
	Action     int    `json:"action"`
	FieldName  string `json:"field_name"`
	FieldValue string `json:"field_value"`
}
