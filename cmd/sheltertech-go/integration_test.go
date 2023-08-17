//go:build integration
// +build integration

package main

import (
	"bytes"
	"encoding/json"
	"io/ioutil"
	"net/http"
	"testing"
	"time"

	"github.com/sheltertechsf/sheltertech-go/internal/categories"
	"github.com/sheltertechsf/sheltertech-go/internal/changerequest"
	"github.com/spf13/viper"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
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
	startServer()

	url := "http://localhost:3002/swagger/index.html"

	req, err := http.NewRequest("GET", url, nil)
	require.NoError(t, err)

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)

	assert.Equal(t, http.StatusOK, res.StatusCode)
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
