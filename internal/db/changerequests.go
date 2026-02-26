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
	ResourceId sql.NullInt32
	CreatedAt  sql.NullTime
	UpdatedAt  sql.NullTime
}

const (
	StatusPending  = 0
	StatusApproved = 1
	StatusRejected = 2
	ActionAdd      = 0
	ActionEdit     = 1
	ActionRemove   = 2
)

const insertFieldChangeSql = `
INSERT INTO public.field_changes (field_name, field_value, change_request_id)
VALUES ($1, $2, $3)`

const insertChangeRequestSql = `
INSERT INTO public.change_requests (type, object_id, status, action, resource_id, created_at, updated_at)
VALUES ($1, $2, $3, $4, $5, now(), now())
RETURNING id`

const changeRequestByIDSql = `
SELECT id, type, object_id, status, action, resource_id, created_at, updated_at
FROM public.change_requests
WHERE id = $1`

const approveChangeRequestSql = `
UPDATE public.change_requests
SET status = $1, updated_at = now()
WHERE id = $2
RETURNING id, type, object_id, status, action, resource_id, created_at, updated_at`

func (m *Manager) GetChangeRequestByID(id int) (*ChangeRequest, error) {
	row := m.DB.QueryRow(changeRequestByIDSql, id)
	var cr ChangeRequest
	err := row.Scan(&cr.Id, &cr.Type, &cr.ObjectId, &cr.Status, &cr.Action, &cr.ResourceId, &cr.CreatedAt, &cr.UpdatedAt)
	if err == sql.ErrNoRows {
		return nil, nil
	}
	if err != nil {
		return nil, fmt.Errorf("querying change request %d: %w", id, err)
	}
	return &cr, nil
}

func (m *Manager) ApproveChangeRequest(id int) (*ChangeRequest, error) {
	row := m.DB.QueryRow(approveChangeRequestSql, StatusApproved, id)
	var cr ChangeRequest
	err := row.Scan(&cr.Id, &cr.Type, &cr.ObjectId, &cr.Status, &cr.Action, &cr.ResourceId, &cr.CreatedAt, &cr.UpdatedAt)
	if err == sql.ErrNoRows {
		return nil, fmt.Errorf("change request %d not found", id)
	}
	if err != nil {
		return nil, fmt.Errorf("approving change request %d: %w", id, err)
	}
	return &cr, nil
}
