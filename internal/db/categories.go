package db

import (
	"database/sql"
	"fmt"
	"log"

	"github.com/lib/pq"
)

type Category struct {
	Id         int
	Name       string
	TopLevel   bool
	Vocabulary string
	Featured   bool
}

type CategoryCount struct {
	CategoryName string
	Count        int
}

const categoryServiceCounts = `
SELECT c.name, count(s.id) as services
FROM categories c
JOIN categories_services cs ON cs.category_id = c.id
JOIN services s ON s.id = cs.service_id
WHERE s.status = 1
GROUP BY c.name
ORDER BY c.name asc
`

const categoryResourceCounts = `
SELECT c.name, count(r.id) as resources
FROM categories c
JOIN categories_resources cr ON cr.category_id = c.id
JOIN resources r ON r.id = cr.resource_id
WHERE r.status = 1
GROUP BY c.name
ORDER BY c.name asc
`

const categoriesByFeaturedSql = `
SELECT id, name, top_level, featured 
FROM public.categories
WHERE featured = true
`

const subCategoriesByIDSql = `
SELECT id, name, top_level, featured 
FROM public.categories
WHERE id in (SELECT child_id from public.category_relationships WHERE parent_id = $1)
`

const categoriesSql = `
SELECT id, name, top_level, featured 
FROM public.categories
ORDER BY name
`

const categoriesByTopLevelSql = `
SELECT id, name, top_level, featured 
FROM public.categories
WHERE top_level = $1
ORDER BY name DESC
`

const categoriesByIDSql = `
SELECT id, name, top_level, featured 
FROM public.categories
WHERE id = $1
`

const categoriesByIDsSql = `
SELECT c.id, c.name, c.top_level, c.featured
FROM public.categories c
WHERE c.id = ANY ($1)
`

const categoriesByNamesSql = `
SELECT c.id, c.name, c.top_level, c.featured
FROM public.categories c
WHERE c.name = ANY ($1)
`

const categoriesByServiceIDSql = `
SELECT c.id, c.name, c.top_level, c.featured 
FROM public.categories c
LEFT JOIN public.categories_services cs on c.id = cs.category_id
WHERE cs.service_id = $1
ORDER BY c.id
`

const categoriesByResourceIDSql = `
SELECT c.id, c.name, c.top_level, c.featured 
FROM public.categories c
LEFT JOIN public.categories_resources cs on c.id = cs.category_id
WHERE cs.resource_id = $1
ORDER BY c.id
`

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
		return nil
	}
	defer rows.Close()
	categories, err := scanCategories(rows)
	if err != nil {
		log.Printf("%v\n", err)
		return nil
	}
	return categories
}

func (m *Manager) GetCategoryServiceCounts() []*CategoryCount {
	rows, err := m.DB.Query(categoryServiceCounts)
	if err != nil {
		log.Printf("%v\n", err)
		return nil
	}
	defer rows.Close()
	counts, err := scanCategoryCounts(rows)
	if err != nil {
		log.Printf("%v\n", err)
		return nil
	}
	return counts
}

func (m *Manager) GetCategoryResourceCounts() []*CategoryCount {
	rows, err := m.DB.Query(categoryResourceCounts)
	if err != nil {
		log.Printf("%v\n", err)
		return nil
	}
	defer rows.Close()
	counts, err := scanCategoryCounts(rows)
	if err != nil {
		log.Printf("%v\n", err)
		return nil
	}
	return counts
}

func (m *Manager) GetCategoriesByFeatured() []*Category {
	rows, err := m.DB.Query(categoriesByFeaturedSql)
	if err != nil {
		log.Printf("%v\n", err)
		return nil
	}
	defer rows.Close()
	categories, err := scanCategories(rows)
	if err != nil {
		log.Printf("%v\n", err)
		return nil
	}
	return categories
}

func (m *Manager) GetSubCategoriesByID(categoryId int) []*Category {
	rows, err := m.DB.Query(subCategoriesByIDSql, categoryId)
	if err != nil {
		log.Printf("%v\n", err)
		return nil
	}
	defer rows.Close()
	categories, err := scanCategories(rows)
	if err != nil {
		log.Printf("%v\n", err)
		return nil
	}
	return categories
}

func (m *Manager) GetCategoryByID(categoryId int) (*Category, error) {
	row := m.DB.QueryRow(categoriesByIDSql, categoryId)
	return scanCategory(row)
}

func (m *Manager) GetCategoriesByIDs(ids []int) []*Category {
	stmt, err := m.DB.Prepare(categoriesByIDsSql)
	if err != nil {
		log.Printf("Prepare failed: %v\n", err)
		return nil
	}
	defer stmt.Close()
	rows, err := stmt.Query(pq.Array(ids))
	if err != nil {
		log.Printf("%v\n", err)
		return nil
	}
	defer rows.Close()
	categories, err := scanCategories(rows)
	if err != nil {
		log.Printf("%v\n", err)
		return nil
	}
	return categories
}

func (m *Manager) GetCategoriesByNames(names []string) []*Category {
	stmt, err := m.DB.Prepare(categoriesByNamesSql)
	if err != nil {
		log.Printf("Prepare failed: %v\n", err)
		return nil
	}
	defer stmt.Close()
	rows, err := stmt.Query(pq.Array(names))
	if err != nil {
		log.Printf("%v\n", err)
		return nil
	}
	defer rows.Close()
	categories, err := scanCategories(rows)
	if err != nil {
		log.Printf("%v\n", err)
		return nil
	}
	return categories
}

func (m *Manager) GetCategoriesByServiceID(serviceId int) []*Category {
	rows, err := m.DB.Query(categoriesByServiceIDSql, serviceId)
	if err != nil {
		log.Printf("%v\n", err)
		return nil
	}
	defer rows.Close()
	categories, err := scanCategories(rows)
	if err != nil {
		log.Printf("%v\n", err)
		return nil
	}
	return categories
}

func (m *Manager) GetCategoriesByResourceID(resourceId int) []*Category {
	rows, err := m.DB.Query(categoriesByResourceIDSql, resourceId)
	if err != nil {
		log.Printf("%v\n", err)
		return nil
	}
	defer rows.Close()
	categories, err := scanCategories(rows)
	if err != nil {
		log.Printf("%v\n", err)
		return nil
	}
	return categories
}

func scanCategories(rows *sql.Rows) ([]*Category, error) {
	var categories []*Category
	for rows.Next() {
		var category Category
		err := rows.Scan(&category.Id, &category.Name, &category.TopLevel, &category.Featured)
		if err != nil {
			if err == sql.ErrNoRows {
				return nil, nil
			}
			return nil, err
		}
		categories = append(categories, &category)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return categories, nil
}

func scanCategory(row *sql.Row) (*Category, error) {
	var category Category
	err := row.Scan(&category.Id, &category.Name, &category.TopLevel, &category.Featured)
	if err != nil {
		switch err {
		case sql.ErrNoRows:
			fmt.Println("No rows were returned!")
			return nil, nil
		default:
			return nil, err
		}
	}
	return &category, nil
}

func scanCategoryCounts(rows *sql.Rows) ([]*CategoryCount, error) {
	var counts []*CategoryCount
	for rows.Next() {
		var count CategoryCount
		err := rows.Scan(&count.CategoryName, &count.Count)
		if err != nil {
			if err == sql.ErrNoRows {
				return nil, nil
			}
			return nil, err
		}
		counts = append(counts, &count)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return counts, nil
}
