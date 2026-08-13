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

type ServiceCreate struct {
	AlternateName          *string
	ApplicationProcess     *string
	Eligibility            *string
	Email                  *string
	Fee                    *string
	InterpretationServices *string
	LongDescription        *string
	Name                   *string
	RequiredDocuments      *string
	Url                    *string
	WaitTime               *string
	Categories             []int
	Eligibilities          []int
	Notes                  []ServiceNoteCreate
	Instructions           []ServiceInstructionCreate
	Schedule               *ServiceScheduleCreate
}

type ServiceNoteCreate struct {
	Note *string
}

type ServiceInstructionCreate struct {
	Instruction *string
}

type ServiceScheduleCreate struct {
	ScheduleDays []ServiceScheduleDayCreate
}

type ServiceScheduleDayCreate struct {
	Day      string
	OpensAt  *int
	ClosesAt *int
}

const (
	ServiceStatusPending  = 0
	ServiceStatusApproved = 1
	ServiceStatusRejected = 2
	ServiceStatusInactive = 3
)

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

const serviceCountSql = `
SELECT count(1)
FROM public.services
`

const insertServiceSql = `
INSERT INTO public.services (
	alternate_name,
	application_process,
	eligibility,
	email,
	fee,
	interpretation_services,
	long_description,
	name,
	required_documents,
	url,
	wait_time,
	resource_id,
	status,
	created_at,
	updated_at
) VALUES (
	$1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, now(), now()
) RETURNING id`

const insertCategoryServiceSql = `
INSERT INTO public.categories_services (service_id, category_id)
VALUES ($1, $2)`

const insertEligibilityServiceSql = `
INSERT INTO public.eligibilities_services (service_id, eligibility_id)
VALUES ($1, $2)`

const insertServiceNoteSql = `
INSERT INTO public.notes (note, service_id, created_at, updated_at)
VALUES ($1, $2, now(), now())`

const insertServiceInstructionSql = `
INSERT INTO public.instructions (instruction, service_id, created_at, updated_at)
VALUES ($1, $2, now(), now())`

const insertServiceScheduleSql = `
INSERT INTO public.schedules (service_id, created_at, updated_at)
VALUES ($1, now(), now())
RETURNING id`

const insertServiceScheduleDaySql = `
INSERT INTO public.schedule_days (day, opens_at, closes_at, schedule_id, created_at, updated_at)
VALUES ($1, $2, $3, $4, now(), now())`

const touchResourceSql = `
UPDATE public.resources
SET updated_at = now()
WHERE id = $1`

func (m *Manager) GetServiceById(serviceId int) (*Service, error) {
	row := m.DB.QueryRow(serviceByIDSql, serviceId)
	return scanService(row)
}

func (m *Manager) GetServicesCount() (int, error) {
	row := m.DB.QueryRow(serviceCountSql)
	var count int
	err := row.Scan(&count)
	if err != nil {
		return 0, err
	}
	return count, nil
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

func (m *Manager) CreateServicesForResource(resourceId int, services []ServiceCreate) ([]*Service, error) {
	if len(services) == 0 {
		return []*Service{}, nil
	}

	tx, err := m.DB.Begin()
	if err != nil {
		return nil, err
	}
	defer tx.Rollback()

	createdServiceIds := make([]int, 0, len(services))
	for _, service := range services {
		var serviceId int
		err = tx.QueryRow(
			insertServiceSql,
			nullableString(service.AlternateName),
			nullableString(service.ApplicationProcess),
			nullableString(service.Eligibility),
			nullableString(service.Email),
			nullableString(service.Fee),
			nullableString(service.InterpretationServices),
			nullableString(service.LongDescription),
			nullableString(service.Name),
			nullableString(service.RequiredDocuments),
			nullableString(service.Url),
			nullableString(service.WaitTime),
			resourceId,
			ServiceStatusApproved,
		).Scan(&serviceId)
		if err != nil {
			return nil, err
		}

		for _, categoryId := range service.Categories {
			if _, err = tx.Exec(insertCategoryServiceSql, serviceId, categoryId); err != nil {
				return nil, err
			}
		}

		for _, eligibilityId := range service.Eligibilities {
			if _, err = tx.Exec(insertEligibilityServiceSql, serviceId, eligibilityId); err != nil {
				return nil, err
			}
		}

		for _, note := range service.Notes {
			if _, err = tx.Exec(insertServiceNoteSql, nullableString(note.Note), serviceId); err != nil {
				return nil, err
			}
		}

		for _, instruction := range service.Instructions {
			if _, err = tx.Exec(insertServiceInstructionSql, nullableString(instruction.Instruction), serviceId); err != nil {
				return nil, err
			}
		}

		if service.Schedule != nil {
			var scheduleId int
			err = tx.QueryRow(insertServiceScheduleSql, serviceId).Scan(&scheduleId)
			if err != nil {
				return nil, err
			}
			for _, scheduleDay := range service.Schedule.ScheduleDays {
				if _, err = tx.Exec(insertServiceScheduleDaySql, scheduleDay.Day, nullableInt(scheduleDay.OpensAt), nullableInt(scheduleDay.ClosesAt), scheduleId); err != nil {
					return nil, err
				}
			}
		}

		createdServiceIds = append(createdServiceIds, serviceId)
	}

	if _, err = tx.Exec(touchResourceSql, resourceId); err != nil {
		return nil, err
	}

	if err = tx.Commit(); err != nil {
		return nil, err
	}

	createdServices := make([]*Service, 0, len(createdServiceIds))
	for _, serviceId := range createdServiceIds {
		createdService, err := m.GetServiceById(serviceId)
		if err != nil {
			return nil, err
		}
		createdServices = append(createdServices, createdService)
	}
	return createdServices, nil
}

func nullableString(value *string) interface{} {
	if value == nil {
		return nil
	}
	return *value
}

func nullableInt(value *int) interface{} {
	if value == nil {
		return nil
	}
	return *value
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
