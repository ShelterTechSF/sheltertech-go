//go:build integration

package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"github.com/stretchr/testify/require"
	"net/http"
	"strings"
	"testing"
)

func TestNewsUpdateOverwritesMissingFieldsLikeRails(t *testing.T) {
	manager := integrationDBManager()
	defer manager.DB.Close()
	var id int
	require.NoError(t, manager.DB.QueryRow(`INSERT INTO public.news_articles (headline,body,priority,url,created_at,updated_at) VALUES ('Old','Old body',7,'https://example.org',NOW(),NOW()) RETURNING id`).Scan(&id))
	defer manager.DB.Exec("DELETE FROM public.news_articles WHERE id=$1", id)
	req, err := http.NewRequest("PUT", fmt.Sprintf("%s/%d", newsArticleUrl, id), strings.NewReader(`{"news_article":{"headline":"Replacement"}}`))
	require.NoError(t, err)
	req.Header.Set("Content-Type", "application/json")
	res, err := http.DefaultClient.Do(req)
	require.NoError(t, err)
	defer res.Body.Close()
	require.Equal(t, 200, res.StatusCode)
	var response struct {
		NewsArticle map[string]interface{} `json:"news_article"`
	}
	require.NoError(t, json.NewDecoder(res.Body).Decode(&response))
	require.Equal(t, "Replacement", response.NewsArticle["headline"])
	require.Nil(t, response.NewsArticle["body"])
	require.Nil(t, response.NewsArticle["priority"])
	var body, url sql.NullString
	var priority sql.NullInt64
	require.NoError(t, manager.DB.QueryRow("SELECT body,url,priority FROM public.news_articles WHERE id=$1", id).Scan(&body, &url, &priority))
	require.False(t, body.Valid)
	require.False(t, url.Valid)
	require.False(t, priority.Valid)
}
