//go:build integration
// +build integration

// go test -tags=integration

package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"github.com/sheltertechsf/sheltertech-go/internal/categories"
	"github.com/sheltertechsf/sheltertech-go/internal/changerequest"
	"github.com/sheltertechsf/sheltertech-go/internal/common"
	"github.com/sheltertechsf/sheltertech-go/internal/services"
	"github.com/spf13/viper"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
	"io/ioutil"
	"net/http"
	"testing"
	"time"
)

const categoryUrl = "http://localhost:3001/api/categories"
const serviceUrl = "http://localhost:3001/api/services"
const bookmarkUrl = "http://localhost:3001/api/bookmarks"

func TestGetCategoriesFeatured(t *testing.T) {
	startServer()

	url := categoryUrl + "/featured"

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

	req, err := http.NewRequest("GET", categoryUrl, nil)
	require.NoError(t, err)

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	categoriesResponse := &categories.Categories{}

	err = json.Unmarshal(body, categoriesResponse)
	require.NoError(t, err)

	assert.Equal(t, 121, (*categoriesResponse).Categories[0].Id, "12-step ID 121")
	assert.Equal(t, "12-Step", (*categoriesResponse).Categories[0].Name, "12-step is the first category ordered by Name")
}

func TestGetCategoryByID(t *testing.T) {
	startServer()

	res, err := http.Get(categoryUrl)
	require.NoError(t, err)
	defer res.Body.Close()

	body, err := ioutil.ReadAll(res.Body)
	require.NoError(t, err)

	categoriesResponse := new(categories.Categories)
	err = json.Unmarshal(body, categoriesResponse)
	require.NoError(t, err)
	require.NotEmpty(t, categoriesResponse.Categories, "Nothing found. Check database connection and baseUrl")

	categoryId := categoriesResponse.Categories[0].Id

	res, err = http.Get(categoryUrl + "/" + fmt.Sprintf("%d", categoryId))
	require.NoError(t, err)
	defer res.Body.Close()

	body, err = ioutil.ReadAll(res.Body)
	require.NoError(t, err)

	categoryResponse := new(categories.Category)
	err = json.Unmarshal(body, categoryResponse)
	require.NoError(t, err)

	assert.Equal(t, categoryResponse.Id, categoryId, "Category Id is a match")
}

func TestGetServiceByID(t *testing.T) {
	startServer()
	serviceId := 1

	res, err := http.Get(serviceUrl + "/" + fmt.Sprintf("%d", serviceId))
	require.NoError(t, err)
	defer res.Body.Close()

	body, err := ioutil.ReadAll(res.Body)
	require.NoError(t, err)

	serviceResponse := new(services.ServiceResponse)
	err = json.Unmarshal(body, serviceResponse)
	require.NoError(t, err)

	assert.Equal(t, serviceResponse.Service.Id, serviceId, "Service Id is a match")
}

func TestUnauthorized(t *testing.T) {
	t.Skip("skipping until this is supported in dev")
	startServer()

	res, err := http.Get(bookmarkUrl)
	require.NoError(t, err)
	defer res.Body.Close()

	require.Equal(t, http.StatusUnauthorized, res.StatusCode)
}

func TestAuthorized(t *testing.T) {
	t.Skip("skipping until this is supported in dev")
	startServer()

	req, err := http.NewRequest(http.MethodGet, bookmarkUrl, nil)
	require.NoError(t, err)
	req.Header.Set("Authorization", "Bearer k")

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()

	require.Equal(t, http.StatusOK, res.StatusCode)
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

func TestGetBookmarksBadRequest(t *testing.T) {
	startServer()

	res, err := http.Get(bookmarkUrl + "?user_id=a")
	require.NoError(t, err)
	defer res.Body.Close()

	body, err := ioutil.ReadAll(res.Body)
	require.NoError(t, err)

	serviceResponse := new(common.Error)
	err = json.Unmarshal(body, serviceResponse)
	require.NoError(t, err)

	assert.Equal(t, serviceResponse.StatusCode, http.StatusBadRequest, "Response contains a 400")
	assert.NotEmpty(t, serviceResponse.Error, "Response has some error message")
}

func TestGetBookmarkByIDError(t *testing.T) {
	startServer()

	res, err := http.Get(bookmarkUrl + "/0")
	require.NoError(t, err)
	defer res.Body.Close()

	body, err := ioutil.ReadAll(res.Body)
	require.NoError(t, err)

	serviceResponse := new(common.Error)
	err = json.Unmarshal(body, serviceResponse)
	require.NoError(t, err)

	assert.Equal(t, serviceResponse.StatusCode, http.StatusInternalServerError, "Response contains a 400")
	assert.Equal(t, serviceResponse.Error, common.InternalServerErrorMessage)
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
	viper.SetDefault("AUTH0_DOMAIN", "login.sfserviceguide.org")
	go main()
	time.Sleep(time.Second)
}
