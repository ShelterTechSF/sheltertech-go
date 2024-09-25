package db

import (
	"database/sql"
	"fmt"
	"github.com/lib/pq"
	"log"
	"time"
)

type Eligibility struct {
	Id          int
	Name        sql.NullString
	FeatureRank sql.NullInt32
	CreatedAt   time.Time
	UpdatedAt   time.Time
}

const eligibilitiesByIDsSql = `
SELECT e.id, e.name, e.feature_rank
FROM public.eligibilities e
WHERE e.id = ANY ($1)
`

const eligibilitiesByNamesSql = `
SELECT e.id, e.name, e.feature_rank
FROM public.eligibilities e
WHERE e.name = ANY ($1)
`

const eligibilitiesByServiceIDSql = `
SELECT e.id, e.name, e.feature_rank
FROM public.eligibilities e
LEFT JOIN public.eligibilities_services es on e.id = es.eligibility_id
WHERE es.service_id = $1
`

func (m *Manager) GetEligibilitiesByIDs(ids []int) []*Eligibility {
	var rows *sql.Rows
	var err error
	stmt, err := m.DB.Prepare(eligibilitiesByIDsSql)
	if err != nil {
		log.Printf("Prepare failed: %v\n", err)
		return nil
	}
	rows, err = stmt.Query(pq.Array(ids))
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanEligibilities(rows)
}

func (m *Manager) GetEligibilitiesByNames(names []string) []*Eligibility {
	var rows *sql.Rows
	var err error
	stmt, err := m.DB.Prepare(eligibilitiesByNamesSql)
	if err != nil {
		log.Printf("Prepare failed: %v\n", err)
		return nil
	}
	rows, err = stmt.Query(pq.Array(names))
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanEligibilities(rows)
}

func (m *Manager) GetEligibilitiesByServiceID(serviceId int) []*Eligibility {
	var rows *sql.Rows
	var err error
	rows, err = m.DB.Query(eligibilitiesByServiceIDSql, serviceId)
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanEligibilities(rows)
}

func scanEligibilities(rows *sql.Rows) []*Eligibility {
	var eligibilities []*Eligibility
	for rows.Next() {
		var eligibility Eligibility
		err := rows.Scan(&eligibility.Id, &eligibility.Name, &eligibility.FeatureRank)
		switch err {
		case sql.ErrNoRows:
			fmt.Println("No rows were returned!")
			return nil
		}
		eligibilities = append(eligibilities, &eligibility)
	}
	return eligibilities
}
