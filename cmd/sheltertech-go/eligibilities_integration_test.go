//go:build integration
// +build integration

// go test -tags=integration

package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"net/url"
	"testing"
	"time"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"

	"github.com/sheltertechsf/sheltertech-go/internal/eligibilities"
)

func init() {
	setIntegrationTestEnv()
	go main()
}

const eligibilityUrl = "http://localhost:3001/api/eligibilities"

//	{
//	    "eligibilities": [
//	        {
//	            "name": "Alzheimers",
//	            "id": 10,
//	            "feature_rank": null
//	        },
//	        {
//	            "name": "Disabled",
//	            "id": 12,
//	            "feature_rank": null
//	        },
//	        {
//	            "name": "Families",
//	            "id": 3,
//	            "feature_rank": 3
//	        },
//	        {
//	            "name": "Foster Youth",
//	            "id": 7,
//	            "feature_rank": null
//	        },
//	        {
//	            "name": "Homeless",
//	            "id": 11,
//	            "feature_rank": null
//	        },
//	        {
//	            "name": "Immigrants",
//	            "id": 6,
//	            "feature_rank": 6
//	        },
//	        {
//	            "name": "LGBTQ",
//	            "id": 9,
//	            "feature_rank": null
//	        },
//	        {
//	            "name": "Low-Income",
//	            "id": 13,
//	            "feature_rank": null
//	        },
//	        {
//	            "name": "Near Homeless",
//	            "id": 8,
//	            "feature_rank": null
//	        },
//	        {
//	            "name": "Re-Entry",
//	            "id": 5,
//	            "feature_rank": 5
//	        },
//	        {
//	            "name": "Seniors (55+ years old)",
//	            "id": 1,
//	            "feature_rank": 1
//	        },
//	        {
//	            "name": "Transition Aged Youth",
//	            "id": 4,
//	            "feature_rank": 4
//	        },
//	        {
//	            "name": "Veterans",
//	            "id": 2,
//	            "feature_rank": 2
//	        }
//	    ]
//	}
func TestGetEligibilities(t *testing.T) {
	// Test getting all eligibilities
	req, err := http.NewRequest("GET", eligibilityUrl, nil)
	require.NoError(t, err)

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()
	body, _ := io.ReadAll(res.Body)

	eligibilitiesResponse := &eligibilities.Eligibilities{}
	err = json.Unmarshal(body, eligibilitiesResponse)
	require.NoError(t, err)

	// Verify we have some eligibilities returned
	assert.True(t, len(eligibilitiesResponse.Eligibilities) > 0)

	// Verify the eligibilities are ordered by name
	for i := range len(eligibilitiesResponse.Eligibilities) - 1 {
		// Handle nil pointers (unlikely but safe)
		name1 := ""
		if eligibilitiesResponse.Eligibilities[i].Name != nil {
			name1 = *eligibilitiesResponse.Eligibilities[i].Name
		}

		name2 := ""
		if eligibilitiesResponse.Eligibilities[i+1].Name != nil {
			name2 = *eligibilitiesResponse.Eligibilities[i+1].Name
		}

		assert.True(t,
			name1 <= name2,
			"Eligibilities should be ordered by name")
	}

	// Subtest with category filter
	t.Run("With category filter", func(t *testing.T) {
		categoryId := 1 // Assuming category ID 1 exists

		filteredUrl := fmt.Sprintf("%s?category_id=%d", eligibilityUrl, categoryId)
		req, err := http.NewRequest("GET", filteredUrl, nil)
		require.NoError(t, err)

		res, err := http.DefaultClient.Do(req)
		require.NoError(t, err)
		defer res.Body.Close()

		assert.Equal(t, 200, res.StatusCode, "Expected 200 status code")

		// Parse the filtered results
		body, _ := io.ReadAll(res.Body)
		filteredResponse := &eligibilities.Eligibilities{}
		err = json.Unmarshal(body, filteredResponse)
		require.NoError(t, err)

		// Just verify the response structure is valid
		assert.NotNil(t, filteredResponse.Eligibilities,
			"Response should contain an eligibilities array (even if empty)")

		// If we have multiple results, verify sorting
		if len(filteredResponse.Eligibilities) > 1 {
			for i := range len(filteredResponse.Eligibilities) - 1 {
				// Handle nil pointers
				name1 := ""
				if filteredResponse.Eligibilities[i].Name != nil {
					name1 = *filteredResponse.Eligibilities[i].Name
				}

				name2 := ""
				if filteredResponse.Eligibilities[i+1].Name != nil {
					name2 = *filteredResponse.Eligibilities[i+1].Name
				}

				assert.True(t,
					name1 <= name2,
					"Filtered eligibilities should be ordered by name")
			}
		}
	})
}

func TestGetEligibilityByID(t *testing.T) {
	// First, get a list of all eligibilities to find a valid ID to test with
	res, err := http.Get(eligibilityUrl)
	require.NoError(t, err)
	defer res.Body.Close()

	body, err := io.ReadAll(res.Body)
	require.NoError(t, err)

	eligibilitiesResponse := new(eligibilities.Eligibilities)
	err = json.Unmarshal(body, eligibilitiesResponse)
	require.NoError(t, err)
	require.NotEmpty(t, eligibilitiesResponse.Eligibilities, "Nothing found. Check database connection and baseUrl")

	// Get a valid ID from the first eligibility in the list
	validID := eligibilitiesResponse.Eligibilities[0].Id

	// Test cases using subtests
	t.Run("Valid ID", func(t *testing.T) {
		// Test with a valid ID
		res, err = http.Get(eligibilityUrl + "/" + fmt.Sprintf("%d", validID))
		require.NoError(t, err)
		defer res.Body.Close()

		body, err = io.ReadAll(res.Body)
		require.NoError(t, err)

		eligibilityResponse := new(eligibilities.EligibilityWrapper)
		err = json.Unmarshal(body, eligibilityResponse)
		require.NoError(t, err)

		assert.Equal(t, validID, eligibilityResponse.Eligibility.Id, "Eligibility Id should match the requested ID")
		assert.NotNil(t, eligibilityResponse.Eligibility.Name, "Eligibility Name should not be nil")
	})

	t.Run("Invalid ID Format", func(t *testing.T) {
		// Test with an invalid ID format (non-numeric)
		res, err = http.Get(eligibilityUrl + "/invalid")
		require.NoError(t, err)
		defer res.Body.Close()

		assert.Equal(t, http.StatusBadRequest, res.StatusCode, "Should return 400 Bad Request for invalid ID format")
	})

	t.Run("Non-existent ID", func(t *testing.T) {
		// Test with a non-existent ID (assuming 9999 doesn't exist)
		nonExistentID := 9999
		res, err = http.Get(eligibilityUrl + "/" + fmt.Sprintf("%d", nonExistentID))
		require.NoError(t, err)
		defer res.Body.Close()

		assert.Equal(t, http.StatusNotFound, res.StatusCode, "Should return 404 Not Found for non-existent ID")
	})
}

func TestGetEligibilitiesFeatured(t *testing.T) {
	url := eligibilityUrl + "/featured"

	req, err := http.NewRequest("GET", url, nil)
	require.NoError(t, err)

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()

	assert.Equal(t, http.StatusOK, res.StatusCode, "Expected 200 OK status code")

	body, err := io.ReadAll(res.Body)
	require.NoError(t, err)

	// Parse the response using the same struct defined in the package
	response := new(eligibilities.Eligibilities)
	err = json.Unmarshal(body, response)
	require.NoError(t, err)

	// Verify we have eligibilities
	assert.True(t, len(response.Eligibilities) > 0, "Should return at least one featured eligibility")

	// Verify all returned eligibilities have a non-nil feature_rank
	for _, eligibility := range response.Eligibilities {
		assert.NotNil(t, eligibility.FeatureRank, "All featured eligibilities should have a feature_rank")
	}

	// Verify they are sorted by feature_rank
	if len(response.Eligibilities) > 1 {
		for i := 0; i < len(response.Eligibilities)-1; i++ {
			// Handle nil pointers (shouldn't happen as we've checked above, but safer)
			rank1 := 0
			if response.Eligibilities[i].FeatureRank != nil {
				rank1 = *response.Eligibilities[i].FeatureRank
			}

			rank2 := 0
			if response.Eligibilities[i+1].FeatureRank != nil {
				rank2 = *response.Eligibilities[i+1].FeatureRank
			}

			assert.True(t, rank1 <= rank2,
				"Featured eligibilities should be ordered by feature_rank")
		}
	}

	// Based on the data you provided, verify that only eligibilities with
	// non-null feature_rank values are returned
	// If the data in the db changes this test may break
	knownFeaturedEligibilityIds := []int{1, 2, 3, 4, 5, 6} // From your example data

	// Ensure all eligibilities in the response have their IDs in the known featured list
	for _, eligibility := range response.Eligibilities {
		found := false
		for _, id := range knownFeaturedEligibilityIds {
			if eligibility.Id == id {
				found = true
				break
			}
		}
		assert.True(t, found, fmt.Sprintf("Eligibility with ID %d should be in the featured list", eligibility.Id))
	}
}

func TestGetSubEligibilities(t *testing.T) {
	baseUrl := eligibilityUrl + "/subeligibilities"

	// Test without parameters - should get a 400 error
	t.Run("No Parameters", func(t *testing.T) {
		req, err := http.NewRequest("GET", baseUrl, nil)
		require.NoError(t, err)

		res, err := http.DefaultClient.Do(req)
		require.NoError(t, err)
		defer res.Body.Close()

		assert.Equal(t, http.StatusBadRequest, res.StatusCode,
			"Should return 400 when neither name nor id is provided")
	})

	// Test with invalid parameter - should get a 400 error
	t.Run("Invalid Parameter", func(t *testing.T) {
		req, err := http.NewRequest("GET", baseUrl+"?invalid=param", nil)
		require.NoError(t, err)

		res, err := http.DefaultClient.Do(req)
		require.NoError(t, err)
		defer res.Body.Close()

		assert.Equal(t, http.StatusBadRequest, res.StatusCode,
			"Should return 400 when an unexpected query parameter is provided")
	})

	// Test with invalid ID format - should get a 422 error
	t.Run("Invalid ID Format", func(t *testing.T) {
		req, err := http.NewRequest("GET", baseUrl+"?id=notanumber", nil)
		require.NoError(t, err)

		res, err := http.DefaultClient.Do(req)
		require.NoError(t, err)
		defer res.Body.Close()

		assert.Equal(t, http.StatusUnprocessableEntity, res.StatusCode,
			"Should return 422 when ID is not a valid number")
	})

	// Test with valid ID
	t.Run("Valid ID", func(t *testing.T) {
		// Use a known parent eligibility ID
		parentID := 1

		queryUrl := fmt.Sprintf("%s?id=%d", baseUrl, parentID)
		req, err := http.NewRequest("GET", queryUrl, nil)
		require.NoError(t, err)

		res, err := http.DefaultClient.Do(req)
		require.NoError(t, err)
		defer res.Body.Close()

		assert.Equal(t, http.StatusOK, res.StatusCode,
			"Should return 200 OK for valid ID parameter")

		body, err := io.ReadAll(res.Body)
		require.NoError(t, err)

		// Parse response
		subEligibilitiesResponse := new(eligibilities.Eligibilities)
		err = json.Unmarshal(body, subEligibilitiesResponse)
		require.NoError(t, err)

		// Verify response structure is valid
		assert.NotNil(t, subEligibilitiesResponse.Eligibilities,
			"Response should contain an eligibilities array (even if empty)")
	})

	// Test with valid name
	t.Run("Valid Name", func(t *testing.T) {
		// Use a known parent eligibility name
		parentName := "Seniors (55+ years old)"

		// URL encode the name to handle spaces and special characters
		encodedName := url.QueryEscape(parentName)

		queryUrl := fmt.Sprintf("%s?name=%s", baseUrl, encodedName)
		req, err := http.NewRequest("GET", queryUrl, nil)
		require.NoError(t, err)

		res, err := http.DefaultClient.Do(req)
		require.NoError(t, err)
		defer res.Body.Close()

		assert.Equal(t, http.StatusOK, res.StatusCode,
			"Should return 200 OK for valid name parameter")

		body, err := io.ReadAll(res.Body)
		require.NoError(t, err)

		// Parse response
		subEligibilitiesResponse := new(eligibilities.Eligibilities)
		err = json.Unmarshal(body, subEligibilitiesResponse)
		require.NoError(t, err)

		// Verify response structure is valid
		assert.NotNil(t, subEligibilitiesResponse.Eligibilities,
			"Response should contain an eligibilities array (even if empty)")
	})
}

func TestUpdateEligibilityById(t *testing.T) {
	// First, get a valid eligibility ID to test with
	res, err := http.Get(eligibilityUrl)
	require.NoError(t, err)
	defer res.Body.Close()

	body, err := io.ReadAll(res.Body)
	require.NoError(t, err)

	eligibilitiesResponse := new(eligibilities.Eligibilities)
	err = json.Unmarshal(body, eligibilitiesResponse)
	require.NoError(t, err)
	require.NotEmpty(t, eligibilitiesResponse.Eligibilities, "No eligibilities found for testing")

	// Get a valid ID from the response
	validID := eligibilitiesResponse.Eligibilities[0].Id

	// Test with invalid ID format
	t.Run("Invalid ID Format", func(t *testing.T) {
		updateUrl := eligibilityUrl + "/invalid"

		// Create update request
		updateData := map[string]interface{}{
			"name":         "Updated Name",
			"feature_rank": 10,
		}

		jsonData, err := json.Marshal(updateData)
		require.NoError(t, err)

		req, err := http.NewRequest("PUT", updateUrl, bytes.NewBuffer(jsonData))
		require.NoError(t, err)
		req.Header.Set("Content-Type", "application/json")

		res, err := http.DefaultClient.Do(req)
		require.NoError(t, err)
		defer res.Body.Close()

		assert.Equal(t, http.StatusBadRequest, res.StatusCode,
			"Should return 400 Bad Request for invalid ID format")
	})

	// Test with invalid JSON body
	t.Run("Invalid Request Body", func(t *testing.T) {
		updateUrl := fmt.Sprintf("%s/%d", eligibilityUrl, validID)

		// Create invalid JSON
		invalidJSON := []byte("{invalid json")

		req, err := http.NewRequest("PUT", updateUrl, bytes.NewBuffer(invalidJSON))
		require.NoError(t, err)
		req.Header.Set("Content-Type", "application/json")

		res, err := http.DefaultClient.Do(req)
		require.NoError(t, err)
		defer res.Body.Close()

		assert.Equal(t, http.StatusBadRequest, res.StatusCode,
			"Should return 400 Bad Request for invalid JSON")
	})

	// Test with non-existent ID
	t.Run("Non-existent ID", func(t *testing.T) {
		// Using a very high ID that likely doesn't exist
		nonExistentID := 9999
		updateUrl := fmt.Sprintf("%s/%d", eligibilityUrl, nonExistentID)

		// Create update request
		updateData := map[string]interface{}{
			"name": "Updated Name",
		}

		jsonData, err := json.Marshal(updateData)
		require.NoError(t, err)

		req, err := http.NewRequest("PUT", updateUrl, bytes.NewBuffer(jsonData))
		require.NoError(t, err)
		req.Header.Set("Content-Type", "application/json")

		res, err := http.DefaultClient.Do(req)
		require.NoError(t, err)
		defer res.Body.Close()

		assert.Equal(t, http.StatusNotFound, res.StatusCode,
			"Should return 404 Not Found for non-existent ID")
	})

	// Test successful update - update name
	t.Run("Update Name", func(t *testing.T) {
		updateUrl := fmt.Sprintf("%s/%d", eligibilityUrl, validID)

		// Get the original eligibility first to check the change
		req, err := http.NewRequest("GET", updateUrl, nil)
		require.NoError(t, err)

		res, err := http.DefaultClient.Do(req)
		require.NoError(t, err)
		defer res.Body.Close()

		body, err := io.ReadAll(res.Body)
		require.NoError(t, err)

		originalEligibility := new(eligibilities.Eligibility)
		err = json.Unmarshal(body, originalEligibility)
		require.NoError(t, err)

		// Create a unique name for testing (to avoid duplicate name error)
		newName := fmt.Sprintf("Test Eligibility %d", time.Now().UnixNano())

		// Create update request for name only
		updateData := map[string]interface{}{
			"name": newName,
		}

		jsonData, err := json.Marshal(updateData)
		require.NoError(t, err)

		req, err = http.NewRequest("PUT", updateUrl, bytes.NewBuffer(jsonData))
		require.NoError(t, err)
		req.Header.Set("Content-Type", "application/json")

		res, err = http.DefaultClient.Do(req)
		require.NoError(t, err)
		defer res.Body.Close()

		assert.Equal(t, http.StatusOK, res.StatusCode, "Should return 200 OK for successful update")

		body, err = io.ReadAll(res.Body)
		require.NoError(t, err)

		updatedEligibility := new(eligibilities.Eligibility)
		err = json.Unmarshal(body, updatedEligibility)
		require.NoError(t, err)

		assert.Equal(t, validID, updatedEligibility.Eligibility.Id, "ID should remain the same")
		assert.Equal(t, newName, *updatedEligibility.Eligibility.Name, "Name should be updated")

		// Revert back to original (clean up)
		if originalEligibility.Name != nil {
			updateData = map[string]interface{}{
				"name": *originalEligibility.Name,
			}

			jsonData, err = json.Marshal(updateData)
			require.NoError(t, err)

			req, err = http.NewRequest("PUT", updateUrl, bytes.NewBuffer(jsonData))
			require.NoError(t, err)
			req.Header.Set("Content-Type", "application/json")

			res, err = http.DefaultClient.Do(req)
			require.NoError(t, err)
			res.Body.Close()
		}
	})

	// Test successful update - update feature_rank
	t.Run("Update Feature Rank", func(t *testing.T) {
		updateUrl := fmt.Sprintf("%s/%d", eligibilityUrl, validID)

		// Get the original eligibility first to check the change
		req, err := http.NewRequest("GET", updateUrl, nil)
		require.NoError(t, err)

		res, err := http.DefaultClient.Do(req)
		require.NoError(t, err)
		defer res.Body.Close()

		body, err := io.ReadAll(res.Body)
		require.NoError(t, err)

		originalEligibility := new(eligibilities.Eligibility)
		err = json.Unmarshal(body, originalEligibility)
		require.NoError(t, err)

		// Create a new feature rank (different from the original)
		var newRank int
		if originalEligibility.FeatureRank == nil {
			newRank = 100
		} else {
			newRank = *originalEligibility.FeatureRank + 1
		}

		// Create update request for feature_rank only
		updateData := map[string]interface{}{
			"feature_rank": newRank,
		}

		jsonData, err := json.Marshal(updateData)
		require.NoError(t, err)

		req, err = http.NewRequest("PUT", updateUrl, bytes.NewBuffer(jsonData))
		require.NoError(t, err)
		req.Header.Set("Content-Type", "application/json")

		res, err = http.DefaultClient.Do(req)
		require.NoError(t, err)
		defer res.Body.Close()

		assert.Equal(t, http.StatusOK, res.StatusCode, "Should return 200 OK for successful update")

		body, err = io.ReadAll(res.Body)
		require.NoError(t, err)

		updatedEligibility := new(eligibilities.Eligibility)
		err = json.Unmarshal(body, updatedEligibility)
		require.NoError(t, err)

		assert.Equal(t, validID, updatedEligibility.Id, "ID should remain the same")
		assert.NotNil(t, updatedEligibility.FeatureRank, "Feature rank should not be nil")
		assert.Equal(t, newRank, *updatedEligibility.FeatureRank, "Feature rank should be updated")

		// Revert back to original (clean up)
		updateData = map[string]interface{}{
			"feature_rank": originalEligibility.FeatureRank,
		}

		jsonData, err = json.Marshal(updateData)
		require.NoError(t, err)

		req, err = http.NewRequest("PUT", updateUrl, bytes.NewBuffer(jsonData))
		require.NoError(t, err)
		req.Header.Set("Content-Type", "application/json")

		res, err = http.DefaultClient.Do(req)
		require.NoError(t, err)
		res.Body.Close()
	})

	// Duplicate name test is difficult in integration testing without knowing all existing names
	// Could be added if needed, but requires more knowledge about the test data
}
