//go:build integration
// +build integration

// go test -tags=integration

package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"

	"github.com/sheltertechsf/sheltertech-go/internal/categories"
)

func init() {
	setIntegrationTestEnv()
	go main()
}

const categoryUrl = "http://localhost:3001/api/categories"

func TestGetCategoriesFeatured(t *testing.T) {
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
