package db

import (
	"database/sql"
	"fmt"
	"log"

	_ "github.com/lib/pq"
)

type Manager struct {
	DB *sql.DB
}

func New(dbHost, dbPort, dbName, dbUser, dbPass string) *Manager {
	psqlInfo := fmt.Sprintf("host=%s port=%s user=%s dbname=%s password=%s sslmode=disable",
		dbHost, dbPort, dbUser, dbName, dbPass)
	db, err := sql.Open("postgres", psqlInfo)
	if err != nil {
		panic(err)
	}

	err = db.Ping()
	if err != nil {
		panic(err)
	}

	fmt.Println("Successfully connected!")
	manager := &Manager{
		DB: db,
	}
	return manager
}

func (m *Manager) GetCategories(topLevel *bool) []*Category {
	var rows *sql.Rows
	var err error
	if topLevel != nil {
		rows, err = m.DB.Query(categoriesByTopLevelSql, topLevel)
	} else {
		rows, err = m.DB.Query(categoriesSql)
	}
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanCategories(rows)
}

func (m *Manager) GetCategoriesByFeatured() []*Category {
	var rows *sql.Rows
	var err error
	rows, err = m.DB.Query(categoriesByFeaturedSql)
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanCategories(rows)
}

func (m *Manager) GetSubCategoriesByID(categoryId int) []*Category {
	var rows *sql.Rows
	var err error
	rows, err = m.DB.Query(subCategoriesByIDSql, categoryId)
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanCategories(rows)
}

func (m *Manager) GetCategoryByID(categoryId int) *Category {
	row := m.DB.QueryRow(categoriesByIDSql, categoryId)
	return scanCategory(row)
}

func scanCategories(rows *sql.Rows) []*Category {
	var categories []*Category
	for rows.Next() {
		var category Category
		err := rows.Scan(&category.Id, &category.Name, &category.TopLevel, &category.Featured)
		switch err {
		case sql.ErrNoRows:
			fmt.Println("No rows were returned!")
			return nil
		}
		categories = append(categories, &category)
	}
	return categories
}

func scanCategory(row *sql.Row) *Category {
	var category Category
	err := row.Scan(&category.Id, &category.Name, &category.TopLevel, &category.Featured)
	switch err {
	case sql.ErrNoRows:
		fmt.Println("No rows were returned!")
		return nil
	default:
		panic(err)
	}
	return &category
}
