package db

import (
	"database/sql"
	"fmt"
	"time"
)

type DatathonData struct {
	ServiceId        int
	ServiceName      sql.NullString
	ResourceId       int
	ResourceName     string
	ResourceWebsite  sql.NullString
	ServiceUpdatedAt time.Time
}

// dischageNavigatorWhiteLabelCategories are (1000001,1000002,1000003,1000004,1000005,1000006,1000007,1000008,1000009,1000010,1000011,1000012,2000001,2000002,2000003,2000004,2000005,2000006)

const contentCurationData = `
SELECT s.id AS service_id,
       s.name AS service_name,
       s.resource_id,
       r.name,
       r.website,
       s.updated_at
FROM public.services s
LEFT JOIN public.resources r ON s.resource_id = r.id
WHERE (s.id IN
        (SELECT DISTINCT a.service_id
         FROM public.categories_services a
         LEFT JOIN public.services b ON a.service_id = b.id
         WHERE a.category_id IN
           (SELECT child_id
            FROM public.category_relationships
            WHERE parent_id IN (1000001,1000002,1000003,1000004,1000005,1000006,1000007,1000008,1000009,1000010,1000011,1000012,2000001,2000002,2000003,2000004,2000005,2000006))
          AND b.status = 1))
 AND s.status = 1 ORDER BY s.resource_id
`

const datathonData = `
SELECT s.id AS service_id,
       s.name AS service_name,
       s.resource_id,
       r.name,
       r.website,
       s.updated_at
FROM public.services s
LEFT JOIN public.resources r ON s.resource_id = r.id
WHERE (s.id NOT IN
        (SELECT DISTINCT a.service_id
         FROM public.categories_services a
         LEFT JOIN public.services b ON a.service_id = b.id
         WHERE a.category_id IN
           (SELECT child_id
            FROM public.category_relationships
            WHERE parent_id IN (1000001,1000002,1000003,1000004,1000005,1000006,1000007,1000008,1000009,1000010,1000011,1000012,2000001,2000002,2000003,2000004,2000005,2000006))
          AND b.status = 1))
 AND s.status = 1 ORDER BY s.resource_id
`

func (m *Manager) GetContentCurationData() []*DatathonData {
	var rows *sql.Rows
	var err error
	rows, err = m.DB.Query(contentCurationData)
	if err != nil {
	}
	return scanDatathonData(rows)
}

func (m *Manager) GetDatathonData() []*DatathonData {
	var rows *sql.Rows
	var err error
	rows, err = m.DB.Query(datathonData)
	if err != nil {
	}
	return scanDatathonData(rows)
}

func scanDatathonData(rows *sql.Rows) []*DatathonData {
	var records []*DatathonData
	for rows.Next() {
		var record DatathonData
		err := rows.Scan(&record.ServiceId, &record.ServiceName, &record.ResourceId, &record.ResourceName, &record.ResourceWebsite, &record.ServiceUpdatedAt)
		switch err {
		case sql.ErrNoRows:
			fmt.Println("No rows were returned!")
			return nil
		}
		records = append(records, &record)
	}
	return records
}
