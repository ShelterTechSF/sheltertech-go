package db

import (
	"database/sql"
	"fmt"
	"time"
)

type Resource struct {
	Id                int
	AlternateName     sql.NullString
	Certified         sql.NullBool
	Email             sql.NullString
	LegalStatus       sql.NullString
	LongDescription   sql.NullString
	Name              string
	ShortDescription  sql.NullString
	Status            sql.NullString
	VerifiedAt        *time.Time
	Website           sql.NullString
	CertifiedAt       *time.Time
	Featured          sql.NullBool
	SourceAttribution sql.NullString
	InternalNote      sql.NullString
	CreatedAt         time.Time
	UpdatedAt         time.Time
	ContactId         sql.NullInt32
	FundingId         sql.NullInt32
}

const (
	ResourceStatusApproved = 1
	ResourceStatusInactive = 3
)

const resourceByIDSql = `
SELECT id, name, short_description, long_description, website, verified_at, email, status, certified, alternate_name, legal_status, contact_id, funding_id, certified_at, featured, source_attribution, internal_note, updated_at
FROM public.resources
WHERE id = $1
`

const resourceStatusByIDSql = `
SELECT status
FROM public.resources
WHERE id = $1
`

const resourceCount = `
SELECT count(1)
FROM public.resources
WHERE status = 1
`

const deactivateResourceSql = `
UPDATE public.resources
SET status = $2, updated_at = NOW()
WHERE id = $1
`

const deactivateApprovedResourceServicesSql = `
UPDATE public.services
SET status = $2, updated_at = NOW()
WHERE resource_id = $1
  AND status = $3
RETURNING id
`

func (m *Manager) GetResourceById(resourceId int) *Resource {
	row := m.DB.QueryRow(resourceByIDSql, resourceId)
	return scanResource(row)
}

func (m *Manager) GetResourceStatusByID(resourceId int) (*int, error) {
	var status sql.NullInt32
	err := m.DB.QueryRow(resourceStatusByIDSql, resourceId).Scan(&status)
	if err == sql.ErrNoRows {
		return nil, nil
	}
	if err != nil {
		return nil, err
	}
	if !status.Valid {
		unknownStatus := -1
		return &unknownStatus, nil
	}

	statusValue := int(status.Int32)
	return &statusValue, nil
}

func (m *Manager) GetResourcesCount() (int, error) {
	row := m.DB.QueryRow(resourceCount)
	var count int
	err := row.Scan(&count)
	if err != nil {
		return 0, err
	}
	return count, nil

}

func (m *Manager) DeactivateResourceAndApprovedServices(resourceId int) ([]int, error) {
	tx, err := m.DB.Begin()
	if err != nil {
		return nil, err
	}
	defer tx.Rollback()

	res, err := tx.Exec(deactivateResourceSql, resourceId, ResourceStatusInactive)
	if err != nil {
		return nil, err
	}

	rowCount, err := res.RowsAffected()
	if err != nil {
		return nil, err
	}
	if rowCount != 1 {
		return nil, fmt.Errorf("unexpected rows modified, expected one, saw %v", rowCount)
	}

	rows, err := tx.Query(deactivateApprovedResourceServicesSql, resourceId, ResourceStatusInactive, ResourceStatusApproved)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var serviceIds []int
	for rows.Next() {
		var serviceId int
		if err := rows.Scan(&serviceId); err != nil {
			return nil, err
		}
		serviceIds = append(serviceIds, serviceId)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}

	return serviceIds, tx.Commit()
}

func (m *Manager) UpdateResource(
	resourceId int,
	fieldChanges map[string]interface{},
) (*int, error) {
	tx, err := m.DB.Begin()
	if err != nil {
		return nil, err
	}
	defer tx.Rollback()

	// Only update the resources row if there are field changes
	if len(fieldChanges) != 0 {
		allowed := []string{"name", "alternate_name", "short_description", "long_description", "website", "email", "legal_status", "internal_note"}
		updateResourceSql, args := buildUpdateQuery(
			"resources",
			"id",
			resourceId,
			fieldChanges,
			allowed,
		)
		_, err = tx.Exec(updateResourceSql, args...)
		if err != nil {
			return nil, err
		}
	}

	// change_requests row is inserted even if there are no field changes
	var changeRequestId int
	err = tx.QueryRow(
		insertChangeRequestSql,
		"ResourceChangeRequest",
		resourceId,
		StatusPending,
		ActionEdit,
		resourceId,
	).Scan(&changeRequestId)
	if err != nil {
		return nil, err
	}

	// insert field_changes row for each field change
	for key, value := range fieldChanges {
		_, err = tx.Exec(insertFieldChangeSql, key, value, changeRequestId)
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

func scanResource(row *sql.Row) *Resource {
	var resource Resource
	err := row.Scan(&resource.Id, &resource.Name, &resource.ShortDescription, &resource.LongDescription, &resource.Website, &resource.VerifiedAt, &resource.Email, &resource.Status, &resource.Certified, &resource.AlternateName, &resource.LegalStatus, &resource.ContactId, &resource.FundingId, &resource.CertifiedAt, &resource.Featured, &resource.SourceAttribution, &resource.InternalNote, &resource.UpdatedAt)
	if err != nil {
		switch err {
		case sql.ErrNoRows:
			fmt.Println("No rows were returned!")
			return nil
		default:
			panic(err)
		}
	}
	return &resource
}
