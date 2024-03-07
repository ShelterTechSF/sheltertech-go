package resources

import (
	"github.com/sheltertechsf/sheltertech-go/internal/addresses"
	"github.com/sheltertechsf/sheltertech-go/internal/categories"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
	"github.com/sheltertechsf/sheltertech-go/internal/documents"
	"github.com/sheltertechsf/sheltertech-go/internal/eligibilities"
	"github.com/sheltertechsf/sheltertech-go/internal/instructions"
	"github.com/sheltertechsf/sheltertech-go/internal/notes"
	"github.com/sheltertechsf/sheltertech-go/internal/phones"
	"github.com/sheltertechsf/sheltertech-go/internal/schedules"
)

type Resource struct {
	UpdatedAt         string  `json:"updated_at"`
	AlternateName     *string `json:"alternate_name"`
	Certified         *bool   `json:"certified"`
	Email             *string `json:"email"`
	Id                int     `json:"id"`
	LegalStatus       *string `json:"legal_status"`
	LongDescription   *string `json:"long_description"`
	Name              string  `json:"name"`
	ShortDescription  *string `json:"short_description"`
	Status            *string `json:"status"`
	VerifiedAt        *string `json:"verified_at"`
	Website           *string `json:"website"`
	CertifiedAt       *string `json:"certified_at"`
	Featured          *bool   `json:"featured"`
	SourceAttribution *string `json:"source_attribution"`
	InternalNote      *string `json:"internal_note"`

	Services   []*ResourceService     `json:"services"`
	Schedule   *schedules.Schedule    `json:"schedule"`
	Phones     []*phones.Phone        `json:"phones"`
	Addresses  []*addresses.Address   `json:"addresses"`
	Notes      []*notes.Note          `json:"notes"`
	Categories []*categories.Category `json:"categories"`
}

func FromDBType(dbResource *db.Resource) *Resource {
	resource := &Resource{
		Id:        dbResource.Id,
		Name:      dbResource.Name,
		UpdatedAt: dbResource.UpdatedAt.Format("2006-01-02T15:04:05.999Z07:00"),
		Services:  []*ResourceService{},
	}
	if dbResource.AlternateName.Valid {
		resource.AlternateName = &dbResource.AlternateName.String
	}
	if dbResource.Certified.Valid {
		certified := dbResource.Certified.Bool
		resource.Certified = &certified
	}
	if dbResource.Email.Valid {
		resource.Email = &dbResource.Email.String
	}
	if dbResource.LegalStatus.Valid {
		resource.LegalStatus = &dbResource.LegalStatus.String
	}
	if dbResource.LongDescription.Valid {
		resource.LongDescription = &dbResource.LongDescription.String
	}
	if dbResource.ShortDescription.Valid {
		resource.ShortDescription = &dbResource.ShortDescription.String
	}
	if dbResource.Status.Valid {
		status := Status(dbResource.Status.String)
		resource.Status = &status
	}
	if dbResource.VerifiedAt.Valid {
		resource.VerifiedAt = &dbResource.VerifiedAt.String
	}
	if dbResource.Website.Valid {
		resource.Website = &dbResource.Website.String
	}
	if dbResource.CertifiedAt.Valid {
		resource.CertifiedAt = &dbResource.CertifiedAt.String
	}
	if dbResource.Featured.Valid {
		featured := dbResource.Featured.Bool
		resource.Featured = &featured
	}
	if dbResource.SourceAttribution.Valid {
		sourceAttribution := SourceAttribution(dbResource.SourceAttribution.String)
		resource.SourceAttribution = &sourceAttribution
	}
	if dbResource.InternalNote.Valid {
		resource.InternalNote = &dbResource.InternalNote.String
	}

	return resource
}

type ResourceService struct {
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
}

func Status(status string) string {
	switch status {
	case "0":
		return "pending"
	case "1":
		return "approved"
	case "2":
		return "rejected"
	case "3":
		return "inactive"
	default:
		return "unknown"
	}
}

func SourceAttribution(sourceAttribution string) string {
	switch sourceAttribution {
	case "0":
		return "ask_darcel"
	case "1":
		return "service_net"
	default:
		return "unknown"
	}
}
