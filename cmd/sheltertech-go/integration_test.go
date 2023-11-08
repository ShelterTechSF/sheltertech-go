//go:build integration
// +build integration

package main

import (
	"fmt"
	"bytes"
	"encoding/json"
	"github.com/sheltertechsf/sheltertech-go/internal/categories"
	"github.com/sheltertechsf/sheltertech-go/internal/changerequest"
	"github.com/spf13/viper"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
	"io/ioutil"
	"net/http"
	"testing"
	"time"
)

const baseCategoryUrl string = "http://localhost:3001/api/categories"

func TestGetCategoriesFeatured(t *testing.T) {
	startServer()

	url := baseCategoryUrl + "/featured"

	req, err := http.NewRequest("GET", url, nil)
	require.NoError(t, err)

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	categoriesResponse := new(categories.Categories)

	err = json.Unmarshal(body, categoriesResponse)
	require.NoError(t, err)

	assert.True(t, len(categoriesResponse.Categories) > 0)
}

func TestGetCategories(t *testing.T) {
	startServer()

	req, err := http.NewRequest("GET", baseCategoryUrl, nil)
	require.NoError(t, err)

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	categoriesResponse := new(categories.Categories)

	err = json.Unmarshal(body, categoriesResponse)
	require.NoError(t, err)

	assert.Equal(t, 121, categoriesResponse.Categories[0].Id, "12-step ID 121")
	assert.Equal(t, "12-Step", categoriesResponse.Categories[0].Name, "12-step is the first category ordered by Name")
}

func TestGetCategoryByID(t *testing.T) {
	startServer()

	// Fetch categories.
	res, err := http.Get(baseCategoryUrl)
	require.NoError(t, err)
	defer res.Body.Close()

	body, err := ioutil.ReadAll(res.Body)
	require.NoError(t, err)

	categoriesResponse := new(categories.Categories)
	err = json.Unmarshal(body, categoriesResponse)
	require.NoError(t, err)
	require.NotEmpty(t, categoriesResponse.Categories, "Nothing found. Check database connection and baseUrl")

	// Store the first category Id found.
	categoryId := categoriesResponse.Categories[0].Id

	// Fetch the category by stored Id.
	res, err = http.Get(baseCategoryUrl + "/" + fmt.Sprintf("%d", categoryId))
	require.NoError(t, err)
	defer res.Body.Close()

	body, err = ioutil.ReadAll(res.Body)
	require.NoError(t, err)

	categoryResponse := new(categories.Category)
	err = json.Unmarshal(body, categoryResponse)
	require.NoError(t, err)

	assert.Equal(t, categoryResponse.Id, categoryId, "Category Id is a match")
}

// func TestGetSubCategoriesByID(t *testing.T) {
// 	startServer()

// 	// Fetch categories
// 	res, err := http.Get(baseCategoryUrl)
// 	require.NoError(t, err)
// 	defer res.Body.Close()

// 	body, err := ioutil.ReadAll(res.Body)
// 	require.NoError(t, err)

// 	categoriesResponse := new(categories.Categories)
// 	err = json.Unmarshal(body, categoriesResponse)
// 		require.NoError(t, err)
// 		//require.NotNil(t, categoriesResponse.Categories, "Nothing found. Check database connection and baseUrl")

// 	// Loop categories to find one with a subcategory and store Id
// 	foundSubCategories := false
// 	for i := 0; i < len(categoriesResponse); i++ {
// 		categoryId := categoriesResponse.Categories[i].Id

// 		// Fetch with category Id found
// 		res, err = http.Get(baseCategoryUrl + "/subcategories/" + fmt.Sprintf("%d", categoryId))
// 		defer res.Body.Close()

// 		body, err = ioutil.ReadAll(res.Body)
// 		require.NoError(t, err)

// 		subCategoryResponse := new(categories.Category)
// 		err = json.Unmarshal(body, subCategoryResponse)
// 		require.NoError(t, err)

// 		if len(subCategoryResponse.Name) > 0 {
// 			foundSubCategories = true
// 			require.NotNil(t, subCategoryResponse.Id, "Pulled by Id Cat with Sub")
// 			break
// 		}
// 	}

// 	assert.Equal(t, foundSubCategories, true, "Subcategory API returns a valid result")
// }

func TestPostServicesChangeRequest(t *testing.T) {
	startServer()

	url := "http://localhost:3001/api/services/1/change_request"

	changeRequest := changerequest.ChangeRequest{
		Type:     "ServiceChangeRequest",
		ObjectID: 1,
		Status:   1,
		Action:   1,
	}
	body, err := json.Marshal(changeRequest)
	require.NoError(t, err)
	bytes := bytes.NewBuffer(body)

	req, err := http.NewRequest("POST", url, bytes)
	require.NoError(t, err)

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)

	assert.Equal(t, http.StatusCreated, res.StatusCode)
}

func TestSwaggerDocs(t *testing.T) {
	viper.SetDefault("SERVE_DOCS", "true")
	startServer()

	url := "http://localhost:3002/swagger/index.html"

	req, err := http.NewRequest("GET", url, nil)
	require.NoError(t, err)

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)

	assert.Equal(t, http.StatusOK, res.StatusCode)
	viper.SetDefault("SERVE_DOCS", "false")
}

func TestPrometheusMetrics(t *testing.T) {
	startServer()

	url := "http://localhost:3001/metrics"

	req, err := http.NewRequest("GET", url, nil)
	require.NoError(t, err)

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	assert.True(t, len(body) > 0)
	assert.Equal(t, 200, res.StatusCode)
}

func startServer() {
	viper.SetDefault("DB_USER", "postgres")
	viper.SetDefault("DB_HOST", "localhost")
	viper.SetDefault("DB_PORT", "5432")
	viper.SetDefault("DB_NAME", "askdarcel_development")
	viper.SetDefault("DB_PASS", "")
	go main()
	time.Sleep(time.Second)
}
