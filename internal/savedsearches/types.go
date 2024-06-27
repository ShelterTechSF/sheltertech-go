package savedsearches

import "github.com/sheltertechsf/sheltertech-go/internal/db"

type SavedSearchQuery struct {
	Eligibilities []string `json:"eligibilities"`
	Categories    []string `json:"categories"`
	Lat           *float64 `json:"lat"`
	Lng           *float64 `json:"lng"`
	Query         string   `json:"query"`
}

type SavedSearch struct {
	Id     int              `json:"id"`
	UserId int              `json:"user_id"`
	Name   string           `json:"name"`
	Search SavedSearchQuery `json:"search"`
}

type SavedSearches struct {
	SavedSearches []*SavedSearch `json:"saved_searches"`
}

// Convert DB SavedSearch to API SavedSearch
func FromDBType(dbSavedSearch *db.SavedSearch, eligibilityIdToName map[int]string, categoryIdToName map[int]string) *SavedSearch {
	var eligibilityNames []string
	for _, eligibilityId := range dbSavedSearch.Search.Eligibilities {
		name, ok := eligibilityIdToName[eligibilityId]
		if !ok {
			// Return an error?
			return nil
		}
		eligibilityNames = append(eligibilityNames, name)
	}
	var categoryNames []string
	for _, categoryId := range dbSavedSearch.Search.Categories {
		name, ok := categoryIdToName[categoryId]
		if !ok {
			// Return an error?
			return nil
		}
		categoryNames = append(categoryNames, name)
	}

	savedSearch := &SavedSearch{
		Id:     dbSavedSearch.Id,
		Name:   dbSavedSearch.Name,
		UserId: dbSavedSearch.UserId,
		Search: SavedSearchQuery{
			Eligibilities: eligibilityNames,
			Categories:    categoryNames,
			Lat:           dbSavedSearch.Search.Lat,
			Lng:           dbSavedSearch.Search.Lng,
			Query:         dbSavedSearch.Search.Query,
		},
	}
	return savedSearch
}

func FromDBTypeArray(dbSavedSearches []*db.SavedSearch, eligibilityIdToName map[int]string, categoryIdToName map[int]string) []*SavedSearch {
	savedSearches := []*SavedSearch{}
	for _, dbSavedSearch := range dbSavedSearches {
		savedSearches = append(savedSearches, FromDBType(dbSavedSearch, eligibilityIdToName, categoryIdToName))
	}
	return savedSearches
}
