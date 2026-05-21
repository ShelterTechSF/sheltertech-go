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
)

func init() {
	setIntegrationTestEnv()
	go main()
}

const resourceUrl = "http://localhost:3001/api/resources"

func TestGetResourcesCount(t *testing.T) {
	res, err := http.Get(resourceUrl + "/count")
	require.NoError(t, err)
	defer res.Body.Close()

	body, err := ioutil.ReadAll(res.Body)
	require.NoError(t, err)

	byteToInt, err := strconv.Atoi(string(body))
	require.NoError(t, err)

	assert.Greaterf(t, byteToInt, 1, "Count is a match")
}

func TestCreateResourceChangeRequestSingleField(t *testing.T) {
	url := fmt.Sprintf("%s/%d/change_requests", resourceUrl, 1)

	payload := map[string]interface{}{
		"change_request": map[string]interface{}{
			"field_changes": map[string]string{
				"internal_note": "integration test note",
			},
			"action": "edit",
		},
	}
	body, err := json.Marshal(payload)
	require.NoError(t, err)

	req, err := http.NewRequest("POST", url, bytes.NewBuffer(body))
	require.NoError(t, err)

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()

	assert.Equal(t, http.StatusCreated, res.StatusCode)

	var response map[string]interface{}
	err = json.NewDecoder(res.Body).Decode(&response)
	require.NoError(t, err)

	cr := response["resource_change_request"].(map[string]interface{})
	assert.Equal(t, "pending", cr["status"])
	assert.Equal(t, "ResourceChangeRequest", cr["type"])
	assert.Equal(t, float64(1), cr["object_id"])

	fieldChanges := cr["field_changes"].([]interface{})
	assert.Len(t, fieldChanges, 1)
	fc := fieldChanges[0].(map[string]interface{})
	assert.Equal(t, "internal_note", fc["field_name"])
	assert.Equal(t, "integration test note", fc["field_value"])
}

func TestCreateResourceChangeRequestEmptyBody(t *testing.T) {
	url := fmt.Sprintf("%s/%d/change_requests", resourceUrl, 1)

	payload := map[string]interface{}{
		"change_request": map[string]interface{}{
			"field_changes": map[string]string{},
			"action":        "edit",
		},
	}
	body, err := json.Marshal(payload)
	require.NoError(t, err)

	req, err := http.NewRequest("POST", url, bytes.NewBuffer(body))
	require.NoError(t, err)

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()

	assert.Equal(t, http.StatusCreated, res.StatusCode)

	var response map[string]interface{}
	err = json.NewDecoder(res.Body).Decode(&response)
	require.NoError(t, err)

	cr := response["resource_change_request"].(map[string]interface{})
	assert.Equal(t, "pending", cr["status"])

	fieldChanges := cr["field_changes"].([]interface{})
	assert.Len(t, fieldChanges, 0)
}

func TestCreateResourceChangeRequestInvalidID(t *testing.T) {
	url := fmt.Sprintf("%s/abc/change_requests", resourceUrl)

	payload := map[string]interface{}{
		"change_request": map[string]interface{}{
			"field_changes": map[string]string{
				"name": "test",
			},
			"action": "edit",
		},
	}
	body, err := json.Marshal(payload)
	require.NoError(t, err)

	req, err := http.NewRequest("POST", url, bytes.NewBuffer(body))
	require.NoError(t, err)

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()

	assert.Equal(t, http.StatusBadRequest, res.StatusCode)
}

func TestCreateResourceChangeRequestMultipleFields(t *testing.T) {
	url := fmt.Sprintf("%s/%d/change_requests", resourceUrl, 1)

	payload := map[string]interface{}{
		"change_request": map[string]interface{}{
			"field_changes": map[string]string{
				"name":         "Updated Name",
				"email":        "updated@example.com",
				"legal_status": "Non-profit",
			},
			"action": "edit",
		},
	}
	body, err := json.Marshal(payload)
	require.NoError(t, err)

	req, err := http.NewRequest("POST", url, bytes.NewBuffer(body))
	require.NoError(t, err)

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()

	assert.Equal(t, http.StatusCreated, res.StatusCode)

	var response map[string]interface{}
	err = json.NewDecoder(res.Body).Decode(&response)
	require.NoError(t, err)

	cr := response["resource_change_request"].(map[string]interface{})
	fieldChanges := cr["field_changes"].([]interface{})
	assert.Len(t, fieldChanges, 3)

	fieldNames := make([]string, 0, 3)
	for _, fc := range fieldChanges {
		fieldNames = append(fieldNames, fc.(map[string]interface{})["field_name"].(string))
	}
	assert.ElementsMatch(t, []string{"name", "email", "legal_status"}, fieldNames)
}
