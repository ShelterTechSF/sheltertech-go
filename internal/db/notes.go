package db

import (
	"database/sql"
	"fmt"
	"log"
)

type Note struct {
	Id         int
	Note       sql.NullString
	ResourceId sql.NullInt32
	ServiceId  sql.NullInt32
	CreatedAt  sql.NullTime
	UpdatedAt  sql.NullTime
}

const notesByServiceIDSql = `
SELECT n.id, n.note, n.created_at, n.updated_at 
FROM public.notes n
WHERE n.service_id = $1
`

const notesByResourceIDSql = `
SELECT n.id, n.note, n.created_at, n.updated_at 
FROM public.notes n
WHERE n.resource_id = $1
`

func (m *Manager) GetNotesByServiceID(serviceId int) []*Note {
	var rows *sql.Rows
	var err error
	rows, err = m.DB.Query(notesByServiceIDSql, serviceId)
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanNotes(rows)
}

func (m *Manager) GetNotesByResourceID(resourceId int) []*Note {
	var rows *sql.Rows
	var err error
	rows, err = m.DB.Query(notesByResourceIDSql, resourceId)
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanNotes(rows)
}

func scanNotes(rows *sql.Rows) []*Note {
	var notes []*Note
	for rows.Next() {
		var note Note
		err := rows.Scan(&note.Id, &note.Note, &note.CreatedAt, &note.UpdatedAt)
		switch err {
		case sql.ErrNoRows:
			fmt.Println("No rows were returned!")
			return nil
		}
		notes = append(notes, &note)
	}
	return notes
}
