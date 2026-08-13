package services

import (
	"context"

	"github.com/sheltertechsf/sheltertech-go/internal/addresses"
	"github.com/sheltertechsf/sheltertech-go/internal/categories"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
	"github.com/sheltertechsf/sheltertech-go/internal/documents"
	"github.com/sheltertechsf/sheltertech-go/internal/eligibilities"
	"github.com/sheltertechsf/sheltertech-go/internal/instructions"
	"github.com/sheltertechsf/sheltertech-go/internal/notes"
	"github.com/sheltertechsf/sheltertech-go/internal/programs"
	"github.com/sheltertechsf/sheltertech-go/internal/resources"
	"github.com/sheltertechsf/sheltertech-go/internal/schedules"
	"golang.org/x/text/language"
)

type ServiceResponse struct {
	Service *Service `json:"service"`
}

type ServicesCreateResponse struct {
	Services []*ServiceResponse `json:"services"`
}

type ServicesCreateRequest struct {
	Services *[]ServiceCreateRequest `json:"services"`
}

type ServiceCreateRequest struct {
	AlternateName          *string                       `json:"alternate_name"`
	ApplicationProcess     *string                       `json:"application_process"`
	Eligibility            *string                       `json:"eligibility"`
	Email                  *string                       `json:"email"`
	Fee                    *string                       `json:"fee"`
	InterpretationServices *string                       `json:"interpretation_services"`
	LongDescription        *string                       `json:"long_description"`
	Name                   *string                       `json:"name"`
	RequiredDocuments      *string                       `json:"required_documents"`
	Url                    *string                       `json:"url"`
	WaitTime               *string                       `json:"wait_time"`
	Categories             []ServiceCreateIDReference    `json:"categories"`
	Eligibilities          []ServiceCreateIDReference    `json:"eligibilities"`
	Notes                  []ServiceCreateNoteRequest    `json:"notes"`
	Instructions           []ServiceCreateInstruction    `json:"instructions"`
	Schedule               *ServiceCreateScheduleRequest `json:"schedule"`
}

type ServiceCreateIDReference struct {
	Id int `json:"id"`
}

type ServiceCreateNoteRequest struct {
	Note *string `json:"note"`
}

type ServiceCreateInstruction struct {
	Instruction *string `json:"instruction"`
}

type ServiceCreateScheduleRequest struct {
	ScheduleDays []ServiceCreateScheduleDayRequest `json:"schedule_days"`
}

type ServiceCreateScheduleDayRequest struct {
	Day      string `json:"day"`
	OpensAt  *int   `json:"opens_at"`
	ClosesAt *int   `json:"closes_at"`
}

type Service struct {
	UpdatedAt              string  `json:"updated_at"`
	AlternateName          *string `json:"alternate_name"`
	ApplicationProcess     *string `json:"application_process"`
	Certified              bool    `json:"certified"`
	Eligibility            *string `json:"eligibility"`
	Email                  *string `json:"email"`
	Fee                    *string `json:"fee"`
	Id                     int     `json:"id"`
	InterpretationServices *string `json:"interpretation_services"`
	LongDescription        *string `json:"long_description"`
	Name                   *string `json:"name"`
	RequiredDocuments      *string `json:"required_documents"`
	ShortDescription       *string `json:"short_description"`
	Url                    *string `json:"url"`
	VerifiedAt             *string `json:"verified_at"`
	WaitTime               *string `json:"wait_time"`
	CertifiedAt            *string `json:"certified_at"`
	Featured               *bool   `json:"featured"`
	SourceAttribution      string  `json:"source_attribution"`
	Status                 *string `json:"status"`
	InternalNote           *string `json:"internal_note"`

	Schedule      *schedules.Schedule          `json:"schedule"`
	Notes         []*notes.Note                `json:"notes"`
	Categories    []*categories.Category       `json:"categories"`
	Addresses     []*addresses.Address         `json:"addresses"`
	Eligibilities []*eligibilities.Eligibility `json:"eligibilities"`
	Instructions  []*instructions.Instruction  `json:"instructions"`
	Documents     []*documents.Document        `json:"documents"`
	Resource      *resources.Resource          `json:"resource"`
	Program       *programs.Program            `json:"program"`
}
type GoogleConfig struct {
	TranslateCredential string
}

type PDFCrowdConfig struct {
	Enabled bool
	User    string
	Key     string
}

// TranslateService interface for translation functionality
type TranslateService interface {
	Translate(ctx context.Context, texts []string, targetLang language.Tag) ([]string, error)
	// Close() method REMOVED - not needed since connections are short-lived
}

// PDFService interface for PDF generation functionality
type PDFService interface {
	ConvertToPDF(html string) ([]byte, error)
	// No Close() method here either - same reasoning
}

func (service ServiceCreateRequest) ToDBType() db.ServiceCreate {
	categories := make([]int, 0, len(service.Categories))
	for _, category := range service.Categories {
		categories = append(categories, category.Id)
	}

	eligibilities := make([]int, 0, len(service.Eligibilities))
	for _, eligibility := range service.Eligibilities {
		eligibilities = append(eligibilities, eligibility.Id)
	}

	notes := make([]db.ServiceNoteCreate, 0, len(service.Notes))
	for _, note := range service.Notes {
		notes = append(notes, db.ServiceNoteCreate{Note: note.Note})
	}

	instructions := make([]db.ServiceInstructionCreate, 0, len(service.Instructions))
	for _, instruction := range service.Instructions {
		instructions = append(instructions, db.ServiceInstructionCreate{Instruction: instruction.Instruction})
	}

	var schedule *db.ServiceScheduleCreate
	if service.Schedule != nil {
		scheduleDays := make([]db.ServiceScheduleDayCreate, 0, len(service.Schedule.ScheduleDays))
		for _, scheduleDay := range service.Schedule.ScheduleDays {
			scheduleDays = append(scheduleDays, db.ServiceScheduleDayCreate{
				Day:      scheduleDay.Day,
				OpensAt:  scheduleDay.OpensAt,
				ClosesAt: scheduleDay.ClosesAt,
			})
		}
		schedule = &db.ServiceScheduleCreate{ScheduleDays: scheduleDays}
	}

	return db.ServiceCreate{
		AlternateName:          service.AlternateName,
		ApplicationProcess:     service.ApplicationProcess,
		Eligibility:            service.Eligibility,
		Email:                  service.Email,
		Fee:                    service.Fee,
		InterpretationServices: service.InterpretationServices,
		LongDescription:        service.LongDescription,
		Name:                   service.Name,
		RequiredDocuments:      service.RequiredDocuments,
		Url:                    service.Url,
		WaitTime:               service.WaitTime,
		Categories:             categories,
		Eligibilities:          eligibilities,
		Notes:                  notes,
		Instructions:           instructions,
		Schedule:               schedule,
	}
}

func FromDBType(dbService *db.Service) *Service {
	service := &Service{
		Certified:         dbService.Certified,
		Id:                dbService.Id,
		SourceAttribution: SourceAttribution(int(dbService.SourceAttribution.Int32)),
		UpdatedAt:         dbService.UpdatedAt.Format("2006-01-02T15:04:05.000Z"),
	}
	if dbService.AlternateName.Valid {
		service.AlternateName = &dbService.AlternateName.String
	}
	if dbService.ApplicationProcess.Valid {
		service.ApplicationProcess = &dbService.ApplicationProcess.String
	}
	if dbService.Eligibility.Valid {
		service.Eligibility = &dbService.Eligibility.String
	}
	if dbService.Email.Valid {
		service.Email = &dbService.Email.String
	}
	if dbService.Fee.Valid {
		service.Fee = &dbService.Fee.String
	}
	if dbService.InterpretationServices.Valid {
		service.InterpretationServices = &dbService.InterpretationServices.String
	}
	if dbService.LongDescription.Valid {
		service.LongDescription = &dbService.LongDescription.String
	}
	if dbService.Name.Valid {
		service.Name = &dbService.Name.String
	}
	if dbService.RequiredDocuments.Valid {
		service.RequiredDocuments = &dbService.RequiredDocuments.String
	}
	if dbService.Url.Valid {
		service.Url = &dbService.Url.String
	}
	if dbService.VerifiedAt != nil {
		verifiedAt := dbService.VerifiedAt.Format("2006-01-02T15:04:05.000Z")
		service.VerifiedAt = &verifiedAt
	}
	if dbService.WaitTime.Valid {
		service.WaitTime = &dbService.WaitTime.String
	}
	if dbService.CertifiedAt != nil {
		certifiedAt := dbService.CertifiedAt.Format("2006-01-02T15:04:05.000Z")
		service.CertifiedAt = &certifiedAt
	}
	if dbService.Featured.Valid {
		service.Featured = &dbService.Featured.Bool
	}
	if dbService.Status.Valid {
		status := Status(int(dbService.Status.Int32))
		service.Status = &status
	}
	if dbService.InternalNote.Valid {
		service.InternalNote = &dbService.InternalNote.String
	}
	if dbService.ShortDescription.Valid {
		service.ShortDescription = &dbService.ShortDescription.String
	}
	return service
}

func Status(status int) string {
	switch status {
	case 0:
		return "pending"
	case 1:
		return "approved"
	case 2:
		return "rejected"
	case 3:
		return "inactive"
	default:
		return "unknown"
	}
}

func SourceAttribution(sourceAttribution int) string {
	switch sourceAttribution {
	case 0:
		return "ask_darcel"
	case 1:
		return "service_net"
	default:
		return "unknown"
	}
}
