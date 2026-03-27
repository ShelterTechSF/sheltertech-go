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

	"github.com/sheltertechsf/sheltertech-go/internal/changerequest"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
	"github.com/spf13/viper"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func init() {
	setIntegrationTestEnv()
	go main()
}

const phonesUrl = "http://localhost:3001/api/phones"

func integrationDBManager() *db.Manager {
	return db.New(
		viper.GetString("DB_HOST"),
		viper.GetString("DB_PORT"),
		viper.GetString("DB_NAME"),
		viper.GetString("DB_USER"),
		viper.GetString("DB_PASS"),
	)
}

func createTestPhone(t *testing.T) int {
	dbManager := integrationDBManager()
	query := "INSERT INTO public.phones (number, service_type, created_at, updated_at, resource_id) VALUES ('555-123-4567', 'Test', NOW(), NOW(), 1) RETURNING id"
	var phoneID int
	err := dbManager.DB.QueryRow(query).Scan(&phoneID)
	if err != nil {
		t.Fatalf("Failed to create test phone: %v", err)
	}
	return phoneID
}

func deleteTestPhone(t *testing.T, phoneID int) {
	dbManager := integrationDBManager()
	_, err := dbManager.DB.Exec("DELETE FROM public.phones WHERE id = $1", phoneID)
	if err != nil {
		t.Fatalf("Failed to delete test phone: %v", err)
	}
}

func TestDeletePhoneEndpoint(t *testing.T) {
	// Create a test phone and get its ID
	phoneID := createTestPhone(t)
	if phoneID == 0 {
		t.Fatal("Failed to create a test phone or retrieve its ID")
	}
	defer deleteTestPhone(t, phoneID) // Ensure cleanup happens even if the test fails later
	// Construct the DELETE request
	url := fmt.Sprintf("%s/%d", phonesUrl, phoneID)
	req, err := newAuthRequest("DELETE", url, nil)
	if err != nil {
		t.Fatalf("Failed to create DELETE request: %v", err)
	}
	// Perform the DELETE request
	resp, err := http.DefaultClient.Do(req)
	if err != nil {
		t.Fatalf("Failed to perform DELETE request: %v", err)
	}
	defer resp.Body.Close()
	// Check the response status code
	assert.Equal(t, http.StatusNoContent, resp.StatusCode, "Expected status code 204")
	// Attempt to delete the same phone again, expecting a 404
	req, err = newAuthRequest("DELETE", url, nil)
	if err != nil {
		t.Fatalf("Failed to create second DELETE request: %v", err)
	}
	resp, err = http.DefaultClient.Do(req)
	if err != nil {
		t.Fatalf("Failed to perform second DELETE request: %v", err)
	}
	defer resp.Body.Close()
	// Check the response status code for the second DELETE
	assert.Equal(t, http.StatusNotFound, resp.StatusCode, "Expected status code 404 for already deleted phone")
	// Optionally, check the response body for the error message
	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		t.Fatalf("Failed to read response body: %v", err)
	}
	expectedErrorMessage := fmt.Sprintf("404: Phone not found for ID: %d", phoneID) // Assuming this is the exact error msg
	assert.Contains(t, string(body), expectedErrorMessage, "Response body should contain the 'not found' error message")
}

func TestCreatePhoneEndpoint(t *testing.T) {
	url := "http://localhost:3001/api/change_requests"

	changeRequest := changerequest.ChangeRequestPayload{
		Type:             "phone",
		ParentResourceID: 1,
		ChangeRequest: changerequest.ChangeRequest{
			Action:       "insert",
			FieldChanges: []byte(`{"number": "415-321-1234", "service_type": "Business"}`),
		},
	}
	body, err := json.Marshal(changeRequest)
	require.NoError(t, err)
	bytes := bytes.NewBuffer(body)

	req, err := newAuthRequest("POST", url, bytes)
	require.NoError(t, err)

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)

	assert.Equal(t, http.StatusOK, res.StatusCode)
}

func TestUpdatePhoneEndpoint(t *testing.T) {
	phoneId := createTestPhone(t)
	url := fmt.Sprintf("http://localhost:3001/api/phones/%v/change_requests", phoneId)

	changeRequest := changerequest.ChangeRequestPayload{
		ChangeRequest: changerequest.ChangeRequest{
			Action:       "update",
			FieldChanges: []byte(`{"number": "415-514-4321"}`),
		},
	}
	body, err := json.Marshal(changeRequest)
	require.NoError(t, err)
	bytes := bytes.NewBuffer(body)

	req, err := newAuthRequest("POST", url, bytes)
	require.NoError(t, err)

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)

	assert.Equal(t, http.StatusOK, res.StatusCode)
}
