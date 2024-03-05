package notes

import "github.com/sheltertechsf/sheltertech-go/internal/db"

type Note struct {
	Id   int     `json:"id"`
	Note *string `json:"note"`
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

func FromNoteDBTypeArray(dbNotes []*db.Note) []*Note {
	var notes []*Note
	for _, dbNote := range dbNotes {
		notes = append(notes, FromNoteDBType(dbNote))
	}
	return notes
}
