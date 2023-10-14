//go:build integration
// +build integration

package main

import (
	"bytes"
	"encoding/json"
	"github.com/sheltertechsf/sheltertech-go/internal/categories"
	"github.com/sheltertechsf/sheltertech-go/internal/changerequest"
	"github.com/spf13/viper"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
	"io/ioutil"
	"net/http"
	"strconv"
	"testing"
	"time"
)

func TestGetCategoriesFeatured(t *testing.T) {
	startServer()

	url := "http://localhost:3001/api/categories/featured"

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

	url := "http://localhost:3001/api/categories"

	req, err := http.NewRequest("GET", url, nil)
	require.NoError(t, err)

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	categoriesResponse := []categories.Category{}

	err = json.Unmarshal(body, &categoriesResponse)
	require.NoError(t, err)

	assert.Equal(t, 121, categoriesResponse[0].Id, "12-step ID 121")
	assert.Equal(t, "12-Step", categoriesResponse[0].Name, "12-step is the first category ordered by Name")
}


func TestGetCategoryByID(t *testing.T) {
	// baseUrl to avoid repitition and ease any future changes.
	baseUrl := "http://localhost:3001/api/categories"
	startServer()

	// Fetch a valid category ID.
	res, err := http.Get(baseUrl)
	require.NoError(t, err)
	defer res.Body.Close()

	body, err := ioutil.ReadAll(res.Body)
	require.NoError(t, err)

	categoriesResponse := []categories.Category{}
	err = json.Unmarshal(body, &categoriesResponse)
	require.NoError(t, err)
	require.NotEmpty(t, categoriesResponse, "Did not find any categories. Check database connection and baseUrl")

	// Use the ID found at [0] to query the GetByID api assert.
	categoryId := strconv.Itoa(categoriesResponse[0].Id)
	categoryName := categoriesResponse[0].Name

	res, err = http.Get(baseUrl + "/" + categoryId)
	require.NoError(t, err)
	defer res.Body.Close()

	body, err = ioutil.ReadAll(res.Body)
	require.NoError(t, err)

	categoryResponse := categories.Category{}
	err = json.Unmarshal(body, &categoryResponse)
	require.NoError(t, err)

	assert.Equal(t, categoryId, strconv.Itoa(categoryResponse.Id), "IDs should match")
	assert.Equal(t, categoryName, categoryResponse.Name, "Names should match")
}

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
