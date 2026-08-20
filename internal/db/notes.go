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

const noteForChangeRequestSql = `
SELECT resource_id, service_id
FROM public.notes
WHERE id = $1`

const serviceResourceIDForNoteChangeRequestSql = `
SELECT resource_id
FROM public.services
WHERE id = $1`

const updateNoteForChangeRequestSql = `
UPDATE public.notes
SET note = $1, updated_at = now()
WHERE id = $2`

const touchResourceForNoteChangeRequestSql = `
UPDATE public.resources
SET updated_at = now()
WHERE id = $1`

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

func (m *Manager) UpdateNote(noteId int, noteText string) (*int, error) {
	tx, err := m.DB.Begin()
	if err != nil {
		return nil, err
	}
	defer tx.Rollback()

	var noteResourceID sql.NullInt64
	var serviceID sql.NullInt64
	err = tx.QueryRow(noteForChangeRequestSql, noteId).Scan(&noteResourceID, &serviceID)
	if err != nil {
		return nil, err
	}

	var changeRequestResourceID interface{}
	var resourceIDToTouch *int
	if noteResourceID.Valid {
		resourceID := int(noteResourceID.Int64)
		changeRequestResourceID = resourceID
		resourceIDToTouch = &resourceID
	} else if serviceID.Valid {
		var serviceResourceID sql.NullInt64
		err = tx.QueryRow(serviceResourceIDForNoteChangeRequestSql, int(serviceID.Int64)).Scan(&serviceResourceID)
		if err != nil {
			return nil, err
		}
		if serviceResourceID.Valid {
			resourceID := int(serviceResourceID.Int64)
			changeRequestResourceID = resourceID
			resourceIDToTouch = &resourceID
		}
	}

	var changeRequestId int
	err = tx.QueryRow(
		insertChangeRequestSql,
		"NoteChangeRequest",
		noteId,
		StatusPending,
		ActionEdit,
		changeRequestResourceID,
	).Scan(&changeRequestId)
	if err != nil {
		return nil, err
	}

	_, err = tx.Exec(insertFieldChangeSql, "note", noteText, changeRequestId)
	if err != nil {
		return nil, err
	}

	_, err = tx.Exec(updateNoteForChangeRequestSql, noteText, noteId)
	if err != nil {
		return nil, err
	}

	if resourceIDToTouch != nil {
		_, err = tx.Exec(touchResourceForNoteChangeRequestSql, *resourceIDToTouch)
		if err != nil {
			return nil, err
		}
	}

	err = tx.Commit()
	if err != nil {
		return nil, err
	}

	return &changeRequestId, nil
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
