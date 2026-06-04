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
