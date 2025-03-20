package datathon

import (
	"strconv"
	"time"

	"github.com/sheltertechsf/sheltertech-go/internal/db"
)

type Record struct {
	ServiceId        string
	ServiceName      string
	ResourceId       string
	ResourceName     string
	ResourceWebsite  string
	ServiceEmail     string
	ServiceUpdatedAt string
}

func FromDBTypeArray(dbContentCurationData []*db.DatathonData) []*Record {
	contentCurationData := []*Record{}
	for _, dbContentCurationRow := range dbContentCurationData {
		contentCurationData = append(contentCurationData, FromDBType(dbContentCurationRow))
	}
	return contentCurationData
}

func FromDBType(dbContentCurationData *db.DatathonData) *Record {
	contentCurationData := &Record{
		ServiceId:        strconv.Itoa(dbContentCurationData.ServiceId),
		ResourceId:       strconv.Itoa(dbContentCurationData.ResourceId),
		ResourceName:     dbContentCurationData.ResourceName,
		ServiceUpdatedAt: dbContentCurationData.ServiceUpdatedAt.Format(time.RFC3339),
	}
	if dbContentCurationData.ServiceName.Valid {
		contentCurationData.ServiceName = dbContentCurationData.ServiceName.String
	}
	if dbContentCurationData.ResourceWebsite.Valid {
		contentCurationData.ResourceWebsite = dbContentCurationData.ResourceWebsite.String
	}
	if dbContentCurationData.ServiceEmail.Valid {
		contentCurationData.ServiceEmail = dbContentCurationData.ServiceEmail.String
	}
	return contentCurationData
}
