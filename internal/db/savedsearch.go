package db

import (
	"database/sql"
	"database/sql/driver"
	"encoding/json"
	"errors"
	"fmt"
	"log"
)

type SavedSearchQuery struct {
	Eligibilities []int    `json:"eligibilities"`
	Categories    []int    `json:"categories"`
	Lat           *float64 `json:"lat"`
	Lng           *float64 `json:"lng"`
	Query         string   `json:"query"`
}

// Methods needed for automatic serialization/deserialization to JSONB column.
// https://www.alexedwards.net/blog/using-postgresql-jsonb

func (s SavedSearchQuery) Value() (driver.Value, error) {
	return json.Marshal(s)
}

func (s *SavedSearchQuery) Scan(value interface{}) error {
	b, ok := value.([]byte)
	if !ok {
		return errors.New("type assertion to []byte failed")
	}
	return json.Unmarshal(b, &s)
}

const savedSearchByIDSql = `
SELECT id, user_id, name, search
FROM public.saved_searches
WHERE id = $1
`

const savedSearchesByUserIDSql = `
SELECT ss.id, ss.user_id, ss.name, ss.search
FROM public.saved_searches ss
WHERE ss.user_id = $1
`

const createSavedSearchSql = `
INSERT INTO public.saved_searches (user_id, name, search, created_at, updated_at)
VALUES ($1, $2, $3, now(), now())
RETURNING id
`

const deleteSavedSearchSql = `
DELETE FROM public.saved_searches ss
WHERE ss.id = $1
`

type SavedSearch struct {
	Id     int
	UserId int
	Name   string
	Search SavedSearchQuery
}

func (m *Manager) GetSavedSearchById(savedSearchId int) *SavedSearch {
	row := m.DB.QueryRow(savedSearchByIDSql, savedSearchId)
	return scanSavedSearch(row)
}

func (m *Manager) GetSavedSearches(userId int) []*SavedSearch {
	var rows *sql.Rows
	var err error
	rows, err = m.DB.Query(savedSearchesByUserIDSql, userId)
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanSavedSearches(rows)
}

func (m *Manager) CreateSavedSearch(savedSearch *SavedSearch) (int, error) {
	tx, err := m.DB.Begin()
	if err != nil {
		return -1, err
	}
	row := tx.QueryRow(createSavedSearchSql, savedSearch.UserId, savedSearch.Name, savedSearch.Search)
	var id int
	err = row.Scan(&id)
	if err != nil {
		return -1, err
	}
	return id, tx.Commit()
}

func (m *Manager) DeleteSavedSearchById(id int) error {
	tx, err := m.DB.Begin()
	if err != nil {
		return err
	}

	res, err := tx.Exec(deleteSavedSearchSql, id)
	if err != nil {
		return err
	}
	rowCount, err := res.RowsAffected()
	if err != nil {
		return err
	}
	if rowCount != 1 {
		defer tx.Rollback()
		return errors.New(fmt.Sprintf("unexpected rows modified, expected one, saw %v", rowCount))
	}
	return tx.Commit()
}

func scanSavedSearches(rows *sql.Rows) []*SavedSearch {
	var savedSearches []*SavedSearch
	for rows.Next() {
		var savedSearch SavedSearch
		err := rows.Scan(&savedSearch.Id, &savedSearch.UserId, &savedSearch.Name, &savedSearch.Search)
		switch err {
		case sql.ErrNoRows:
			fmt.Println("No rows were returned!")
			return nil
		}
		savedSearches = append(savedSearches, &savedSearch)
	}
	return savedSearches
}

func scanSavedSearch(row *sql.Row) *SavedSearch {
	var savedSearch SavedSearch
	err := row.Scan(&savedSearch.Id, &savedSearch.UserId, &savedSearch.Name, &savedSearch.Search)
	if err != nil {
		switch err {
		case sql.ErrNoRows:
			fmt.Println("No rows were returned!")
			return nil
		default:
			panic(err)
		}
	}
	return &savedSearch
}
