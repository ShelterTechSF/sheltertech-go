//go:build integration
// +build integration

// go test -tags=integration

package main

import (
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
