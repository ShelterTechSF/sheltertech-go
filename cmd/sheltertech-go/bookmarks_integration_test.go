//go:build integration
// +build integration

// go test -tags=integration

package main

import (
	"encoding/json"
	"io/ioutil"
	"net/http"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"

	"github.com/sheltertechsf/sheltertech-go/internal/common"
)

func init() {
	setIntegrationTestEnv()
	go main()
}

const bookmarkUrl = "http://localhost:3001/api/bookmarks"

func TestGetBookmarksBadRequest(t *testing.T) {
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

func TestUnauthorized(t *testing.T) {
	t.Skip("skipping until this is supported in dev")

	res, err := http.Get(bookmarkUrl)
	require.NoError(t, err)
	defer res.Body.Close()

	require.Equal(t, http.StatusUnauthorized, res.StatusCode)
}

func TestAuthorized(t *testing.T) {
	t.Skip("skipping until this is supported in dev")

	req, err := http.NewRequest(http.MethodGet, bookmarkUrl, nil)
	require.NoError(t, err)
	req.Header.Set("Authorization", "Bearer k")

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()

	require.Equal(t, http.StatusOK, res.StatusCode)
}
