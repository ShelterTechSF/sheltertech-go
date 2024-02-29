package notes

import "github.com/sheltertechsf/sheltertech-go/internal/db"

type Note struct {
	Id int `json:"id"`
}

func FromNoteDBType(dbNote *db.Note) *Note {
	note := &Note{
		Id: dbNote.Id,
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
