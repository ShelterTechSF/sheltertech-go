package db

import (
	"database/sql"
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

const insertChangeRequestSql = `
INSERT INTO public.change_requests (type, object_id, status, action, resource_id, created_at, updated_at)
VALUES ($1, $2, $3, $4, $5, now(), now())
RETURNING id`

func (m *Manager) InsertChangeRequest(
	changeRequest *ChangeRequest,
) (*ChangeRequest, error) {
	row := m.DB.QueryRow(
		insertChangeRequestSql,
		changeRequest.Type,
		changeRequest.ObjectId,
		changeRequest.Status,
		changeRequest.Action,
		changeRequest.ResourceId,
	)
	err := row.Scan(&changeRequest.Id)
	if err != nil {
		return nil, err
	}

	return changeRequest, nil
}
