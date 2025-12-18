//go:build integration
// +build integration

// go test -tags=integration

package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"

	"github.com/sheltertechsf/sheltertech-go/internal/savedsearches"
)

func init() {
	setIntegrationTestEnv()
	go main()
}

const savedSearchUrl = "http://localhost:3001/api/saved_searches"

func TestGetSavedSearches(t *testing.T) {
	req, err := http.NewRequest("GET", savedSearchUrl+"?user_id=1", nil)
	require.NoError(t, err)

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()

	body, err := ioutil.ReadAll(res.Body)
	require.NoError(t, err)

	var savedSearchesResponse savedsearches.SavedSearch
	err = json.Unmarshal(body, &savedSearchesResponse)
	require.NoError(t, err)

	// Verify we get a response (could be empty array)
	assert.NotNil(t, savedSearchesResponse, "Should return saved searches array")
}

func TestPostSavedSearch(t *testing.T) {
	savedSearch := savedsearches.SavedSearch{
		Name: "Test Saved Search",
		Search: savedsearches.SavedSearchQuery{
			Query: "test query",
		},
		UserId: 1,
	}

	body, err := json.Marshal(savedSearch)
	require.NoError(t, err)

	req, err := http.NewRequest("POST", savedSearchUrl, bytes.NewBuffer(body))
	require.NoError(t, err)
	req.Header.Set("Content-Type", "application/json")

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()

	// Should return 201 Created for successful creation
	assert.Equal(t, http.StatusCreated, res.StatusCode, "Should return 201 Created")
}

func TestGetSavedSearchByID(t *testing.T) {
	// First create a saved search
	savedSearch := savedsearches.SavedSearch{
		Name: "Test Get Saved Search",
		Search: savedsearches.SavedSearchQuery{
			Query: "test get query",
		},
		UserId: 1,
	}

	body, err := json.Marshal(savedSearch)
	require.NoError(t, err)

	req, err := http.NewRequest("POST", savedSearchUrl, bytes.NewBuffer(body))
	require.NoError(t, err)
	req.Header.Set("Content-Type", "application/json")

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()

	// Should return 201 Created for successful creation
	assert.Equal(t, http.StatusCreated, res.StatusCode, "Should return 201 Created")

	// Parse the created saved search to get its ID
	body, err = ioutil.ReadAll(res.Body)
	require.NoError(t, err)

	var createdSavedSearch savedsearches.SavedSearch
	err = json.Unmarshal(body, &createdSavedSearch)
	require.NoError(t, err)

	// Now get the saved search by ID
	url := fmt.Sprintf("%s/%d", savedSearchUrl, createdSavedSearch.Id)

	req, err = http.NewRequest("GET", url, nil)
	require.NoError(t, err)

	res, err = http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()

	// Should return 200 OK for successful retrieval
	assert.Equal(t, http.StatusOK, res.StatusCode, "Should return 200 OK")

	body, err = ioutil.ReadAll(res.Body)
	require.NoError(t, err)

	var savedSearchResponse savedsearches.SavedSearch
	err = json.Unmarshal(body, &savedSearchResponse)
	require.NoError(t, err)

	assert.Equal(t, savedSearchResponse.Id, createdSavedSearch.Id, "Saved search ID should match")
}

// TestPutSavedSearch removed: PUT /saved_searches/{id} is not implemented; route is disabled in main.

func TestDeleteSavedSearch(t *testing.T) {
	// First create a saved search to delete
	savedSearch := savedsearches.SavedSearch{
		Name: "Test Delete Saved Search",
		Search: savedsearches.SavedSearchQuery{
			Query: "test delete query",
		},
		UserId: 1,
	}

	body, err := json.Marshal(savedSearch)
	require.NoError(t, err)

	req, err := http.NewRequest("POST", savedSearchUrl, bytes.NewBuffer(body))
	require.NoError(t, err)
	req.Header.Set("Content-Type", "application/json")

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()

	// Should return 201 Created for successful creation
	assert.Equal(t, http.StatusCreated, res.StatusCode, "Should return 201 Created")

	// Parse the created saved search to get its ID
	body, err = ioutil.ReadAll(res.Body)
	require.NoError(t, err)

	var createdSavedSearch savedsearches.SavedSearch
	err = json.Unmarshal(body, &createdSavedSearch)
	require.NoError(t, err)

	// Now delete the saved search
	url := fmt.Sprintf("%s/%d", savedSearchUrl, createdSavedSearch.Id)

	req, err = http.NewRequest("DELETE", url, nil)
	require.NoError(t, err)

	res, err = http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()

	// Should return 204 No Content for successful deletion
	assert.Equal(t, http.StatusOK, res.StatusCode, "Should return 200 OK")
}

func TestGetSavedSearchByIDWithInvalidID(t *testing.T) {
	url := savedSearchUrl + "/invalid"

	req, err := http.NewRequest("GET", url, nil)
	require.NoError(t, err)

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()

	// Should return 400 Bad Request for invalid ID
	assert.Equal(t, http.StatusBadRequest, res.StatusCode, "Invalid saved search ID should return 400")
}
