package resources

import (
	"strconv"

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

type ResourceResponse struct {
	Resource *Resource `json:"resource"`
}
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
		UpdatedAt: dbResource.UpdatedAt.Format("2006-01-02T15:04:05.000Z"),
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
	if dbResource.VerifiedAt != nil {
		verifiedAt := dbResource.VerifiedAt.Format("2006-01-02T15:04:05.000Z")
		resource.VerifiedAt = &verifiedAt
	}
	if dbResource.Website.Valid {
		resource.Website = &dbResource.Website.String
	}
	if dbResource.CertifiedAt != nil {
		certifiedAt := dbResource.CertifiedAt.Format("2006-01-02T15:04:05.000Z")
		resource.CertifiedAt = &certifiedAt
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

func ConvertServicesToResourceServices(dbServices []*db.Service, dbClient *db.Manager) []*ResourceService {
	resourceServices := []*ResourceService{}
	for _, dbService := range dbServices {
		resourceService := convertServiceToResourceService(dbService)
		resourceService.Categories = categories.FromDBTypeArray(dbClient.GetCategoriesByServiceID(dbService.Id))
		resourceService.Notes = notes.FromNoteDBTypeArray(dbClient.GetNotesByServiceID(dbService.Id))
		resourceService.Addresses = addresses.FromAddressesDBTypeArray(dbClient.GetAddressesByServiceID(dbService.Id))
		resourceService.Eligibilities = eligibilities.FromEligibilitiesDBTypeArray(dbClient.GetEligibitiesByServiceID(dbService.Id))
		resourceService.Instructions = instructions.FromInstructionDBTypeArray(dbClient.GetInstructionsByServiceID(dbService.Id))
		resourceService.Documents = documents.FromDocumentDBTypeArray(dbClient.GetDocumentsByServiceID(dbService.Id))
		resourceService.Schedule = schedules.FromDBType(dbClient.GetScheduleByServiceId(dbService.Id))

		resourceServices = append(resourceServices, resourceService)
	}
	return resourceServices
}

func convertServiceToResourceService(dbService *db.Service) *ResourceService {
	service := &ResourceService{
		Certified:         dbService.Certified,
		Id:                dbService.Id,
		SourceAttribution: SourceAttribution(strconv.Itoa(int(dbService.SourceAttribution.Int32))),
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
		status := Status(strconv.Itoa(int(dbService.Status.Int32)))
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
