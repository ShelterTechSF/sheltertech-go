package db

import (
	"database/sql"
	"fmt"
)

type ChangeRequest struct {
	Id         int
	Type       string
	ObjectId   int
	Status     int
	Action     int
	ResourceId int
	CreatedAt  sql.NullTime
	UpdatedAt  sql.NullTime
}

type FieldChange struct {
	Id              int
	FieldName       string
	FieldValue      string
	ChangeRequestId int
}

const submitChangeRequestReturningID = `
INSERT INTO public.change_requests (type, object_id, status, action, resource_id, created_at, updated_at)
VALUES ($1, $2, $3, $4, $5, now(), now())
RETURNING id`

const submitChangeRequestNoReturn = `
INSERT INTO public.change_requests (type, object_id, status, action, resource_id, created_at, updated_at)
VALUES ($1, $2, $3, $4, $5, now(), now())`

const insertFieldChange = `
INSERT INTO public.field_changes (field_name, field_value, change_request_id)
VALUES ($1, $2, $3)`

const fieldChangesByChangeRequestID = `
SELECT id, field_name, field_value, change_request_id
FROM public.field_changes
WHERE change_request_id = $1
ORDER BY id`

func (m *Manager) SubmitChangeRequest(changeRequest *ChangeRequest) (int, error) {
	var id int
	err := m.DB.QueryRow(submitChangeRequestReturningID, changeRequest.Type, changeRequest.ObjectId, changeRequest.Status, changeRequest.Action, changeRequest.ResourceId).Scan(&id)
	if err != nil {
		return 0, err
	}
	return id, nil
}

func (m *Manager) InsertFieldChange(changeRequestID int, fieldName, fieldValue string) error {
	_, err := m.DB.Exec(insertFieldChange, fieldName, fieldValue, changeRequestID)
	return err
}

func (m *Manager) GetFieldChangesByChangeRequestID(changeRequestID int) ([]*FieldChange, error) {
	rows, err := m.DB.Query(fieldChangesByChangeRequestID, changeRequestID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var out []*FieldChange
	for rows.Next() {
		var fc FieldChange
		if err := rows.Scan(&fc.Id, &fc.FieldName, &fc.FieldValue, &fc.ChangeRequestId); err != nil {
			return nil, err
		}
		out = append(out, &fc)
	}
	return out, rows.Err()
}

// SubmitChangeRequestLegacy inserts a change request without returning id (kept for backward compatibility).
func (m *Manager) SubmitChangeRequestLegacy(changeRequest *ChangeRequest) error {
	tx, err := m.DB.Begin()
	if err != nil {
		return err
	}
	res, err := tx.Exec(submitChangeRequestNoReturn, changeRequest.Type, changeRequest.ObjectId, changeRequest.Status, changeRequest.Action, changeRequest.ResourceId)
	if err != nil {
		_ = tx.Rollback()
		return err
	}
	rowCount, err := res.RowsAffected()
	if err != nil {
		_ = tx.Rollback()
		return err
	}
	if rowCount != 1 {
		_ = tx.Rollback()
		return fmt.Errorf("unexpected rows modified, expected one, saw %v", rowCount)
	}
	return tx.Commit()
}
