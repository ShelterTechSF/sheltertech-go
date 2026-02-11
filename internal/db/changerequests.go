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

const insertFieldChangeSql = `
INSERT INTO public.field_changes (field_name, field_value, change_request_id)
VALUES ($1, $2, $3)`

const insertChangeRequestSql = `
INSERT INTO public.change_requests (type, object_id, status, action, resource_id, created_at, updated_at)
VALUES ($1, $2, $3, $4, $5, now(), now())
RETURNING id`
