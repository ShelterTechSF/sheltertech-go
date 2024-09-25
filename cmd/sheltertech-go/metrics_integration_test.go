//go:build integration
// +build integration

// go test -tags=integration

package main

import (
	"io/ioutil"
	"net/http"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func init() {
	setIntegrationTestEnv()
	go main()
}

func TestPrometheusMetrics(t *testing.T) {
	url := "http://localhost:3001/metrics"

	req, err := http.NewRequest("GET", url, nil)
	require.NoError(t, err)

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()
	body, _ := ioutil.ReadAll(res.Body)

	assert.True(t, len(body) > 0)
	assert.Equal(t, 200, res.StatusCode)
}
