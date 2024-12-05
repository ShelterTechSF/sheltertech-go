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
