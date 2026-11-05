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

	newsarticles "github.com/sheltertechsf/sheltertech-go/internal/news_articles"
)

func init() {
	setIntegrationTestEnv()
	go main()
}

const newsArticleUrl = "http://localhost:3001/api/news_articles"

// Helper function to create string pointers
func stringPtr(s string) *string {
	return &s
}

func TestGetNewsArticles(t *testing.T) {
	req, err := http.NewRequest("GET", newsArticleUrl, nil)
	require.NoError(t, err)

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()

	body, err := ioutil.ReadAll(res.Body)
	require.NoError(t, err)

	var newsArticlesResponse newsarticles.NewsArticles
	err = json.Unmarshal(body, &newsArticlesResponse)
	require.NoError(t, err)

	// Verify we get a response (could be empty array)
	assert.NotNil(t, newsArticlesResponse.NewsArticles, "Should return news articles array")
}

func TestPostNewsArticle(t *testing.T) {
	newsArticle := map[string]string{
		"headline": "Test News Article",
		"body":     "Test content for the news article",
	}

	body, err := json.Marshal(newsArticle)
	require.NoError(t, err)

	req, err := http.NewRequest("POST", newsArticleUrl, bytes.NewBuffer(body))
	require.NoError(t, err)
	req.Header.Set("Content-Type", "application/json")

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()

	// Should return 201 Created for successful creation
	assert.Equal(t, http.StatusCreated, res.StatusCode, "Should return 201 Created")
}

func TestPutNewsArticle(t *testing.T) {
	// First create a news article to update
	newsArticle := map[string]string{
		"headline": "Test Update News Article",
		"body":     "Test content for the news article to update",
	}

	body, err := json.Marshal(newsArticle)
	require.NoError(t, err)

	req, err := http.NewRequest("POST", newsArticleUrl, bytes.NewBuffer(body))
	require.NoError(t, err)
	req.Header.Set("Content-Type", "application/json")

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()

	// Should return 201 Created for successful creation
	assert.Equal(t, http.StatusCreated, res.StatusCode, "Should return 201 Created")

	// Parse the created news article to get its ID
	body, err = ioutil.ReadAll(res.Body)
	require.NoError(t, err)

	var created newsarticles.NewsArticleResponse
	err = json.Unmarshal(body, &created)
	require.NoError(t, err)

	// Now update the news article
	url := fmt.Sprintf("%s/%d", newsArticleUrl, created.NewsArticle.Id)

	updatedNewsArticle := map[string]string{
		"headline": "Updated Test News Article",
	}

	body, err = json.Marshal(updatedNewsArticle)
	require.NoError(t, err)

	req, err = http.NewRequest("PUT", url, bytes.NewBuffer(body))
	require.NoError(t, err)
	req.Header.Set("Content-Type", "application/json")

	res, err = http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()

	// Should return 200 OK for successful update
	assert.Equal(t, http.StatusOK, res.StatusCode, "Should return 200 OK")

	body, err = ioutil.ReadAll(res.Body)
	require.NoError(t, err)
	var updated newsarticles.NewsArticleResponse
	require.NoError(t, json.Unmarshal(body, &updated))
	assert.Equal(t, stringPtr("Updated Test News Article"), updated.NewsArticle.Headline)
	// As in Rails, an update overwrites every field, so the omitted body is cleared.
	assert.Nil(t, updated.NewsArticle.Body)
}

func TestDeleteNewsArticle(t *testing.T) {
	// First create a news article to delete
	newsArticle := map[string]string{
		"headline": "Test Delete News Article",
		"body":     "Test content for the news article to delete",
	}

	body, err := json.Marshal(newsArticle)
	require.NoError(t, err)

	req, err := http.NewRequest("POST", newsArticleUrl, bytes.NewBuffer(body))
	require.NoError(t, err)
	req.Header.Set("Content-Type", "application/json")

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()

	// Should return 201 Created for successful creation
	assert.Equal(t, http.StatusCreated, res.StatusCode, "Should return 201 Created")

	// Parse the created news article to get its ID
	body, err = ioutil.ReadAll(res.Body)
	require.NoError(t, err)

	var created newsarticles.NewsArticleResponse
	err = json.Unmarshal(body, &created)
	require.NoError(t, err)

	// Now delete the news article
	url := fmt.Sprintf("%s/%d", newsArticleUrl, created.NewsArticle.Id)

	req, err = http.NewRequest("DELETE", url, nil)
	require.NoError(t, err)

	res, err = http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()

	// Should return 200 OK for successful deletion
	assert.Equal(t, http.StatusOK, res.StatusCode, "Should return 200 OK")
}

func TestPutNewsArticleWithInvalidID(t *testing.T) {
	url := newsArticleUrl + "/invalid"

	newsArticle := map[string]string{
		"headline": "Test News Article",
		"body":     "Test content",
	}

	body, err := json.Marshal(newsArticle)
	require.NoError(t, err)

	req, err := http.NewRequest("PUT", url, bytes.NewBuffer(body))
	require.NoError(t, err)
	req.Header.Set("Content-Type", "application/json")

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()

	// As in Rails, a non-numeric ID matches no article
	assert.Equal(t, http.StatusNotFound, res.StatusCode, "Invalid news article ID should return 404")
}

func TestDeleteNewsArticleWithInvalidID(t *testing.T) {
	url := newsArticleUrl + "/invalid"

	req, err := http.NewRequest("DELETE", url, nil)
	require.NoError(t, err)

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()

	// As in Rails, a non-numeric ID matches no article
	assert.Equal(t, http.StatusNotFound, res.StatusCode, "Invalid news article ID should return 404")
}
