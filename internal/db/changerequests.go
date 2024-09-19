package db

import (
	"database/sql"
	"errors"
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

const submitChangeRequest = `
INSERT INTO public.change_requests (type, object_id, status, action, resource_id, created_at, updated_at)
VALUES ($1, $2, $3, $4, $5, now(), now())`

func (m *Manager) SubmitChangeRequest(changeRequest *ChangeRequest) error {
	tx, err := m.DB.Begin()
	if err != nil {
		return err
	}
	res, err := tx.Exec(submitChangeRequest, changeRequest.Type, changeRequest.ObjectId, changeRequest.Status, changeRequest.Action, changeRequest.ResourceId)
	if err != nil {
		return err
	}
	rowCount, err := res.RowsAffected()
	if err != nil {
		return err
	}
	if rowCount != 1 {
		defer tx.Rollback()
		return errors.New(fmt.Sprintf("unexpected rows modified, expected one, saw %v", rowCount))
	}
	return tx.Commit()
}
