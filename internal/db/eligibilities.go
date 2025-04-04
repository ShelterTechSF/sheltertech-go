package db

import (
	"database/sql"
	"fmt"
	"log"
	"time"

	"github.com/lib/pq"
)

type Eligibility struct {
	Id          int
	Name        sql.NullString
	FeatureRank sql.NullInt32
	CreatedAt   time.Time
	UpdatedAt   time.Time
}

const eligibilitiesSql = `
SELECT e.id, e.name, e.feature_rank
FROM public.eligibilities e
`
const eligibilitiesByCategoryIDSql = `
SELECT e.id, e.name, e.feature_rank 
FROM public.eligibilities e
WHERE e.id IN (
    SELECT DISTINCT es.eligibility_id
    FROM public.eligibilities_services es
    WHERE es.service_id IN (
        SELECT cs.service_id
        FROM public.categories_services cs
		WHERE cs.category_id = $1
	)
)
ORDER BY 
   e.name ASC;
`
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

const featuredEligibilitiesSql = `
SELECT e.id, e.name, e.feature_rank
FROM public.eligibilities e
WHERE e.feature_rank IS NOT NULL
ORDER BY e.feature_rank ASC
`
const subEligibilitiesByParentNameSql = `
SELECT e.id, e.name, e.feature_rank
FROM public.eligibilities e
WHERE e.id IN (
    SELECT er.child_id 
    FROM public.eligibility_relationships er
    WHERE er.parent_id = (
        SELECT id 
        FROM public.eligibilities 
        WHERE name = $1
    )
)
ORDER BY e.name ASC
`

const subEligibilitiesByParentIDSql = `
SELECT e.id, e.name, e.feature_rank
FROM public.eligibilities e
WHERE e.id IN (
    SELECT er.child_id 
    FROM public.eligibility_relationships er
    WHERE er.parent_id = $1
)
ORDER BY e.name ASC
`

func (m *Manager) GetEligibilities() []*Eligibility {
	var rows *sql.Rows
	var err error
	stmt, err := m.DB.Prepare(eligibilitiesSql)
	if err != nil {
		log.Printf("Prepare failed: %v\n", err)
		return nil
	}
	rows, err = stmt.Query()
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanEligibilities(rows)

}

func (m *Manager) GetEligibilitiesByCategoryId(categoryId *int) []*Eligibility {
	var rows *sql.Rows
	var err error
	stmt, err := m.DB.Prepare(eligibilitiesByCategoryIDSql)
	if err != nil {
		log.Printf("Prepare failed: %v\n", err)
		return nil
	}
	rows, err = stmt.Query(*categoryId)
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanEligibilities(rows)

}

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

func (m *Manager) GetFeaturedEligibilities() []*Eligibility {
	var rows *sql.Rows
	var err error
	stmt, err := m.DB.Prepare(featuredEligibilitiesSql)
	if err != nil {
		log.Printf("Prepare failed: %v\n", err)
		return nil
	}
	rows, err = stmt.Query()
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanEligibilities(rows)
}

func (m *Manager) GetSubEligibilitiesByParentName(parentName string) []*Eligibility {
	var rows *sql.Rows
	var err error
	stmt, err := m.DB.Prepare(subEligibilitiesByParentNameSql)
	if err != nil {
		log.Printf("Prepare failed: %v\n", err)
		return nil
	}
	rows, err = stmt.Query(parentName)
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanEligibilities(rows)
}

func (m *Manager) GetSubEligibilitiesByParentID(parentID int) []*Eligibility {
	var rows *sql.Rows
	var err error
	stmt, err := m.DB.Prepare(subEligibilitiesByParentIDSql)
	if err != nil {
		log.Printf("Prepare failed: %v\n", err)
		return nil
	}
	rows, err = stmt.Query(parentID)
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
