package services

import (
	"encoding/json"
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
	"github.com/sheltertechsf/sheltertech-go/internal/common"	
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
		common.WriteErrorJson(w, http.StatusBadRequest, err.Error())
		return		
	}
	dbService, err := m.DbClient.GetServiceById(serviceId)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusBadRequest, err.Error())
		return		
	}
	response := FromDBType(dbService)
	response.Categories = categories.FromDBTypeArray(m.DbClient.GetCategoriesByServiceID(serviceId))
	response.Notes = notes.FromNoteDBTypeArray(m.DbClient.GetNotesByServiceID(serviceId))
	response.Addresses = addresses.FromAddressesDBTypeArray(m.DbClient.GetAddressesByServiceID(serviceId))
	response.Eligibilities = eligibilities.FromEligibilitiesDBTypeArray(m.DbClient.GetEligibilitiesByServiceID(serviceId))
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
	response.Resource.Services = resources.ConvertServicesToResourceServices(m.DbClient.GetApprovedServicesByResourceId(response.Resource.Id), m.DbClient)

	serviceResponse := &ServiceResponse{
		Service: response,
	}
	writeJson(w, serviceResponse)
}

func writeJson(w http.ResponseWriter, object interface{}) {
	output, err := json.Marshal(object)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusInternalServerError, common.InternalServerErrorMessage)
		return
	}
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	_, err = w.Write(output)
	if err != nil {
		panic(err)
	}
}
