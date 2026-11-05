package newsarticles

import (
	"github.com/DATA-DOG/go-sqlmock"
	"github.com/stretchr/testify/require"
	"net/http"
	"testing"
)

func TestCreateAcceptsRailsNewsArticleEnvelope(t *testing.T) {
	router, mock := newTestRouter(t)
	mock.ExpectQuery(`INSERT INTO public\.news_articles`).WithArgs("Nested", nil, nil, nil, nil, nil).WillReturnRows(sqlmock.NewRows([]string{"id"}).AddRow(9))
	w := serve(router, http.MethodPost, "/api/news_articles", `{"news_article":{"headline":"Nested"}}`)
	require.Equal(t, http.StatusCreated, w.Code)
	require.JSONEq(t, `{"news_article":{"id":9,"headline":"Nested","body":null,"priority":null,"url":null,"effective_date":null,"expiration_date":null}}`, w.Body.String())
}
