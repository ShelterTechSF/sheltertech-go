package datathon

import (
	"encoding/csv"
	"net/http"

	"github.com/sheltertechsf/sheltertech-go/internal/db"
)

type Manager struct {
	DbClient *db.Manager
}

func New(dbManager *db.Manager) *Manager {
	manager := &Manager{
		DbClient: dbManager,
	}
	return manager
}

// GetContentCurationDataset Get Content Curation Dataset
//
//	@Summary		Get Content Curation Dataset
//	@Description	gives a csv of the content curation dataset
//	@Tags			datathon
//	@Produce		csv
//	@Success		200	{array}	datathon.Data
//	@Router			/datathon/content_curation_dataset [get]
func (m *Manager) GetContentCurationDataset(w http.ResponseWriter, r *http.Request) {
	dbContentCurationData := m.DbClient.GetContentCurationData()
	writeCsv(w, FromDBTypeArray(dbContentCurationData))
}

// GetDatathonDataset Get Datathon Dataset
//
//	@Summary		Get Datathon Dataset
//	@Description	gives a csv of the datathon dataset
//	@Tags			datathon
//	@Produce		csv
//	@Success		200	{array}	datathon.Data
//	@Router			/datathon/datathon_dataset [get]
func (m *Manager) GetDatathonDataset(w http.ResponseWriter, r *http.Request) {
	dbContentCurationData := m.DbClient.GetDatathonData()
	writeCsv(w, FromDBTypeArray(dbContentCurationData))
}

func writeCsv(w http.ResponseWriter, dataset []*Record) {
	records := [][]string{
		{"service_id", "service_name", "resource_id", "resource_name", "resource_website", "service_email", "service_updated_at"}, // Header
	}
	for _, record := range dataset {
		records = append(records, []string{record.ServiceId, record.ServiceName, record.ResourceId, record.ResourceName, record.ResourceWebsite, record.ServiceEmail, record.ServiceUpdatedAt})
	}
	w.Header().Set("Content-Type", "text/csv")
	wr := csv.NewWriter(w)
	if err := wr.WriteAll(records); err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
}
