package resources

import (
	"encoding/json"
	"log"
	"net/http"
	"strconv"

	"github.com/go-chi/chi/v5"
	"github.com/sheltertechsf/sheltertech-go/internal/addresses"
	"github.com/sheltertechsf/sheltertech-go/internal/categories"
	"github.com/sheltertechsf/sheltertech-go/internal/common"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
	"github.com/sheltertechsf/sheltertech-go/internal/notes"
	"github.com/sheltertechsf/sheltertech-go/internal/phones"
	"github.com/sheltertechsf/sheltertech-go/internal/schedules"
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

func (m *Manager) GetByID(w http.ResponseWriter, r *http.Request) {
	resourceId, err := strconv.Atoi(chi.URLParam(r, "id"))
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusBadRequest, "invalid resource ID")
		return
	}
	dbResource, err := m.DbClient.GetResourceById(resourceId)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusInternalServerError, common.InternalServerErrorMessage)
		return
	}
	response := FromDBType(dbResource)
	response.Schedule = schedules.FromDBType(m.DbClient.GetScheduleByResourceId(resourceId))
	response.Categories = categories.FromDBTypeArray(m.DbClient.GetCategoriesByResourceID(resourceId))
	response.Notes = notes.FromNoteDBTypeArray(m.DbClient.GetNotesByResourceID(resourceId))
	response.Addresses = addresses.FromAddressesDBTypeArray(m.DbClient.GetAddressesByResourceID(resourceId))
	response.Phones = phones.FromDBTypeArray(m.DbClient.GetPhonesByResourceID(resourceId))
	response.Services = ConvertServicesToResourceServices(m.DbClient.GetApprovedServicesByResourceId(resourceId), m.DbClient)

	resourceResponse := &ResourceResponse{
		Resource: response,
	}
	writeJson(w, resourceResponse)
}

func (m *Manager) GetCount(w http.ResponseWriter, r *http.Request) {
	count, err := m.DbClient.GetResourcesCount()
	if err != nil {
		common.WriteErrorJson(w, http.StatusInternalServerError, common.InternalServerErrorMessage)
		return
	}
	w.WriteHeader(http.StatusOK)
	if _, err = w.Write([]byte(strconv.Itoa(count))); err != nil {
		log.Printf("error writing response: %v", err)
	}
}

func writeJson(w http.ResponseWriter, object interface{}) {
	output, err := json.Marshal(object)
	if err != nil {
		log.Printf("error marshaling response: %v", err)
		http.Error(w, "internal server error", http.StatusInternalServerError)
		return
	}
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	if _, err = w.Write(output); err != nil {
		log.Printf("error writing response: %v", err)
	}
}
