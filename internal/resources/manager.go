package resources

import (
	"encoding/json"
	"fmt"
	"github.com/go-chi/chi/v5"
	"github.com/sheltertechsf/sheltertech-go/internal/addresses"
	"github.com/sheltertechsf/sheltertech-go/internal/categories"
	"github.com/sheltertechsf/sheltertech-go/internal/common"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
	"github.com/sheltertechsf/sheltertech-go/internal/notes"
	"github.com/sheltertechsf/sheltertech-go/internal/phones"
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

// GetByID Get a resource by ID
//
//	@Summary		Get Resource
//	@Description	gets a single service by resource ID
//	@Tags			resources
//	@Accept			json
//	@Produce		json
//	@Success		200	{array}	resources.Resource
//	@Router			/resources/{id} [get]
func (m *Manager) GetByID(w http.ResponseWriter, r *http.Request) {
	resourceId, err := strconv.Atoi(chi.URLParam(r, "id"))
	if err != nil {
		log.Printf("%v", err)
	}
	dbService := m.DbClient.GetResourceById(resourceId)
	response := FromDBType(dbService)
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
	}
	w.WriteHeader(http.StatusOK)
	_, err = w.Write([]byte(strconv.Itoa(count)))
	if err != nil {
		common.WriteErrorJson(w, http.StatusInternalServerError, common.InternalServerErrorMessage)
	}
}

// Delete deactivates an approved resource and its approved child services.
//
//	@Summary		Delete Resource
//	@Description	deactivate an approved resource and its approved services
//	@Tags			resources
//	@Param			id	path	integer	true	"Resource ID"
//	@Success		200
//	@Failure		400
//	@Failure		404
//	@Failure		412
//	@Failure		500
//	@Router			/resources/{id} [delete]
func (m *Manager) Delete(w http.ResponseWriter, r *http.Request) {
	idStr := chi.URLParam(r, "id")
	resourceId, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid resource ID", http.StatusBadRequest)
		return
	}

	status, err := m.DbClient.GetResourceStatusByID(resourceId)
	if err != nil {
		http.Error(w, "Database error", http.StatusInternalServerError)
		return
	}
	if status == nil {
		http.Error(w, "404: Resource not found for ID: "+idStr, http.StatusNotFound)
		return
	}
	if *status != db.ResourceStatusApproved {
		w.WriteHeader(http.StatusPreconditionFailed)
		return
	}

	err = m.DbClient.DeactivateResourceAndApprovedServices(resourceId)
	if err != nil {
		http.Error(w, "Failed to deactivate resource", http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusOK)
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
