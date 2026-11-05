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
	"strconv"
	"strings"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"

	"github.com/sheltertechsf/sheltertech-go/internal/changerequest"
	"github.com/sheltertechsf/sheltertech-go/internal/services"
)

func init() {
	setIntegrationTestEnv()
	go main()
}

const serviceUrl = "http://localhost:3001/api/services"

func TestGetServicesCount(t *testing.T) {
	res, err := http.Get(serviceUrl + "/count")
	require.NoError(t, err)
	defer res.Body.Close()

	assert.Equal(t, http.StatusOK, res.StatusCode)

	body, err := ioutil.ReadAll(res.Body)
	require.NoError(t, err)

	count, err := strconv.Atoi(string(body))
	require.NoError(t, err)

	assert.Greater(t, count, 1, "service count should include seeded services")
}

func TestGetServiceByID(t *testing.T) {
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

func TestGetServiceByIDWithInvalidID(t *testing.T) {
	serviceId := "foo"

	res, _ := http.Get(serviceUrl + "/" + serviceId)
	assert.Equal(t, res.StatusCode, http.StatusBadRequest, "Invalid service ID returns bad request")
}

// TODO: Update when migrating services change request endpoint
func TestPostServicesChangeRequest(t *testing.T) {
	t.Skip()
	url := "http://localhost:3001/api/services/1/change_request"

	changeRequest := changerequest.ChangeRequestPayload{
		Type:             "ServiceChangeRequest",
		ParentResourceID: 1,
		ChangeRequest:    changerequest.ChangeRequest{},
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

func TestCreateServiceRailsPermittedFields(t *testing.T) {
	res, err := http.Post("http://localhost:3001/api/resources/1/services", "application/json", strings.NewReader(`{"services":[{"name":"Parity service","instructions":[{"instruction":"Rails ignores this"}]}]}`))
	require.NoError(t, err)
	defer res.Body.Close()
	require.Equal(t, http.StatusCreated, res.StatusCode)
	var response struct {
		Services []struct {
			Service map[string]interface{} `json:"service"`
		} `json:"services"`
	}
	require.NoError(t, json.NewDecoder(res.Body).Decode(&response))
	require.Len(t, response.Services, 1)
	service := response.Services[0].Service
	id := int(service["id"].(float64))
	manager := integrationDBManager()
	defer manager.DB.Close()
	defer manager.DB.Exec("DELETE FROM public.services WHERE id=$1", id)
	assert.NotContains(t, service, "resource")
	assert.NotContains(t, service, "program")
	assert.Empty(t, service["instructions"])
	var instructions int
	require.NoError(t, manager.DB.QueryRow("SELECT count(*) FROM public.instructions WHERE service_id=$1", id).Scan(&instructions))
	assert.Zero(t, instructions)
}
