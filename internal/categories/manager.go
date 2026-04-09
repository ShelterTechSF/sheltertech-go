package categories

import (
	"encoding/json"
	"log"
	"net/http"
	"sort"
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
	allCategories := m.DbClient.GetCategories(nil)

	countsMap := make(map[string]CategoryCountDTO)

	for _, category := range allCategories {
		countsMap[category.Name] = CategoryCountDTO{
			Name:      category.Name,
			Services:  0,
			Resources: 0,
		}
	}

	serviceCounts := m.DbClient.GetCategoryServiceCounts()
	for _, serviceCount := range serviceCounts {
		if dto, exists := countsMap[serviceCount.CategoryName]; exists {
			dto.Services = serviceCount.Count
			countsMap[serviceCount.CategoryName] = dto
		}
	}

	resourceCounts := m.DbClient.GetCategoryResourceCounts()
	for _, resourceCount := range resourceCounts {
		if dto, exists := countsMap[resourceCount.CategoryName]; exists {
			dto.Resources = resourceCount.Count
			countsMap[resourceCount.CategoryName] = dto
		}
	}

	var response []CategoryCountDTO
	for _, dto := range countsMap {
		response = append(response, dto)
	}

	sort.Slice(response, func(i, j int) bool {
		return response[i].Name < response[j].Name
	})

	writeJson(w, response)
}

func (m *Manager) GetByID(w http.ResponseWriter, r *http.Request) {
	categoryId, err := strconv.Atoi(chi.URLParam(r, "id"))
	if err != nil {
		log.Printf("%v", err)
	}
	dbCategory, err := m.DbClient.GetCategoryByID(categoryId)
	if err != nil {
		log.Printf("%v", err)
		http.Error(w, "internal server error", http.StatusInternalServerError)
		return
	}
	writeJson(w, FromDBType(dbCategory))
}

func (m *Manager) GetSubCategoriesByID(w http.ResponseWriter, r *http.Request) {
	categoryId, err := strconv.Atoi(chi.URLParam(r, "id"))
	if err != nil {
		log.Printf("%v", err)
	}
	dbCategories := m.DbClient.GetSubCategoriesByID(categoryId)
	response := Categories{
		Categories: FromDBTypeArray(dbCategories),
	}
	writeJson(w, response)
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
