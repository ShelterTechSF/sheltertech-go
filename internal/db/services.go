package db

import (
	"database/sql"
	"fmt"
	"log"
	"time"
)

type Service struct {
	Id                     int
	CreatedAt              time.Time
	UpdatedAt              time.Time
	Name                   sql.NullString
	LongDescription        sql.NullString
	Eligibility            sql.NullString
	RequiredDocuments      sql.NullString
	Fee                    sql.NullString
	ApplicationProcess     sql.NullString
	ResourceId             sql.NullInt32
	VerifiedAt             *time.Time
	Email                  sql.NullString
	Status                 sql.NullInt32
	Certified              bool
	ProgramId              sql.NullInt32
	InterpretationServices sql.NullString
	Url                    sql.NullString
	WaitTime               sql.NullString
	ContactId              sql.NullInt32
	FundingId              sql.NullInt32
	AlternateName          sql.NullString
	CertifiedAt            *time.Time
	Featured               sql.NullBool
	SourceAttribution      sql.NullInt32
	InternalNote           sql.NullString
	ShortDescription       sql.NullString
}

const serviceByIDSql = `
SELECT id, created_at, updated_at, name, long_description, eligibility, required_documents, fee, application_process, resource_id, verified_at, email, status, certified, program_id, interpretation_services, url, wait_time, contact_id, funding_id, alternate_name, certified_at, featured, source_attribution, internal_note, short_description
FROM public.services
WHERE id = $1
`

const approvedServicesByResourceIDSql = `
SELECT id, created_at, updated_at, name, long_description, eligibility, required_documents, fee, application_process, resource_id, verified_at, email, status, certified, program_id, interpretation_services, url, wait_time, contact_id, funding_id, alternate_name, certified_at, featured, source_attribution, internal_note, short_description
FROM public.services
WHERE resource_id = $1 and status = 1
`

func (m *Manager) GetServiceById(serviceId int) (*Service, error) {
	row := m.DB.QueryRow(serviceByIDSql, serviceId)
	return scanService(row)
}

func (m *Manager) GetApprovedServicesByResourceId(resourceId int) []*Service {
	var rows *sql.Rows
	var err error
	rows, err = m.DB.Query(approvedServicesByResourceIDSql, resourceId)
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanServices(rows)
}

func scanServices(rows *sql.Rows) []*Service {
	var services []*Service
	for rows.Next() {
		var service Service
		err := rows.Scan(&service.Id, &service.CreatedAt, &service.UpdatedAt, &service.Name, &service.LongDescription, &service.Eligibility, &service.RequiredDocuments, &service.Fee, &service.ApplicationProcess, &service.ResourceId, &service.VerifiedAt, &service.Email, &service.Status, &service.Certified, &service.ProgramId, &service.InterpretationServices, &service.Url, &service.WaitTime, &service.ContactId, &service.FundingId, &service.AlternateName, &service.CertifiedAt, &service.Featured, &service.SourceAttribution, &service.InternalNote, &service.ShortDescription)
		switch err {
		case sql.ErrNoRows:
			fmt.Println("No rows were returned!")
			return nil
		}
		services = append(services, &service)
	}
	return services
}

func scanService(row *sql.Row) (*Service, error) {
	var service Service
	err := row.Scan(&service.Id, &service.CreatedAt, &service.UpdatedAt, &service.Name, &service.LongDescription, &service.Eligibility, &service.RequiredDocuments, &service.Fee, &service.ApplicationProcess, &service.ResourceId, &service.VerifiedAt, &service.Email, &service.Status, &service.Certified, &service.ProgramId, &service.InterpretationServices, &service.Url, &service.WaitTime, &service.ContactId, &service.FundingId, &service.AlternateName, &service.CertifiedAt, &service.Featured, &service.SourceAttribution, &service.InternalNote, &service.ShortDescription)
	return &service, err
}
