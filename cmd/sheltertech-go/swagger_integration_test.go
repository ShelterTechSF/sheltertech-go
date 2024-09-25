//go:build integration
// +build integration

// go test -tags=integration

package main

import (
	"github.com/spf13/viper"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
	"net/http"
	"testing"
	"time"
)

func init() {
	setIntegrationTestEnv()
	viper.SetDefault("SERVE_DOCS", "true")
	time.Sleep(time.Second)
	go main()
}

func TestSwaggerDocs(t *testing.T) {
	url := "http://localhost:3002/swagger/index.html"

	req, err := http.NewRequest("GET", url, nil)
	require.NoError(t, err)

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)

	assert.Equal(t, http.StatusOK, res.StatusCode)
}
