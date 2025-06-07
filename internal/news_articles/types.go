package newsarticles

import (
	"time"

	"github.com/sheltertechsf/sheltertech-go/internal/db"
)

type NewsArticle struct {
	Id             int        `json:"id"`
	Headline       *string    `json:"headline"`
	Body           *string    `json:"body"`
	Priority       *int       `json:"priority"`
	Url            *string    `json:"url"`
	EffectiveDate  *time.Time `json:"effective_date"`
	ExpirationDate *time.Time `json:"expiration_date"`
}

type NewsArticles struct {
	NewsArticles []*NewsArticle `json:"news_articles"`
}

type NewsArticleCreateRequest struct {
	Headline       *string    `json:"headline"`
	Body           *string    `json:"body"`
	Priority       *int       `json:"priority"`
	Url            *string    `json:"url"`
	EffectiveDate  *time.Time `json:"effective_date"`
	ExpirationDate *time.Time `json:"expiration_date"`
}

type NewsArticleUpdateRequest struct {
	Headline       *string    `json:"headline,omitempty"`
	Body           *string    `json:"body,omitempty"`
	Priority       *int       `json:"priority,omitempty"`
	Url            *string    `json:"url,omitempty"`
	EffectiveDate  *time.Time `json:"effective_date,omitempty"`
	ExpirationDate *time.Time `json:"expiration_date,omitempty"`
}

func FromNewsArticleDBType(dbNewsArticle *db.NewsArticle) *NewsArticle {
	newsArticle := &NewsArticle{
		Id: dbNewsArticle.Id,
	}

	if dbNewsArticle.Headline.Valid {
		newsArticle.Headline = &dbNewsArticle.Headline.String
	}

	if dbNewsArticle.Body.Valid {
		newsArticle.Body = &dbNewsArticle.Body.String
	}

	if dbNewsArticle.Priority.Valid {
		priority := int(dbNewsArticle.Priority.Int32)
		newsArticle.Priority = &priority
	}

	if dbNewsArticle.Url.Valid {
		newsArticle.Url = &dbNewsArticle.Url.String
	}

	if dbNewsArticle.EffectiveDate.Valid {
		newsArticle.EffectiveDate = &dbNewsArticle.EffectiveDate.Time
	}

	if dbNewsArticle.ExpirationDate.Valid {
		newsArticle.ExpirationDate = &dbNewsArticle.ExpirationDate.Time
	}

	return newsArticle
}

func FromNewsArticlesDBTypeArray(dbNewsArticles []*db.NewsArticle) []*NewsArticle {
	newsArticles := []*NewsArticle{}
	for _, dbNewsArticle := range dbNewsArticles {
		newsArticles = append(newsArticles, FromNewsArticleDBType(dbNewsArticle))
	}
	return newsArticles
}
