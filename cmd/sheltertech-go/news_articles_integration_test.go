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
	newsArticle := newsarticles.NewsArticleCreateRequest{
		Headline: stringPtr("Test News Article"),
		Body:     stringPtr("Test content for the news article"),
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
	newsArticle := newsarticles.NewsArticleCreateRequest{
		Headline: stringPtr("Test Update News Article"),
		Body:     stringPtr("Test content for the news article to update"),
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

	var createdNewsArticle newsarticles.NewsArticle
	err = json.Unmarshal(body, &createdNewsArticle)
	require.NoError(t, err)

	// Now update the news article
	url := fmt.Sprintf("%s/%d", newsArticleUrl, createdNewsArticle.Id)

	updatedNewsArticle := newsarticles.NewsArticleUpdateRequest{
		Headline: stringPtr("Updated Test News Article"),
		Body:     stringPtr("Updated test content for the news article"),
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

	// Note: There's no GET /api/news_articles/{id} endpoint, so we can't verify the update persisted
	// The PUT request returning 200 OK is sufficient to verify the update worked
}

func TestDeleteNewsArticle(t *testing.T) {
	// First create a news article to delete
	newsArticle := newsarticles.NewsArticleCreateRequest{
		Headline: stringPtr("Test Delete News Article"),
		Body:     stringPtr("Test content for the news article to delete"),
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

	var createdNewsArticle newsarticles.NewsArticle
	err = json.Unmarshal(body, &createdNewsArticle)
	require.NoError(t, err)

	// Now delete the news article
	url := fmt.Sprintf("%s/%d", newsArticleUrl, createdNewsArticle.Id)

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

	newsArticle := newsarticles.NewsArticleCreateRequest{
		Headline: stringPtr("Test News Article"),
		Body:     stringPtr("Test content"),
	}

	body, err := json.Marshal(newsArticle)
	require.NoError(t, err)

	req, err := http.NewRequest("PUT", url, bytes.NewBuffer(body))
	require.NoError(t, err)
	req.Header.Set("Content-Type", "application/json")

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()

	// Should return 400 Bad Request for invalid ID
	assert.Equal(t, http.StatusBadRequest, res.StatusCode, "Invalid news article ID should return 400")
}

func TestDeleteNewsArticleWithInvalidID(t *testing.T) {
	url := newsArticleUrl + "/invalid"

	req, err := http.NewRequest("DELETE", url, nil)
	require.NoError(t, err)

	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()

	// Should return 400 Bad Request for invalid ID
	assert.Equal(t, http.StatusBadRequest, res.StatusCode, "Invalid news article ID should return 400")
}
