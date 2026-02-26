package algolia

import (
	"fmt"
	"log"

	"github.com/algolia/algoliasearch-client-go/v3/algolia/search"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
)

// SearchService defines the interface for search indexing operations.
type SearchService interface {
	IndexResourceAndServices(resourceId int) error
	IsEnabled() bool
}

// AlgoliaClient implements SearchService using the Algolia SDK.
type AlgoliaClient struct {
	index    *search.Index
	dbClient *db.Manager
}

// NoopClient implements SearchService as a no-op (used when Algolia is not configured).
type NoopClient struct{}

// NewSearchService creates a SearchService. If appID or apiKey is empty, it returns
// a NoopClient that logs skipped operations instead of failing.
func NewSearchService(appID, apiKey, indexPrefix string, dbClient *db.Manager) SearchService {
	if appID == "" || apiKey == "" {
		log.Println("Algolia not configured: ALGOLIA_APPLICATION_ID or ALGOLIA_API_KEY missing. Search indexing disabled.")
		return &NoopClient{}
	}

	client := search.NewClient(appID, apiKey)
	indexName := indexPrefix + "_services_search"
	index := client.InitIndex(indexName)

	log.Printf("Algolia configured: indexing to %q", indexName)

	return &AlgoliaClient{
		index:    index,
		dbClient: dbClient,
	}
}

// IndexResourceAndServices reindexes a resource and all its approved services in Algolia.
func (a *AlgoliaClient) IndexResourceAndServices(resourceId int) error {
	resourceRecord, err := buildResourceRecord(a.dbClient, resourceId)
	if err != nil {
		return fmt.Errorf("building resource record: %w", err)
	}

	services := a.dbClient.GetApprovedServicesByResourceId(resourceId)
	resourceSchedule := a.dbClient.GetScheduleByResourceId(resourceId)

	var records []interface{}
	records = append(records, resourceRecord)

	for _, svc := range services {
		svcRecord := buildServiceRecord(a.dbClient, svc, resourceId, resourceRecord.Name, resourceSchedule)
		records = append(records, svcRecord)
	}

	res, err := a.index.SaveObjects(records)
	if err != nil {
		return fmt.Errorf("saving objects to Algolia: %w", err)
	}

	err = res.Wait()
	if err != nil {
		return fmt.Errorf("waiting for Algolia indexing: %w", err)
	}

	log.Printf("Algolia: indexed resource %d with %d service(s)", resourceId, len(services))
	return nil
}

// IsEnabled returns true for the real Algolia client.
func (a *AlgoliaClient) IsEnabled() bool {
	return true
}

// IndexResourceAndServices is a no-op for the NoopClient.
func (n *NoopClient) IndexResourceAndServices(resourceId int) error {
	log.Printf("Algolia not configured, skipping reindex for resource %d", resourceId)
	return nil
}

// IsEnabled returns false for the NoopClient.
func (n *NoopClient) IsEnabled() bool {
	return false
}
