package newsarticles

import (
	"strings"
	"time"

	"github.com/sheltertechsf/sheltertech-go/internal/db"
)

// NewsArticle is the Rails NewsArticlePresenter output. The field order matches
// Rails so the response bytes, and therefore the ETag, are the same.
type NewsArticle struct {
	Id             int        `json:"id"`
	Headline       *string    `json:"headline"`
	EffectiveDate  *RailsTime `json:"effective_date"`
	Body           *string    `json:"body"`
	Priority       *int64     `json:"priority"`
	ExpirationDate *RailsTime `json:"expiration_date"`
	Url            *string    `json:"url"`
}

// NewsArticleResponse wraps a single article, as Rails did.
type NewsArticleResponse struct {
	NewsArticle *NewsArticle `json:"news_article"`
}

type NewsArticles struct {
	NewsArticles []*NewsArticle `json:"news_articles"`
}

// RailsTime marshals the way ActiveSupport::TimeWithZone#as_json did with
// Time.zone = UTC: millisecond precision (truncated) and a "Z" suffix.
type RailsTime struct {
	time.Time
}

const railsTimeLayout = "2006-01-02T15:04:05.000Z"

func (t RailsTime) MarshalJSON() ([]byte, error) {
	return []byte(`"` + t.UTC().Format(railsTimeLayout) + `"`), nil
}

func (t *RailsTime) UnmarshalJSON(data []byte) error {
	parsed, err := time.Parse(railsTimeLayout, strings.Trim(string(data), `"`))
	t.Time = parsed
	return err
}

func railsTime(t *time.Time) *RailsTime {
	if t == nil {
		return nil
	}
	return &RailsTime{*t}
}

func newsArticleFromFields(id int, fields db.NewsArticleFields) *NewsArticle {
	return &NewsArticle{
		Id:             id,
		Headline:       fields.Headline,
		EffectiveDate:  railsTime(fields.EffectiveDate),
		Body:           fields.Body,
		Priority:       fields.Priority,
		ExpirationDate: railsTime(fields.ExpirationDate),
		Url:            fields.Url,
	}
}

// fieldsFromDBType returns the stored values of an article.
func fieldsFromDBType(article *db.NewsArticle) db.NewsArticleFields {
	var fields db.NewsArticleFields
	if article.Headline.Valid {
		fields.Headline = &article.Headline.String
	}
	if article.Body.Valid {
		fields.Body = &article.Body.String
	}
	if article.Priority.Valid {
		fields.Priority = &article.Priority.Int64
	}
	if article.Url.Valid {
		fields.Url = &article.Url.String
	}
	if article.EffectiveDate.Valid {
		fields.EffectiveDate = &article.EffectiveDate.Time
	}
	if article.ExpirationDate.Valid {
		fields.ExpirationDate = &article.ExpirationDate.Time
	}
	return fields
}

func FromNewsArticleDBType(article *db.NewsArticle) *NewsArticle {
	return newsArticleFromFields(article.Id, fieldsFromDBType(article))
}

func FromNewsArticlesDBTypeArray(articles []*db.NewsArticle) []*NewsArticle {
	newsArticles := []*NewsArticle{}
	for _, article := range articles {
		newsArticles = append(newsArticles, FromNewsArticleDBType(article))
	}
	return newsArticles
}
