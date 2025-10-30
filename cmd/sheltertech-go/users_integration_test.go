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

const userUrl = "http://localhost:3001/api/users"

func TestGetCurrentUser(t *testing.T) {
	req, err := http.NewRequest("GET", userUrl+"/current", nil)
	require.NoError(t, err)

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()

	// Without a valid Authorization Bearer JWT mapped to a DB user,
	// endpoint returns 400 Bad Request (see users.GetCurrent).
	assert.Equal(t, http.StatusBadRequest, res.StatusCode, "Should return 400 Bad Request without valid auth")
}

func TestGetCurrentUserWithAuthHeader(t *testing.T) {
	req, err := http.NewRequest("GET", userUrl+"/current", nil)
	require.NoError(t, err)

	// Add a dummy authorization header (still invalid for parsing)
	req.Header.Set("Authorization", "Bearer dummy-token")

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()

	// Still expect 400 since token is invalid and no matching user exists in seed data
	assert.Equal(t, http.StatusBadRequest, res.StatusCode, "Should return 400 Bad Request with invalid token")
}
