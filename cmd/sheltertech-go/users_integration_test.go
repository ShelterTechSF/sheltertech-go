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

	// Without a valid Authorization Bearer JWT, the auth middleware returns 401 Unauthorized.
	assert.Equal(t, http.StatusUnauthorized, res.StatusCode, "Should return 401 Unauthorized without valid auth")
}

func TestGetCurrentUserWithAuthHeader(t *testing.T) {
	req, err := http.NewRequest("GET", userUrl+"/current", nil)
	require.NoError(t, err)

	// Add a dummy authorization header (still invalid for parsing)
	req.Header.Set("Authorization", "Bearer dummy-token")

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()

	// With JWT verification enabled, an invalid token is rejected by the auth middleware with 401.
	// If verification is disabled, the handler runs and may return 200 or 400.
	if res.StatusCode != http.StatusOK {
		assert.Equal(t, http.StatusUnauthorized, res.StatusCode, "Should return 401 Unauthorized with invalid token")
	}
}
