package services

import (
	"github.com/sheltertechsf/sheltertech-go/internal/addresses"
	"github.com/sheltertechsf/sheltertech-go/internal/categories"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
	"github.com/sheltertechsf/sheltertech-go/internal/documents"
	"github.com/sheltertechsf/sheltertech-go/internal/eligibilities"
	"github.com/sheltertechsf/sheltertech-go/internal/instructions"
	"github.com/sheltertechsf/sheltertech-go/internal/notes"
	"github.com/sheltertechsf/sheltertech-go/internal/programs"
	"github.com/sheltertechsf/sheltertech-go/internal/resources"
)

type ServiceResponse struct {
	Service *Service `json:"service"`
}
type Service struct {
	UpdatedAt              string `json:"updated_at"`
	AlternateName          string `json:"alternate_name"`
	ApplicationProcess     string `json:"application_process"`
	Certified              bool   `json:"certified"`
	Eligibility            string `json:"eligibility"`
	Email                  string `json:"email"`
	Fee                    string `json:"fee"`
	Id                     int    `json:"id"`
	InterpretationServices string `json:"interpretation_services"`
	LongDescription        string `json:"long_description"`
	Name                   string `json:"name"`
	RequiredDocuments      string `json:"required_documents"`
	Url                    string `json:"url"`
	VerifiedAt             string `json:"verified_at"`
	WaitTime               string `json:"wait_time"`
	CertifiedAt            string `json:"certified_at"`
	Featured               bool   `json:"featured"`
	SourceAttribution      int    `json:"source_attribution"`
	Status                 int    `json:"status"`
	InternalNote           string `json:"internal_note"`
	ShortDescription       string `json:"short_description"`

	Resource *resources.Resource `json:"resource"`
	Program  *programs.Program   `json:"program"`

	Notes         []*notes.Note                `json:"notes"`
	Categories    []*categories.Category       `json:"categories"`
	Addresses     []*addresses.Address         `json:"addresses"`
	Eligibilities []*eligibilities.Eligibility `json:"eligibilities"`
	Instructions  []*instructions.Instruction  `json:"instructions"`
	Documents     []*documents.Document        `json:"documents"`
}

func FromDBType(dbService *db.Service) *Service {
	service := &Service{
		AlternateName:          dbService.AlternateName.String,
		ApplicationProcess:     dbService.ApplicationProcess.String,
		Certified:              dbService.Certified,
		Eligibility:            dbService.Eligibility.String,
		Email:                  dbService.Email.String,
		Fee:                    dbService.Fee.String,
		Id:                     dbService.Id,
		InterpretationServices: dbService.InterpretationServices.String,
		LongDescription:        dbService.LongDescription.String,
		Name:                   dbService.Name.String,
		RequiredDocuments:      dbService.RequiredDocuments.String,
		Url:                    dbService.Url.String,
		VerifiedAt:             dbService.VerifiedAt.Time.String(),
		WaitTime:               dbService.WaitTime.String,
		CertifiedAt:            dbService.CertifiedAt.Time.String(),
		Featured:               dbService.Featured.Bool,
		SourceAttribution:      int(dbService.SourceAttribution.Int32),
		Status:                 int(dbService.Status.Int32),
		InternalNote:           dbService.InternalNote.String,
		ShortDescription:       "temp",
		UpdatedAt:              dbService.UpdatedAt.String(),
	}
	return service
}
