package searchindex

import (
	"encoding/json"
	"errors"
	"io"
	"net/http"
	"strings"
	"testing"

	"github.com/stretchr/testify/require"
)

type roundTripFunc func(*http.Request) (*http.Response, error)

func (f roundTripFunc) RoundTrip(r *http.Request) (*http.Response, error) { return f(r) }

func TestSaveObject(t *testing.T) {
	index := NewAlgoliaIndexer("app", "key", "test user").(*AlgoliaIndexer)
	index.httpClient.Transport = roundTripFunc(func(r *http.Request) (*http.Response, error) {
		require.Equal(t, http.MethodPut, r.Method)
		require.Equal(t, "https://app.algolia.net/1/indexes/test%20user_services_search/service_42", r.URL.String())
		require.Equal(t, "app", r.Header.Get("X-Algolia-Application-Id"))
		require.Equal(t, "key", r.Header.Get("X-Algolia-API-Key"))
		require.Equal(t, "application/json", r.Header.Get("Content-Type"))
		body, err := io.ReadAll(r.Body)
		require.NoError(t, err)
		require.JSONEq(t, `{"objectID":"service_42","notes":["old","new"],"name":"Test"}`, string(body))
		return &http.Response{StatusCode: 200, Body: io.NopCloser(strings.NewReader(`{"taskID":12}`))}, nil
	})
	require.NoError(t, index.SaveObject("service_42", map[string]interface{}{"objectID": "service_42", "notes": []string{"old", "new"}, "name": "Test"}))
}

func TestSaveObjectErrors(t *testing.T) {
	for _, status := range []int{400, 403, 429, 500} {
		index := NewAlgoliaIndexer("app", "key", "test").(*AlgoliaIndexer)
		index.httpClient.Transport = roundTripFunc(func(r *http.Request) (*http.Response, error) {
			return &http.Response{StatusCode: status, Status: http.StatusText(status), Body: io.NopCloser(strings.NewReader("error"))}, nil
		})
		require.Error(t, index.SaveObject("service_42", json.RawMessage(`{}`)))
	}
	index := NewAlgoliaIndexer("app", "key", "test").(*AlgoliaIndexer)
	index.httpClient.Transport = roundTripFunc(func(*http.Request) (*http.Response, error) { return nil, errors.New("offline") })
	require.Error(t, index.SaveObject("service_42", map[string]string{}))
	require.Error(t, index.SaveObject("service_42", make(chan int)))
	require.NoError(t, NewAlgoliaIndexer("", "", "").SaveObject("service_42", nil))
}
