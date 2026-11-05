package newsarticles

import (
	"database/sql"
	"encoding/json"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
	"github.com/stretchr/testify/require"
	"testing"
	"time"
)

func TestRailsArticleDatePrecisionAndNull(t *testing.T) {
	article := &db.NewsArticle{Id: 42, EffectiveDate: sql.NullTime{Valid: true, Time: time.Date(2026, 1, 1, 1, 0, 0, 123456000, time.FixedZone("offset", 3600))}}
	raw, err := json.Marshal(railsArticle(article))
	require.NoError(t, err)
	require.JSONEq(t, `{"id":42,"headline":null,"body":null,"priority":null,"url":null,"effective_date":"2026-01-01T00:00:00.123Z","expiration_date":null}`, string(raw))
}
