package searchindex

import (
	"fmt"
	"net/http"
	"net/url"
	"time"
)

type Indexer interface {
	DeleteObject(objectID string) error
}

type NoopIndexer struct{}

func (NoopIndexer) DeleteObject(string) error {
	return nil
}

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
	endpoint := fmt.Sprintf(
		"https://%s.algolia.net/1/indexes/%s/%s",
		i.appID,
		url.PathEscape(i.indexName),
		url.PathEscape(objectID),
	)

	req, err := http.NewRequest(http.MethodDelete, endpoint, nil)
	if err != nil {
		return err
	}
	req.Header.Set("X-Algolia-Application-Id", i.appID)
	req.Header.Set("X-Algolia-API-Key", i.apiKey)

	resp, err := i.httpClient.Do(req)
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	if resp.StatusCode < http.StatusOK || resp.StatusCode >= http.StatusMultipleChoices {
		return fmt.Errorf("algolia delete %s returned %s", objectID, resp.Status)
	}

	return nil
}

func ServiceObjectID(id int) string {
	return fmt.Sprintf("service_%d", id)
}
