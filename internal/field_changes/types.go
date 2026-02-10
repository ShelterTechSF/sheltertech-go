package fieldchanges

import "github.com/sheltertechsf/sheltertech-go/internal/db"

type FieldChange struct {
	FieldName  string `json:"field_name"`
	FieldValue string `json:"field_value"`
}

func FromDBType(dbFieldChange *db.FieldChange) *FieldChange {
	return &FieldChange{
		FieldName:  dbFieldChange.FieldName,
		FieldValue: dbFieldChange.FieldValue,
	}
}
