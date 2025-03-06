//go:build integration
// +build integration

// go test -tags=integration
package main

import (
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
	"io/ioutil"
	"net/http"
	"testing"
)

func init() {
	setIntegrationTestEnv()
	go main()
}

const contentCurationDatasetUrl = "http://localhost:3001/api/datathon/content_curation_dataset"
const datathonDatasetUrl = "http://localhost:3001/api/datathon/datathon_dataset"

func TestGetContentCurationDataset(t *testing.T) {
	req, err := http.NewRequest("GET", contentCurationDatasetUrl, nil)
	require.NoError(t, err)

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()

	_, err = ioutil.ReadAll(res.Body)
	require.NoError(t, err)

	assert.Equal(t, http.StatusOK, res.StatusCode)
}

func TestGetDatathonDataset(t *testing.T) {
	req, err := http.NewRequest("GET", datathonDatasetUrl, nil)
	require.NoError(t, err)

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()

	_, err = ioutil.ReadAll(res.Body)
	require.NoError(t, err)

	assert.Equal(t, http.StatusOK, res.StatusCode)
}
