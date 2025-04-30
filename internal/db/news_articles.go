package db

import (
	"database/sql"
	"fmt"
	"log"
	"time"

	"github.com/lib/pq"
)

type NewsArticle struct {
	Id             int
	Headline       sql.NullString
	Body           sql.NullString
	Priority       sql.NullInt32
	Url            sql.NullString
	EffectiveDate  sql.NullTime
	ExpirationDate sql.NullTime
	CreatedAt      time.Time
	UpdatedAt      time.Time
}

const newsArticlesSql = `
SELECT na.id, na.headline, na.body, na.priority, na.url, na.effective_date, na.expiration_date
FROM public.news_articles na
ORDER BY 
   na.priority DESC, na.created_at DESC;
`

const activeNewsArticlesSql = `
SELECT na.id, na.headline, na.body, na.priority, na.url, na.effective_date, na.expiration_date
FROM public.news_articles na
WHERE (na.effective_date IS NULL OR na.effective_date <= NOW())
  AND (na.expiration_date IS NULL OR na.expiration_date >= NOW())
ORDER BY 
   na.priority DESC, na.created_at DESC;
`

const newsArticlesByIDsSql = `
SELECT na.id, na.headline, na.body, na.priority, na.url, na.effective_date, na.expiration_date
FROM public.news_articles na
WHERE na.id = ANY ($1)
`

const createNewsArticleSql = `
INSERT INTO public.news_articles (
    headline, body, priority, url, effective_date, expiration_date, created_at, updated_at
)
VALUES ($1, $2, $3, $4, $5, $6, NOW(), NOW())
RETURNING id, headline, body, priority, url, effective_date, expiration_date
`

const updateNewsArticleSql = `
UPDATE public.news_articles
SET headline = COALESCE($2, headline),
    body = COALESCE($3, body),
    priority = COALESCE($4, priority),
    url = COALESCE($5, url),
    effective_date = COALESCE($6, effective_date),
    expiration_date = COALESCE($7, expiration_date),
    updated_at = NOW()
WHERE id = $1
RETURNING id, headline, body, priority, url, effective_date, expiration_date
`

const deleteNewsArticleSql = `
DELETE FROM public.news_articles
WHERE id = $1
`

func (m *Manager) GetNewsArticles() []*NewsArticle {
	var rows *sql.Rows
	var err error
	stmt, err := m.DB.Prepare(newsArticlesSql)
	if err != nil {
		log.Printf("Prepare failed: %v\n", err)
		return nil
	}
	rows, err = stmt.Query()
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanNewsArticles(rows)
}

func (m *Manager) GetActiveNewsArticles() []*NewsArticle {
	var rows *sql.Rows
	var err error
	stmt, err := m.DB.Prepare(activeNewsArticlesSql)
	if err != nil {
		log.Printf("Prepare failed: %v\n", err)
		return nil
	}
	rows, err = stmt.Query()
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanNewsArticles(rows)
}

func (m *Manager) GetNewsArticlesByIDs(ids []int) []*NewsArticle {
	var rows *sql.Rows
	var err error
	stmt, err := m.DB.Prepare(newsArticlesByIDsSql)
	if err != nil {
		log.Printf("Prepare failed: %v\n", err)
		return nil
	}
	rows, err = stmt.Query(pq.Array(ids))
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanNewsArticles(rows)
}

func (m *Manager) CreateNewsArticle(
	headline *string,
	body *string,
	priority *int,
	url *string,
	effectiveDate *time.Time,
	expirationDate *time.Time,
) (*NewsArticle, error) {
	var newsArticle NewsArticle

	// Set parameters for the query
	var headlineParam, bodyParam, urlParam interface{}
	var priorityParam, effectiveDateParam, expirationDateParam interface{}

	headlineParam = nil
	if headline != nil {
		headlineParam = *headline
	}

	bodyParam = nil
	if body != nil {
		bodyParam = *body
	}

	priorityParam = nil
	if priority != nil {
		priorityParam = *priority
	}

	urlParam = nil
	if url != nil {
		urlParam = *url
	}

	effectiveDateParam = nil
	if effectiveDate != nil {
		effectiveDateParam = *effectiveDate
	}

	expirationDateParam = nil
	if expirationDate != nil {
		expirationDateParam = *expirationDate
	}

	// Execute the query
	row := m.DB.QueryRow(
		createNewsArticleSql,
		headlineParam,
		bodyParam,
		priorityParam,
		urlParam,
		effectiveDateParam,
		expirationDateParam,
	)

	err := row.Scan(
		&newsArticle.Id,
		&newsArticle.Headline,
		&newsArticle.Body,
		&newsArticle.Priority,
		&newsArticle.Url,
		&newsArticle.EffectiveDate,
		&newsArticle.ExpirationDate,
	)

	if err != nil {
		return nil, err
	}

	return &newsArticle, nil
}

func (m *Manager) UpdateNewsArticle(
	id int,
	headline *string,
	body *string,
	priority *int,
	url *string,
	effectiveDate *time.Time,
	expirationDate *time.Time,
) (*NewsArticle, error) {
	var newsArticle NewsArticle

	// Set parameters for the query
	var headlineParam, bodyParam, urlParam interface{}
	var priorityParam, effectiveDateParam, expirationDateParam interface{}

	headlineParam = nil
	if headline != nil {
		headlineParam = *headline
	}

	bodyParam = nil
	if body != nil {
		bodyParam = *body
	}

	priorityParam = nil
	if priority != nil {
		priorityParam = *priority
	}

	urlParam = nil
	if url != nil {
		urlParam = *url
	}

	effectiveDateParam = nil
	if effectiveDate != nil {
		effectiveDateParam = *effectiveDate
	}

	expirationDateParam = nil
	if expirationDate != nil {
		expirationDateParam = *expirationDate
	}
	// Execute the query
	row := m.DB.QueryRow(
		updateNewsArticleSql,
		id,
		headlineParam,
		bodyParam,
		priorityParam,
		urlParam,
		effectiveDateParam,
		expirationDateParam,
	)

	err := row.Scan(
		&newsArticle.Id,
		&newsArticle.Headline,
		&newsArticle.Body,
		&newsArticle.Priority,
		&newsArticle.Url,
		&newsArticle.EffectiveDate,
		&newsArticle.ExpirationDate,
	)

	if err != nil {
		if err == sql.ErrNoRows {
			return nil, fmt.Errorf("news article with ID %d not found", id)
		}
		return nil, err
	}

	return &newsArticle, nil
}

func (m *Manager) DeleteNewsArticle(id int) error {
	_, err := m.DB.Exec(deleteNewsArticleSql, id)
	return err
}

func scanNewsArticles(rows *sql.Rows) []*NewsArticle {
	var newsArticles []*NewsArticle
	for rows.Next() {
		var newsArticle NewsArticle
		err := rows.Scan(
			&newsArticle.Id,
			&newsArticle.Headline,
			&newsArticle.Body,
			&newsArticle.Priority,
			&newsArticle.Url,
			&newsArticle.EffectiveDate,
			&newsArticle.ExpirationDate,
		)

		switch err {
		case sql.ErrNoRows:
			fmt.Println("No rows were returned!")
			return nil
		case nil:
			newsArticles = append(newsArticles, &newsArticle)
		default:
			log.Printf("Scan error: %v\n", err)
			return nil
		}
	}

	if err := rows.Err(); err != nil {
		log.Printf("Rows error: %v\n", err)
		return nil
	}

	return newsArticles
}
