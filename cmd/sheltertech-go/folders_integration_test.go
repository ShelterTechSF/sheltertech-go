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

	"github.com/sheltertechsf/sheltertech-go/internal/folders"
)

func init() {
	setIntegrationTestEnv()
	go main()
}

const folderUrl = "http://localhost:3001/api/folders"

func TestGetFolders(t *testing.T) {
	req, err := http.NewRequest("GET", folderUrl+"?user_id=1", nil)
	require.NoError(t, err)

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()

	body, err := ioutil.ReadAll(res.Body)
	require.NoError(t, err)

	var foldersResponse folders.Folders
	err = json.Unmarshal(body, &foldersResponse)
	require.NoError(t, err)

	// Verify we get a response (could be empty array)
	assert.NotNil(t, foldersResponse.Folders, "Should return folders array")
}

func TestPostFolder(t *testing.T) {
	folder := folders.Folder{
		Name:   "Test Folder",
		UserId: 1,
	}

	body, err := json.Marshal(folder)
	require.NoError(t, err)

	req, err := http.NewRequest("POST", folderUrl, bytes.NewBuffer(body))
	require.NoError(t, err)
	req.Header.Set("Content-Type", "application/json")

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()

	// Should return 201 Created for successful creation
	assert.Equal(t, http.StatusCreated, res.StatusCode, "Should return 201 Created")
}

func TestGetFolderByID(t *testing.T) {
	// First create a folder
	folder := folders.Folder{
		Name:   "Test Get Folder",
		UserId: 1,
	}

	body, err := json.Marshal(folder)
	require.NoError(t, err)

	req, err := http.NewRequest("POST", folderUrl, bytes.NewBuffer(body))
	require.NoError(t, err)
	req.Header.Set("Content-Type", "application/json")

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()

	// Should return 201 Created for successful creation
	assert.Equal(t, http.StatusCreated, res.StatusCode, "Should return 201 Created")

	// Parse the created folder to get its ID
	body, err = ioutil.ReadAll(res.Body)
	require.NoError(t, err)

	var createdFolder folders.Folder
	err = json.Unmarshal(body, &createdFolder)
	require.NoError(t, err)

	// Now get the folder by ID
	url := fmt.Sprintf("%s/%d", folderUrl, createdFolder.Id)

	req, err = http.NewRequest("GET", url, nil)
	require.NoError(t, err)

	res, err = http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()

	// Should return 200 OK for successful retrieval
	assert.Equal(t, http.StatusOK, res.StatusCode, "Should return 200 OK")

	body, err = ioutil.ReadAll(res.Body)
	require.NoError(t, err)

	var folderResponse folders.Folder
	err = json.Unmarshal(body, &folderResponse)
	require.NoError(t, err)

	assert.Equal(t, folderResponse.Id, createdFolder.Id, "Folder ID should match")
}

func TestPutFolder(t *testing.T) {
	// First create a folder to update
	folder := folders.Folder{
		Name:   "Test Update Folder",
		UserId: 1,
	}

	body, err := json.Marshal(folder)
	require.NoError(t, err)

	req, err := http.NewRequest("POST", folderUrl, bytes.NewBuffer(body))
	require.NoError(t, err)
	req.Header.Set("Content-Type", "application/json")

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()

	// Should return 201 Created for successful creation
	assert.Equal(t, http.StatusCreated, res.StatusCode, "Should return 201 Created")

	// Parse the created folder to get its ID
	body, err = ioutil.ReadAll(res.Body)
	require.NoError(t, err)

	var createdFolder folders.Folder
	err = json.Unmarshal(body, &createdFolder)
	require.NoError(t, err)

	// Now update the folder
	url := fmt.Sprintf("%s/%d", folderUrl, createdFolder.Id)

	updatedFolder := folders.Folder{
		Id:     createdFolder.Id,
		Name:   "Updated Test Folder",
		UserId: 1,
	}

	body, err = json.Marshal(updatedFolder)
	require.NoError(t, err)

	req, err = http.NewRequest("PUT", url, bytes.NewBuffer(body))
	require.NoError(t, err)
	req.Header.Set("Content-Type", "application/json")

	res, err = http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()

	// Should return 200 OK for successful update
	assert.Equal(t, http.StatusCreated, res.StatusCode, "Should return 201 Created")

	// Verify the update actually persisted by reading the folder
	req, err = http.NewRequest("GET", url, nil)
	require.NoError(t, err)

	res, err = http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()

	// Should return 200 OK for successful retrieval
	assert.Equal(t, http.StatusOK, res.StatusCode, "Should return 200 OK")

	body, err = ioutil.ReadAll(res.Body)
	require.NoError(t, err)

	var retrievedFolder folders.Folder
	err = json.Unmarshal(body, &retrievedFolder)
	require.NoError(t, err)

	// Verify the updated values
	assert.Equal(t, "Updated Test Folder", retrievedFolder.Name, "Name should be updated")
	assert.Equal(t, createdFolder.Id, retrievedFolder.Id, "ID should remain the same")
}

func TestDeleteFolder(t *testing.T) {
	// First create a folder to delete
	folder := folders.Folder{
		Name:   "Test Delete Folder",
		UserId: 1,
	}

	body, err := json.Marshal(folder)
	require.NoError(t, err)

	req, err := http.NewRequest("POST", folderUrl, bytes.NewBuffer(body))
	require.NoError(t, err)
	req.Header.Set("Content-Type", "application/json")

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()

	// Should return 201 Created for successful creation
	assert.Equal(t, http.StatusCreated, res.StatusCode, "Should return 201 Created")

	// Parse the created folder to get its ID
	body, err = ioutil.ReadAll(res.Body)
	require.NoError(t, err)

	var createdFolder folders.Folder
	err = json.Unmarshal(body, &createdFolder)
	require.NoError(t, err)

	// Now delete the folder
	url := fmt.Sprintf("%s/%d", folderUrl, createdFolder.Id)

	req, err = http.NewRequest("DELETE", url, nil)
	require.NoError(t, err)

	res, err = http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()

	// Should return 204 No Content for successful deletion
	assert.Equal(t, http.StatusNoContent, res.StatusCode, "Should return 204 No Content")
}

func TestGetFolderByIDWithInvalidID(t *testing.T) {
	url := folderUrl + "/invalid"

	req, err := http.NewRequest("GET", url, nil)
	require.NoError(t, err)

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()

	// Should return 400 Bad Request for invalid ID
	assert.Equal(t, http.StatusBadRequest, res.StatusCode, "Invalid folder ID should return 400")
}
