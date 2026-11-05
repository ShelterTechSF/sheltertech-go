package newsarticles

import (
	"database/sql"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
)

// Keep Rails timestamp precision without changing request decoding or other presenters.
type railsNewsArticle struct {
	*NewsArticle
	EffectiveDate  *string `json:"effective_date"`
	ExpirationDate *string `json:"expiration_date"`
}

func railsArticle(article *db.NewsArticle) railsNewsArticle {
	return railsNewsArticle{NewsArticle: FromNewsArticleDBType(article), EffectiveDate: railsDate(article.EffectiveDate), ExpirationDate: railsDate(article.ExpirationDate)}
}
func railsDate(value sql.NullTime) *string {
	if !value.Valid {
		return nil
	}
	result := value.Time.UTC().Format("2006-01-02T15:04:05.000Z")
	return &result
}
