package savedsearches

import (
	"encoding/json"
	"fmt"
	"strings"

	"github.com/go-chi/chi/v5"
	"io/ioutil"
	"log"
	"net/http"
	"strconv"

	"github.com/sheltertechsf/sheltertech-go/internal/db"
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

// Get lists saved searches for current user
// (note - I don't have the user auth stuff here)
//
//	@Summary		Get Saved Searches for current User
//	@Description	get saved searches for user
//	@Tags			saved_searches
//	@Accept			json
//	@Produce		json
//	@Success		200	{array}	savedsearches.SavedSearches
//	@Router			/saved_searches [get]
func (m *Manager) Get(w http.ResponseWriter, r *http.Request) {
	userId, err := strconv.Atoi(r.URL.Query().Get("user_id"))
	if err != nil {
		fmt.Println("error:", err)
		writeStatus(w, http.StatusBadRequest)
		return
	}

	dbSavedSearches := m.DbClient.GetSavedSearches(userId)
	dbEligibilities := m.DbClient.GetEligibilitiesByIDs(getEligibilityIdsFromDbSavedSearches(dbSavedSearches))
	dbCategories := m.DbClient.GetCategoriesByIDs(getCategoryIdsFromDbSavedSearches(dbSavedSearches))

	eligibilityIdToName := make(map[int]string)
	for _, dbEligibility := range dbEligibilities {
		eligibilityIdToName[dbEligibility.Id] = dbEligibility.Name.String
	}
	categoryIdToName := make(map[int]string)
	for _, dbCategory := range dbCategories {
		categoryIdToName[dbCategory.Id] = dbCategory.Name
	}

	response := SavedSearches{
		SavedSearches: FromDBTypeArray(dbSavedSearches, eligibilityIdToName, categoryIdToName),
	}
	writeJson(w, response)
}

// Create saved search for current user
// (note - I don't have the user auth stuff here)
//
//	@Summary		Create SavedSearch for current User
//	@Description	new saved search for user
//	@Tags			saved_searches
//	@Accept			json
//	@Produce		json
//	@Success		200	{object}	savedsearches.SavedSearch
//	@Router			/saved_searches [post]
func (m *Manager) Post(w http.ResponseWriter, r *http.Request) {
	defer r.Body.Close()
	body, _ := ioutil.ReadAll(r.Body)

	savedSearch := &SavedSearch{}
	err := json.Unmarshal(body, savedSearch)
	if err != nil {
		writeStatus(w, http.StatusInternalServerError)
	}

	var dbEligibilityIds []int
	if len(savedSearch.Search.Eligibilities) > 0 {
		dbEligibilities := m.DbClient.GetEligibilitiesByNames(savedSearch.Search.Eligibilities)
		if len(dbEligibilities) != len(savedSearch.Search.Eligibilities) {
			var dbEligibilityNames []string
			for _, dbEligibility := range dbEligibilities {
				dbEligibilityNames = append(dbEligibilityNames, dbEligibility.Name.String)
			}
			missingEligibilities := diffStringSlices(savedSearch.Search.Eligibilities, dbEligibilityNames)
			writeStatus(w, http.StatusBadRequest)
			w.Write([]byte(fmt.Sprintf("Invalid eligibilities: %s", strings.Join(missingEligibilities, ", "))))
			return
		}
		for _, dbEligibility := range dbEligibilities {
			dbEligibilityIds = append(dbEligibilityIds, dbEligibility.Id)
		}
	}

	var dbCategoryIds []int
	if len(savedSearch.Search.Categories) > 0 {
		dbCategories := m.DbClient.GetCategoriesByNames(savedSearch.Search.Categories)
		if len(dbCategories) != len(savedSearch.Search.Categories) {
			var dbCategoryNames []string
			for _, dbCategory := range dbCategories {
				dbCategoryNames = append(dbCategoryNames, dbCategory.Name)
			}
			missingCategories := diffStringSlices(savedSearch.Search.Categories, dbCategoryNames)
			writeStatus(w, http.StatusBadRequest)
			w.Write([]byte(fmt.Sprintf("Invalid categories: %s", strings.Join(missingCategories, ", "))))
			return
		}
		for _, dbCategory := range dbCategories {
			dbCategoryIds = append(dbCategoryIds, dbCategory.Id)
		}
	}

	dbSavedSearch := &db.SavedSearch{
		UserId: savedSearch.UserId,
		Name:   savedSearch.Name,
		Search: db.SavedSearchQuery{
			Eligibilities: dbEligibilityIds,
			Categories:    dbCategoryIds,
			Lat:           savedSearch.Search.Lat,
			Lng:           savedSearch.Search.Lng,
			Query:         savedSearch.Search.Query,
		},
	}

	savedSearchId, err := m.DbClient.CreateSavedSearch(dbSavedSearch)
	if err != nil {
		log.Print(err)
		writeStatus(w, http.StatusInternalServerError)
		return
	}

	dbSavedSearch = m.DbClient.GetSavedSearchById(savedSearchId)
	if dbSavedSearch == nil {
		// This really shouldn't happen, since we just created it.
		writeStatus(w, http.StatusInternalServerError)
		return
	}
	eligibilityIds := getEligibilityIdsFromDbSavedSearches([]*db.SavedSearch{dbSavedSearch})
	dbEligibilities := m.DbClient.GetEligibilitiesByIDs(eligibilityIds)
	categoryIds := getCategoryIdsFromDbSavedSearches([]*db.SavedSearch{dbSavedSearch})
	dbCategories := m.DbClient.GetCategoriesByIDs(categoryIds)

	eligibilityIdToName := make(map[int]string)
	for _, dbEligibility := range dbEligibilities {
		eligibilityIdToName[dbEligibility.Id] = dbEligibility.Name.String
	}
	categoryIdToName := make(map[int]string)
	for _, dbCategory := range dbCategories {
		categoryIdToName[dbCategory.Id] = dbCategory.Name
	}

	writeStatus(w, http.StatusCreated)
	writeJson(w, FromDBType(dbSavedSearch, eligibilityIdToName, categoryIdToName))
}

// Get saved searches for current user
// (note - I don't have the user auth stuff here)
//
//	@Summary		Get Saved Search for current User
//	@Description	get saved searches for user
//	@Tags			saved_searches
//	@Accept			json
//	@Produce		json
//	@Success		200	{array}	savedsearches.SavedSearch
//	@Router			/saved_searches [get]
func (m *Manager) GetByID(w http.ResponseWriter, r *http.Request) {
	savedSearchId, err := strconv.Atoi(chi.URLParam(r, "id"))
	if err != nil {
		fmt.Println("error:", err)
		writeStatus(w, http.StatusBadRequest)
		return
	}

	dbSavedSearch := m.DbClient.GetSavedSearchById(savedSearchId)
	eligibilityIds := getEligibilityIdsFromDbSavedSearches([]*db.SavedSearch{dbSavedSearch})
	dbEligibilities := m.DbClient.GetEligibilitiesByIDs(eligibilityIds)
	categoryIds := getCategoryIdsFromDbSavedSearches([]*db.SavedSearch{dbSavedSearch})
	dbCategories := m.DbClient.GetCategoriesByIDs(categoryIds)

	eligibilityIdToName := make(map[int]string)
	for _, dbEligibility := range dbEligibilities {
		eligibilityIdToName[dbEligibility.Id] = dbEligibility.Name.String
	}
	categoryIdToName := make(map[int]string)
	for _, dbCategory := range dbCategories {
		categoryIdToName[dbCategory.Id] = dbCategory.Name
	}

	response := FromDBType(dbSavedSearch, eligibilityIdToName, categoryIdToName)

	writeJson(w, response)
}

// Delete saved search by ID
// not done
// (note - I don't have the user auth stuff here)
//
//	@Summary		Delete saved search by ID
//	@Description	delete a saved search for user
//	@Tags			saved_searches
//	@Accept			json
//	@Produce		json
//	@Success		200	{object}	savedsearches.SavedSearch
//	@Router			/saved_searches/{id} [delete]
func (m *Manager) Delete(w http.ResponseWriter, r *http.Request) {
	id, err := strconv.Atoi(chi.URLParam(r, "id"))
	if err != nil {
		log.Printf("%v", err)
	}
	err = m.DbClient.DeleteSavedSearchById(id)
	if err != nil {
		log.Print(err)
		writeStatus(w, http.StatusInternalServerError)
	}

	writeStatus(w, http.StatusOK)
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

func writeStatus(w http.ResponseWriter, responseStatus int) {
	w.WriteHeader(responseStatus)
}

// Create a flattened, uniquified list of eligibility IDs.
func getEligibilityIdsFromDbSavedSearches(dbSavedSearches []*db.SavedSearch) []int {
	eligibilityIdMap := make(map[int]bool)
	for _, dbSavedSearch := range dbSavedSearches {
		for _, id := range dbSavedSearch.Search.Eligibilities {
			eligibilityIdMap[id] = true
		}
	}
	var eligibilityIds []int
	for id := range eligibilityIdMap {
		eligibilityIds = append(eligibilityIds, id)
	}
	return eligibilityIds
}

// Create a flattened, uniquified list of category IDs.
func getCategoryIdsFromDbSavedSearches(dbSavedSearches []*db.SavedSearch) []int {
	categoryIdMap := make(map[int]bool)
	for _, dbSavedSearch := range dbSavedSearches {
		for _, id := range dbSavedSearch.Search.Categories {
			categoryIdMap[id] = true
		}
	}
	var categoryIds []int
	for id := range categoryIdMap {
		categoryIds = append(categoryIds, id)
	}
	return categoryIds
}

// Return the elements of a that are not in b
func diffStringSlices(a []string, b []string) []string {
	bMap := make(map[string]bool)
	for _, s := range b {
		bMap[s] = true
	}
	var results []string
	seen := make(map[string]bool)
	for _, s := range a {
		_, inB := bMap[s]
		if inB {
			continue
		}
		_, inSeen := seen[s]
		if inSeen {
			continue
		}
		seen[s] = true
		results = append(results, s)
	}
	return results
}
