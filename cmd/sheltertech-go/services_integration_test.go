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

	"github.com/sheltertechsf/sheltertech-go/internal/changerequest"
	"github.com/sheltertechsf/sheltertech-go/internal/services"
)

func init() {
	setIntegrationTestEnv()
	go main()
}

const serviceUrl = "http://localhost:3001/api/services"

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

func TestPostServicesChangeRequest(t *testing.T) {
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
