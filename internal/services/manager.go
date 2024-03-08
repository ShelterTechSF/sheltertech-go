package services

import (
	"encoding/json"
	"fmt"
	"github.com/go-chi/chi/v5"
	"github.com/sheltertechsf/sheltertech-go/internal/addresses"
	"github.com/sheltertechsf/sheltertech-go/internal/categories"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
	"github.com/sheltertechsf/sheltertech-go/internal/documents"
	"github.com/sheltertechsf/sheltertech-go/internal/eligibilities"
	"github.com/sheltertechsf/sheltertech-go/internal/instructions"
	"github.com/sheltertechsf/sheltertech-go/internal/notes"
	"github.com/sheltertechsf/sheltertech-go/internal/phones"
	"github.com/sheltertechsf/sheltertech-go/internal/programs"
	"github.com/sheltertechsf/sheltertech-go/internal/resources"
	"github.com/sheltertechsf/sheltertech-go/internal/schedules"
	"log"
	"net/http"
	"strconv"
)

type Manager struct {
	DbClient *db.Manager
}

func New(dbManager *db.Manager) *Manager {
	manager := &Manager{
		DbClient: dbManager,
	}
	return manager
}

// GetByID Get a service by ID
//
//	@Summary		Get Service
//	@Description	gets a single service by service ID
//	@Tags			services
//	@Accept			json
//	@Produce		json
//	@Success		200	{array}	services.Service
//	@Router			/services/{id} [get]
func (m *Manager) GetByID(w http.ResponseWriter, r *http.Request) {
	serviceId, err := strconv.Atoi(chi.URLParam(r, "id"))
	if err != nil {
		log.Printf("%v", err)
	}
	dbService := m.DbClient.GetServiceById(serviceId)
	response := FromDBType(dbService)
	response.Categories = categories.FromDBTypeArray(m.DbClient.GetCategoriesByServiceID(serviceId))
	response.Notes = notes.FromNoteDBTypeArray(m.DbClient.GetNotesByServiceID(serviceId))
	response.Addresses = addresses.FromAddressesDBTypeArray(m.DbClient.GetAddressesByServiceID(serviceId))
	response.Eligibilities = eligibilities.FromEligibilitiesDBTypeArray(m.DbClient.GetEligibitiesByServiceID(serviceId))
	response.Instructions = instructions.FromInstructionDBTypeArray(m.DbClient.GetInstructionsByServiceID(serviceId))
	response.Documents = documents.FromDocumentDBTypeArray(m.DbClient.GetDocumentsByServiceID(serviceId))
	response.Schedule = schedules.FromDBType(m.DbClient.GetScheduleByServiceId(serviceId))
	if dbService.ProgramId.Valid {
		response.Program = programs.FromDBProgramType(m.DbClient.GetProgramById(int(dbService.ProgramId.Int32)))
	}
	if dbService.ResourceId.Valid {
		response.Resource = resources.FromDBType(m.DbClient.GetResourceById(int(dbService.ResourceId.Int32)))
	}
	response.Resource.Schedule = schedules.FromDBType(m.DbClient.GetScheduleByResourceId(response.Resource.Id))
	response.Resource.Categories = categories.FromDBTypeArray(m.DbClient.GetCategoriesByResourceID(response.Resource.Id))
	response.Resource.Notes = notes.FromNoteDBTypeArray(m.DbClient.GetNotesByResourceID(response.Resource.Id))
	response.Resource.Addresses = addresses.FromAddressesDBTypeArray(m.DbClient.GetAddressesByResourceID(response.Resource.Id))
	response.Resource.Phones = phones.FromDBTypeArray(m.DbClient.GetPhonesByResourceID(response.Resource.Id))
	response.Resource.Services = m.convertServicesToResourceServices(m.DbClient.GetApprovedServicesByResourceId(response.Resource.Id))

	serviceResponse := &ServiceResponse{
		Service: response,
	}
	writeJson(w, serviceResponse)
}

func writeJson(w http.ResponseWriter, object interface{}) {
	output, err := json.Marshal(object)
	if err != nil {
		fmt.Println("error:", err)
	}
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	_, err = w.Write(output)
	if err != nil {
		panic(err)
	}
}

func (m *Manager) convertServicesToResourceServices(dbServices []*db.Service) []*resources.ResourceService {
	resourceServices := []*resources.ResourceService{}
	for _, dbService := range dbServices {
		resourceService := convertServiceToResourceService(dbService)
		resourceService.Categories = categories.FromDBTypeArray(m.DbClient.GetCategoriesByServiceID(dbService.Id))
		resourceService.Notes = notes.FromNoteDBTypeArray(m.DbClient.GetNotesByServiceID(dbService.Id))
		resourceService.Addresses = addresses.FromAddressesDBTypeArray(m.DbClient.GetAddressesByServiceID(dbService.Id))
		resourceService.Eligibilities = eligibilities.FromEligibilitiesDBTypeArray(m.DbClient.GetEligibitiesByServiceID(dbService.Id))
		resourceService.Instructions = instructions.FromInstructionDBTypeArray(m.DbClient.GetInstructionsByServiceID(dbService.Id))
		resourceService.Documents = documents.FromDocumentDBTypeArray(m.DbClient.GetDocumentsByServiceID(dbService.Id))
		resourceService.Schedule = schedules.FromDBType(m.DbClient.GetScheduleByServiceId(dbService.Id))

		resourceServices = append(resourceServices, resourceService)
	}
	return resourceServices
}

func convertServiceToResourceService(dbService *db.Service) *resources.ResourceService {
	service := &resources.ResourceService{
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
