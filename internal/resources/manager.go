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
