package main

import (
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"testing"

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
