package categories

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"strconv"

	"github.com/sheltertechsf/sheltertech-go/internal/db"

	"github.com/go-chi/chi/v5"
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

// Get lists all existing categories
//
//	@Summary		Get Categories
//	@Description	get all categories
//	@Tags			categories
//	@Accept			json
//	@Produce		json
//	@Success		200	{array}	categories.Categories
//	@Router			/categories [get]
func (m *Manager) Get(w http.ResponseWriter, r *http.Request) {
	topLevelString := r.URL.Query().Get("top_level")
	var topLevel *bool
	if topLevelString != "" {
		topLevelBool, err := strconv.ParseBool(topLevelString)
		if err != nil {
			log.Printf("%v", err)
		}
		topLevel = &topLevelBool
	}
	dbCategories := m.DbClient.GetCategories(topLevel)
	response := Categories{
		Categories: FromDBTypeArray(dbCategories),
	}
	writeJson(w, response)
}

func (m *Manager) GetCategoryCounts(w http.ResponseWriter, _ *http.Request) {
	dtos := make(map[string]CategoryCountDTO)

	serviceCounts := m.DbClient.GetCategoryServiceCounts()
	for _, serviceCount := range serviceCounts {
		dto := CategoryCountDTO{}
		dto.Name = serviceCount.CategoryName
		dto.Services = serviceCount.Count
		dtos[serviceCount.CategoryName] = dto
	}

	resourceCounts := m.DbClient.GetCategoryResourceCounts()
	for _, resourceCount := range resourceCounts {
		dto, ok := dtos[resourceCount.CategoryName]
		if ok {
			dto.Resources = resourceCount.Count
		} else {
			var dto CategoryCountDTO
			dto.Name = resourceCount.CategoryName
			dto.Services = resourceCount.Count
		}
		dtos[resourceCount.CategoryName] = dto
	}
	writeJson(w, dtos)
}

func (m *Manager) GetByID(w http.ResponseWriter, r *http.Request) {
	categoryId, err := strconv.Atoi(chi.URLParam(r, "id"))
	if err != nil {
		log.Printf("%v", err)
	}
	dbCategory := m.DbClient.GetCategoryByID(categoryId)
	writeJson(w, FromDBType(dbCategory))
}

func (m *Manager) GetSubCategoriesByID(w http.ResponseWriter, r *http.Request) {
	categoryId, err := strconv.Atoi(chi.URLParam(r, "id"))
	if err != nil {
		log.Printf("%v", err)
	}
	dbCategories := m.DbClient.GetSubCategoriesByID(categoryId)
	writeJson(w, FromDBTypeArray(dbCategories))
}

func (m *Manager) GetByFeatured(w http.ResponseWriter, _ *http.Request) {
	dbCategories := m.DbClient.GetCategoriesByFeatured()
	response := Categories{
		Categories: FromDBTypeArray(dbCategories),
	}
	writeJson(w, response)
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
