package notes

import (
	"time"

	"github.com/sheltertechsf/sheltertech-go/internal/db"
)

type Note struct {
	Id   int     `json:"id"`
	Note *string `json:"note"`
}

type CreatedNote struct {
	Id         int        `json:"id"`
	Note       *string    `json:"note"`
	ResourceId *int32     `json:"resource_id"`
	ServiceId  *int32     `json:"service_id"`
	CreatedAt  *time.Time `json:"created_at"`
	UpdatedAt  *time.Time `json:"updated_at"`
}

func FromNoteDBType(dbNote *db.Note) *Note {
	note := &Note{
		Id: dbNote.Id,
	}
	if dbNote.Note.Valid {
		note.Note = &dbNote.Note.String
	}
	return note
}

func CreatedFromNoteDBType(dbNote *db.Note) *CreatedNote {
	note := &CreatedNote{
		Id: dbNote.Id,
	}
	if dbNote.Note.Valid {
		note.Note = &dbNote.Note.String
	}
	if dbNote.ResourceId.Valid {
		note.ResourceId = &dbNote.ResourceId.Int32
	}
	if dbNote.ServiceId.Valid {
		note.ServiceId = &dbNote.ServiceId.Int32
	}
	if dbNote.CreatedAt.Valid {
		note.CreatedAt = &dbNote.CreatedAt.Time
	}
	if dbNote.UpdatedAt.Valid {
		note.UpdatedAt = &dbNote.UpdatedAt.Time
	}
	return note
}

func FromNoteDBTypeArray(dbNotes []*db.Note) []*Note {
	notes := []*Note{}
	for _, dbNote := range dbNotes {
		notes = append(notes, FromNoteDBType(dbNote))
	}
	return notes
}
