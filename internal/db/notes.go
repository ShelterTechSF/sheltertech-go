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

const createResourceNoteSql = `
INSERT INTO public.notes (note, resource_id, created_at, updated_at)
VALUES ($1, $2, NOW(), NOW())
RETURNING id, note, resource_id, service_id, created_at, updated_at
`

const touchResourceForNoteSql = `
UPDATE public.resources
SET updated_at = NOW()
WHERE id = $1
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

func (m *Manager) CreateResourceNote(resourceId int, note *string) (*Note, error) {
	var noteParam interface{}
	if note != nil {
		noteParam = *note
	}

	tx, err := m.DB.Begin()
	if err != nil {
		return nil, err
	}
	defer tx.Rollback()

	var dbNote Note
	row := tx.QueryRow(createResourceNoteSql, noteParam, resourceId)
	err = row.Scan(&dbNote.Id, &dbNote.Note, &dbNote.ResourceId, &dbNote.ServiceId, &dbNote.CreatedAt, &dbNote.UpdatedAt)
	if err != nil {
		return nil, err
	}

	if _, err := tx.Exec(touchResourceForNoteSql, resourceId); err != nil {
		return nil, err
	}

	if err := tx.Commit(); err != nil {
		return nil, err
	}

	return &dbNote, nil
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
