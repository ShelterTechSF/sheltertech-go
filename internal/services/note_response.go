package services

import (
	"database/sql"

	"github.com/sheltertechsf/sheltertech-go/internal/db"
	"github.com/sheltertechsf/sheltertech-go/internal/notes"
)

// Rails renders ActiveRecord timestamps in UTC with exactly three decimal places.
func createdServiceNoteResponse(note *db.Note) interface{} {
	return struct {
		*notes.CreatedNote
		CreatedAt *string `json:"created_at"`
		UpdatedAt *string `json:"updated_at"`
	}{notes.CreatedFromNoteDBType(note), railsNoteTime(note.CreatedAt), railsNoteTime(note.UpdatedAt)}
}

func railsNoteTime(value sql.NullTime) *string {
	if !value.Valid {
		return nil
	}
	formatted := value.Time.UTC().Format("2006-01-02T15:04:05.000Z")
	return &formatted
}
