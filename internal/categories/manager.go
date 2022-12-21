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
	writeJson(w, fromDBTypeArray(dbCategories))
}

func (m *Manager) GetByID(w http.ResponseWriter, r *http.Request) {
	categoryId, err := strconv.Atoi(chi.URLParam(r, "id"))
	if err != nil {
		log.Printf("%v", err)
	}
	dbCategory := m.DbClient.GetCategoryByID(categoryId)
	writeJson(w, fromDBType(dbCategory))
}

func (m *Manager) GetSubCategoriesByID(w http.ResponseWriter, r *http.Request) {
	categoryId, err := strconv.Atoi(chi.URLParam(r, "id"))
	if err != nil {
		log.Printf("%v", err)
	}
	dbCategories := m.DbClient.GetSubCategoriesByID(categoryId)
	writeJson(w, fromDBTypeArray(dbCategories))
}

func (m *Manager) GetByFeatured(w http.ResponseWriter, _ *http.Request) {
	dbCategories := m.DbClient.GetCategoriesByFeatured()
	response := Categories{
		Categories: fromDBTypeArray(dbCategories),
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

func fromDBType(dbCategory *db.Category) *Category {
	category := &Category{
		Id:       dbCategory.Id,
		Name:     dbCategory.Name,
		TopLevel: dbCategory.TopLevel,
		Featured: dbCategory.Featured,
	}
	return category
}

func fromDBTypeArray(dbCategories []*db.Category) []*Category {
	var categories []*Category
	for _, dbCategory := range dbCategories {
		categories = append(categories, fromDBType(dbCategory))
	}
	return categories
}
