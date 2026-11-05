package db

import (
	"database/sql"
	"time"
)

type NewsArticle struct {
	Id             int
	Headline       sql.NullString
	Body           sql.NullString
	Priority       sql.NullInt64
	Url            sql.NullString
	EffectiveDate  sql.NullTime
	ExpirationDate sql.NullTime
}

// NewsArticleFields are the columns a create or update writes. A nil field is
// stored as NULL.
type NewsArticleFields struct {
	Headline       *string
	Body           *string
	Priority       *int64
	Url            *string
	EffectiveDate  *time.Time
	ExpirationDate *time.Time
}

// The news_articles timestamps are `timestamp without time zone` columns that
// Rails filled with UTC wall-clock times, so these queries compare and write
// UTC explicitly instead of relying on the session time zone.
//
// The list queries have no ORDER BY because the Rails endpoint had none.
const newsArticleColumns = `id, headline, body, priority, url, effective_date, expiration_date`

const newsArticlesSql = `SELECT ` + newsArticleColumns + ` FROM public.news_articles`

const activeNewsArticlesSql = `
SELECT ` + newsArticleColumns + `
FROM public.news_articles
WHERE (effective_date IS NULL OR effective_date <= timezone('UTC', NOW()))
  AND (expiration_date IS NULL OR expiration_date >= timezone('UTC', NOW()))
`

const newsArticleByIDSql = `SELECT ` + newsArticleColumns + ` FROM public.news_articles WHERE id = $1`

const createNewsArticleSql = `
INSERT INTO public.news_articles (
    headline, body, priority, url, effective_date, expiration_date, created_at, updated_at
)
VALUES ($1, $2, $3, $4, $5, $6, timezone('UTC', NOW()), timezone('UTC', NOW()))
RETURNING id
`

const updateNewsArticleSql = `
UPDATE public.news_articles
SET headline = $2,
    body = $3,
    priority = $4,
    url = $5,
    effective_date = $6,
    expiration_date = $7,
    updated_at = timezone('UTC', NOW())
WHERE id = $1
`

const deleteNewsArticleSql = `DELETE FROM public.news_articles WHERE id = $1`

func (m *Manager) GetNewsArticles() ([]*NewsArticle, error) {
	return m.queryNewsArticles(newsArticlesSql)
}

// GetActiveNewsArticles returns articles that are in effect now: started (or
// with no start) and not yet expired (or with no expiration).
func (m *Manager) GetActiveNewsArticles() ([]*NewsArticle, error) {
	return m.queryNewsArticles(activeNewsArticlesSql)
}

// GetNewsArticleByID returns nil and no error when there is no such article.
func (m *Manager) GetNewsArticleByID(id int64) (*NewsArticle, error) {
	articles, err := m.queryNewsArticles(newsArticleByIDSql, id)
	if err != nil || len(articles) == 0 {
		return nil, err
	}
	return articles[0], nil
}

// CreateNewsArticle inserts an article and returns its id.
func (m *Manager) CreateNewsArticle(fields NewsArticleFields) (int, error) {
	var id int
	err := m.DB.QueryRow(createNewsArticleSql, newsArticleArgs(fields)...).Scan(&id)
	return id, err
}

// UpdateNewsArticle overwrites every field of an article and bumps updated_at.
func (m *Manager) UpdateNewsArticle(id int, fields NewsArticleFields) error {
	_, err := m.DB.Exec(updateNewsArticleSql, append([]interface{}{id}, newsArticleArgs(fields)...)...)
	return err
}

func (m *Manager) DeleteNewsArticle(id int) error {
	_, err := m.DB.Exec(deleteNewsArticleSql, id)
	return err
}

// newsArticleArgs turns fields into query arguments. Times are sent as UTC and
// truncated to microseconds, the column precision, as Rails did.
func newsArticleArgs(fields NewsArticleFields) []interface{} {
	args := make([]interface{}, 6)
	if fields.Headline != nil {
		args[0] = *fields.Headline
	}
	if fields.Body != nil {
		args[1] = *fields.Body
	}
	if fields.Priority != nil {
		args[2] = *fields.Priority
	}
	if fields.Url != nil {
		args[3] = *fields.Url
	}
	if fields.EffectiveDate != nil {
		args[4] = fields.EffectiveDate.UTC().Truncate(time.Microsecond)
	}
	if fields.ExpirationDate != nil {
		args[5] = fields.ExpirationDate.UTC().Truncate(time.Microsecond)
	}
	return args
}

func (m *Manager) queryNewsArticles(query string, args ...interface{}) ([]*NewsArticle, error) {
	rows, err := m.DB.Query(query, args...)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	newsArticles := []*NewsArticle{}
	for rows.Next() {
		var newsArticle NewsArticle
		if err := rows.Scan(
			&newsArticle.Id,
			&newsArticle.Headline,
			&newsArticle.Body,
			&newsArticle.Priority,
			&newsArticle.Url,
			&newsArticle.EffectiveDate,
			&newsArticle.ExpirationDate,
		); err != nil {
			return nil, err
		}
		newsArticles = append(newsArticles, &newsArticle)
	}
	return newsArticles, rows.Err()
}
