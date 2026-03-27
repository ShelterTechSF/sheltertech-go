//go:build integration
// +build integration

// go test -tags=integration

package main

import (
	"net/http"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func init() {
	setIntegrationTestEnv()
	go main()
}

const bookmarkUrl = "http://localhost:3001/api/bookmarks"

func TestGetBookmarks_Unauthorized(t *testing.T) {
	res, err := http.Get(bookmarkUrl)
	require.NoError(t, err)
	defer res.Body.Close()

	assert.Equal(t, http.StatusUnauthorized, res.StatusCode)
}

func TestGetBookmarks_Authorized(t *testing.T) {
	req, err := newAuthRequest("GET", bookmarkUrl, nil)
	require.NoError(t, err)

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()

	assert.Equal(t, http.StatusOK, res.StatusCode)
}

func TestGetBookmarkByID_NonExistent(t *testing.T) {
	req, err := newAuthRequest("GET", bookmarkUrl+"/999999", nil)
	require.NoError(t, err)

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()

	// Returns 500 because the DB layer returns an error for no rows
	// rather than (nil, nil) — pre-existing behaviour in scanBookmark.
	assert.Equal(t, http.StatusInternalServerError, res.StatusCode)
}
