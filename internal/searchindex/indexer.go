package searchindex

import (
	"bytes"
	"encoding/json"
	"fmt"
	"net/http"
	"net/url"
	"time"
)

type Indexer interface {
	DeleteObject(objectID string) error
	SaveObject(objectID string, object interface{}) error
}

type NoopIndexer struct{}

func (NoopIndexer) DeleteObject(string) error {
	return nil
}

func (NoopIndexer) SaveObject(string, interface{}) error { return nil }

type AlgoliaIndexer struct {
	appID      string
	apiKey     string
	indexName  string
	httpClient *http.Client
}

func NewAlgoliaIndexer(appID, apiKey, indexPrefix string) Indexer {
	if appID == "" || apiKey == "" || indexPrefix == "" {
		return NoopIndexer{}
	}

	return &AlgoliaIndexer{
		appID:      appID,
		apiKey:     apiKey,
		indexName:  indexPrefix + "_services_search",
		httpClient: &http.Client{Timeout: 10 * time.Second},
	}
}

func (i *AlgoliaIndexer) DeleteObject(objectID string) error {
	return i.writeObject(http.MethodDelete, objectID, nil)
}

// SaveObject replaces the entire record, including when it is missing from the index.
func (i *AlgoliaIndexer) SaveObject(objectID string, object interface{}) error {
	body, err := json.Marshal(object)
	if err != nil {
		return err
	}
	return i.writeObject(http.MethodPut, objectID, body)
}

func (i *AlgoliaIndexer) writeObject(method, objectID string, body []byte) error {
	endpoint := fmt.Sprintf(
		"https://%s.algolia.net/1/indexes/%s/%s",
		i.appID,
		url.PathEscape(i.indexName),
		url.PathEscape(objectID),
	)

	req, err := http.NewRequest(method, endpoint, bytes.NewReader(body))
	if err != nil {
		return err
	}
	req.Header.Set("X-Algolia-Application-Id", i.appID)
	req.Header.Set("X-Algolia-API-Key", i.apiKey)
	req.Header.Set("Content-Type", "application/json")

	resp, err := i.httpClient.Do(req)
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	if resp.StatusCode < http.StatusOK || resp.StatusCode >= http.StatusMultipleChoices {
		return fmt.Errorf("algolia %s %s returned %s", method, objectID, resp.Status)
	}

	return nil
}

func ResourceObjectID(id int) string {
	return fmt.Sprintf("resource_%d", id)
}

func ServiceObjectID(id int) string {
	return fmt.Sprintf("service_%d", id)
}
