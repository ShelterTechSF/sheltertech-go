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

const resourceByIDSql = `
SELECT id, name, short_description, long_description, website, verified_at, email, status, certified, alternate_name, legal_status, contact_id, funding_id, certified_at, featured, source_attribution, internal_note, updated_at
FROM public.resources
WHERE id = $1
`

const resourceCount = `
SELECT count(1)
FROM public.resources
WHERE status = 1
`

const certifyResourceSql = `
UPDATE public.resources
SET certified = true, certified_at = now()
WHERE id = $1
`

func (m *Manager) GetResourceById(resourceId int) *Resource {
	row := m.DB.QueryRow(resourceByIDSql, resourceId)
	return scanResource(row)
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

func (m *Manager) CertifyResource(resourceId int) (bool, error) {
	res, err := m.DB.Exec(certifyResourceSql, resourceId)
	if err != nil {
		return false, err
	}

	rowCount, err := res.RowsAffected()
	if err != nil {
		return false, err
	}

	return rowCount > 0, nil
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
