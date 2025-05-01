package eligibilities

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"strconv"
	"strings"

	"github.com/go-chi/chi/v5"
	"github.com/sheltertechsf/sheltertech-go/internal/common"
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

// Get all eligibilities
//
//	@Summary        Get Eligibilities
//	@Description    Get all eligibilities sorted by name in ascending order, with optional filtering by category.
//	@Tags           eligibilities
//	@Produce        json
//	@Param          categoryId query integer false "Filter eligibilities by category ID"
//	@Success        200 {array} eligibilities.Eligibility
//	@Router         /eligibilities [get]
func (m *Manager) Get(w http.ResponseWriter, r *http.Request) {
	// Check for unexpected query parameters
	// Add valid params here
	validParams := map[string]bool{"category_id": true}

	for param := range r.URL.Query() {
		if !validParams[param] {
			errMsg := fmt.Sprintf("Unexpected query parameter: %s", param)
			log.Printf("%v", errMsg)
			common.WriteErrorJson(w, http.StatusBadRequest, errMsg)
			return
		}
	}

	var eligibilities []*db.Eligibility
	var categoryId *int
	if categoryIdStr := r.URL.Query().Get("category_id"); categoryIdStr != "" {
		categoryIdInt, err := strconv.Atoi(categoryIdStr)

		if err != nil {
			log.Printf("%v", err)
			common.WriteErrorJson(w, http.StatusUnprocessableEntity, "Enter a valid Category ID")
			return
		}
		categoryId = &categoryIdInt
		eligibilities = m.DbClient.GetEligibilitiesByCategoryId(categoryId)

	} else {
		eligibilities = m.DbClient.GetEligibilities()

	}
	response := Eligibilities{
		Eligibilities: FromEligibilitiesDBTypeArray(eligibilities),
	}
	writeJson(w, response)
}

// Get eligibility by ID
//
//	@Summary        Get Eligibility
//	@Description    Get a specific eligibility by its ID.
//	@Tags           eligibilities
//	@Produce        json
//	@Param          id path integer true "Eligibility ID"
//	@Success        200 {object} eligibilities.Eligibility
//	@Failure        400 {object} error "Invalid eligibility ID format"
//	@Failure        404 {object} error "Eligibility not found"
//	@Failure        500 {object} error "Internal server error"
//	@Router         /eligibilities/{id} [get]
func (m *Manager) GetEligibilityById(w http.ResponseWriter, r *http.Request) {
	// Get the ID from the URL parameters
	idStr := chi.URLParam(r, "id")
	id, err := strconv.Atoi(idStr)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusBadRequest, "Invalid eligibility ID format")
		return
	}

	// Call the DB client function with a slice containing just the one ID
	eligibilities := m.DbClient.GetEligibilitiesByIDs([]int{id})

	// Check if we got any results
	if len(eligibilities) == 0 {
		common.WriteErrorJson(w, http.StatusNotFound, "Eligibility not found")
		return
	}

	// Convert from DB type and return the first (and only) result
	response := FromEligibilityDBType(eligibilities[0])

	writeJson(w, response)
}

// Update eligibility
//
//	@Summary        Update Eligibility
//	@Description    Update an existing eligibility's name or feature rank.
//	@Tags           eligibilities
//	@Accept         json
//	@Produce        json
//	@Param          id path integer true "Eligibility ID"
//	@Param          body body object false "Eligibility update parameters"
//	@Param          name body string false "New name for this eligibility"
//	@Param          feature_rank body integer false "New feature rank for this eligibility (can be null)"
//	@Success        200 {object} eligibilities.Eligibility
//	@Failure        400 {object} error "Invalid request or duplicate name"
//	@Failure        404 {object} error "Eligibility not found"
//	@Failure        500 {object} error "Internal server error"
//	@Router         /eligibilities/{id} [put]
func (m *Manager) UpdateEligibilityById(w http.ResponseWriter, r *http.Request) {
	// Get the ID from the URL parameters
	idStr := chi.URLParam(r, "id")
	id, err := strconv.Atoi(idStr)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusBadRequest, "Invalid eligibility ID format")
		return
	}

	// Parse request body
	var updateReq EligibilityUpdateRequest
	err = json.NewDecoder(r.Body).Decode(&updateReq)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusBadRequest, "Invalid request body")
		return
	}

	// Update the eligibility
	updatedEligibility, err := m.DbClient.UpdateEligibility(id, updateReq.Name, updateReq.FeatureRank)
	if err != nil {
		log.Printf("%v", err)

		// Handle different types of errors
		if strings.Contains(err.Error(), "not found") {
			common.WriteErrorJson(w, http.StatusNotFound, fmt.Sprintf("Eligibility with ID %d not found", id))
			return
		} else if strings.Contains(err.Error(), "duplicate key") {
			common.WriteErrorJson(w, http.StatusBadRequest, "An eligibility with this name already exists")
			return
		} else if strings.Contains(err.Error(), "violates") {
			common.WriteErrorJson(w, http.StatusBadRequest, "Invalid data: constraint violation")
			return
		} else {
			common.WriteErrorJson(w, http.StatusInternalServerError, common.InternalServerErrorMessage)
			return
		}
	}

	// Return the updated eligibility
	response := FromEligibilityDBType(updatedEligibility)
	writeJson(w, response)
}

// Get featured eligibilities
//
//	@Summary        Get Featured Eligibilities
//	@Description    Returns featured eligibilities sorted by feature_rank with service and resource counts.
//	@Tags           eligibilities
//	@Produce        json
//	@Success        200 {object} object "Object containing array of eligibilities with counts"
//	@Success        200 {array} eligibilities.Eligibility "Eligibilities array with additional service_count and resource_count fields"
//	@Router         /eligibilities/featured [get]

func (m *Manager) GetFeaturedEligibilities(w http.ResponseWriter, r *http.Request) {
	// Get featured eligibilities (those with non-null feature_rank)
	// Already sorted by feature_rank in ascending order from the query
	eligibilities := m.DbClient.GetFeaturedEligibilities()

	// If no featured eligibilities were found, return an empty array
	if eligibilities == nil {
		eligibilities = []*db.Eligibility{}
	}

	// Create response object
	response := Eligibilities{
		Eligibilities: FromEligibilitiesDBTypeArray(eligibilities),
	}

	// Write response as JSON
	writeJson(w, response)
}

// Get subeligibilities
//
//	@Summary        Get Subeligibilities
//	@Description    Returns child eligibilities for a parent eligibility, identified either by ID or name.
//	@Tags           eligibilities
//	@Produce        json
//	@Param          id query integer false "Parent eligibility ID"
//	@Param          name query string false "Parent eligibility name"
//	@Success        200 {array} eligibilities.Eligibility
//	@Failure        400 {object} error "Bad request - unexpected query parameter or missing required parameters"
//	@Failure        422 {object} error "Unprocessable Entity - invalid parent eligibility ID format"
//	@Router         /eligibilities/subeligibilities [get]
func (m *Manager) GetSubEligibilities(w http.ResponseWriter, r *http.Request) {
	// Check for unexpected query parameters
	validParams := map[string]bool{"id": true, "name": true}

	for param := range r.URL.Query() {
		if !validParams[param] {
			errMsg := fmt.Sprintf("Unexpected query parameter: %s", param)
			log.Printf("%v", errMsg)
			common.WriteErrorJson(w, http.StatusBadRequest, errMsg)
			return
		}
	}

	var eligibilities []*db.Eligibility

	// Check if a name parameter was provided
	if parentName := r.URL.Query().Get("name"); parentName != "" {
		eligibilities = m.DbClient.GetSubEligibilitiesByParentName(parentName)
	} else if parentIDStr := r.URL.Query().Get("id"); parentIDStr != "" {
		// Parse the parent ID
		parentID, err := strconv.Atoi(parentIDStr)
		if err != nil {
			log.Printf("%v", err)
			common.WriteErrorJson(w, http.StatusUnprocessableEntity, "Enter a valid parent eligibility ID")
			return
		}
		eligibilities = m.DbClient.GetSubEligibilitiesByParentID(parentID)
	} else {
		// Neither name nor ID was provided
		common.WriteErrorJson(w, http.StatusBadRequest, "Either name or id parameter is required")
		return
	}

	// If no eligibilities were found, return an empty array
	if eligibilities == nil {
		eligibilities = []*db.Eligibility{}
	}

	// Create response object with the subeligibilities
	response := Eligibilities{
		Eligibilities: FromEligibilitiesDBTypeArray(eligibilities),
	}

	// Write response as JSON
	writeJson(w, response)
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
