//go:build integration
// +build integration

// go test -tags=integration

package main

import (
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
	"net/http"
	"testing"
	"time"
)

func init() {
	setIntegrationTestEnv()
	time.Sleep(time.Second)
	go main()
}

func TestSwaggerDocs(t *testing.T) {
	url := "http://localhost:3001/api/swagger/index.html"

	req, err := http.NewRequest("GET", url, nil)
	require.NoError(t, err)

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)

	assert.Equal(t, http.StatusOK, res.StatusCode)
}
