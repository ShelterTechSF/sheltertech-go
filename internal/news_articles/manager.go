package newsarticles

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"strconv"

	"github.com/go-chi/chi/v5"
	"github.com/sheltertechsf/sheltertech-go/internal/common"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
)

type Manager struct {
	DbClient *db.Manager
}

func New(dbManager *db.Manager) *Manager {
	manager := &Manager{
		DbClient: dbManager,
	}
	return manager
}

// Create news article
//
//	@Summary        Create News Article
//	@Description    Create a new news article
//	@Tags           news_articles
//	@Accept         json
//	@Produce        json
//	@Param          body body newsarticles.NewsArticleCreateRequest true "News article data"
//	@Success        201 {object} newsarticles.NewsArticle
//	@Failure        400 {object} error "Invalid request body"
//	@Failure        500 {object} error "Internal server error"
//	@Router         /news_articles [post]
func (m *Manager) Create(w http.ResponseWriter, r *http.Request) {
	// Parse request body
	var createReq NewsArticleCreateRequest
	err := json.NewDecoder(r.Body).Decode(&createReq)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusBadRequest, "Invalid request body")
		return
	}

	// Create new news article
	newsArticle, err := m.DbClient.CreateNewsArticle(
		createReq.Headline,
		createReq.Body,
		createReq.Priority,
		createReq.Url,
		createReq.EffectiveDate,
		createReq.ExpirationDate,
	)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusInternalServerError, common.InternalServerErrorMessage)
		return
	}

	// Return the created news article
	response := FromNewsArticleDBType(newsArticle)
	writeJson(w, response, http.StatusCreated)
}

// Get all news articles
//
//	@Summary        Get News Articles
//	@Description    Get all news articles with optional filtering for active articles only
//	@Tags           news_articles
//	@Produce        json
//	@Param          active query boolean false "Filter for active news articles only"
//	@Success        200 {array} newsarticles.NewsArticle
//	@Router         /news_articles [get]
func (m *Manager) Get(w http.ResponseWriter, r *http.Request) {
	// Check for unexpected query parameters
	validParams := map[string]bool{"active": true}

	for param := range r.URL.Query() {
		if !validParams[param] {
			errMsg := fmt.Sprintf("Unexpected query parameter: %s", param)
			log.Printf("%v", errMsg)
			common.WriteErrorJson(w, http.StatusBadRequest, errMsg)
			return
		}
	}

	var newsArticles []*db.NewsArticle
	if activeParam := r.URL.Query().Get("active"); activeParam != "" {
		newsArticles = m.DbClient.GetActiveNewsArticles()
	} else {
		newsArticles = m.DbClient.GetNewsArticles()
	}

	response := NewsArticles{
		NewsArticles: FromNewsArticlesDBTypeArray(newsArticles),
	}
	writeJson(w, response, http.StatusOK)
}

// Update news article
//
//	@Summary        Update News Article
//	@Description    Update an existing news article
//	@Tags           news_articles
//	@Accept         json
//	@Produce        json
//	@Param          id path integer true "News Article ID"
//	@Param          body body newsarticles.NewsArticleUpdateRequest true "News article update data"
//	@Success        200 {object} newsarticles.NewsArticle
//	@Failure        400 {object} error "Invalid request body"
//	@Failure        404 {object} error "News article not found"
//	@Failure        500 {object} error "Internal server error"
//	@Router         /news_articles/{id} [put]
func (m *Manager) Update(w http.ResponseWriter, r *http.Request) {
	// Get the ID from the URL parameters
	idStr := chi.URLParam(r, "id")
	id, err := strconv.Atoi(idStr)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusBadRequest, "Invalid news article ID format")
		return
	}

	// Parse request body
	var updateReq NewsArticleUpdateRequest
	err = json.NewDecoder(r.Body).Decode(&updateReq)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusBadRequest, "Invalid request body")
		return
	}

	// Get the existing news article
	newsArticles := m.DbClient.GetNewsArticlesByIDs([]int{id})
	if len(newsArticles) == 0 {
		common.WriteErrorJson(w, http.StatusNotFound, fmt.Sprintf("News article with ID %d not found", id))
		return
	}

	// Update the news article
	updatedNewsArticle, err := m.DbClient.UpdateNewsArticle(
		id,
		updateReq.Headline,
		updateReq.Body,
		updateReq.Priority,
		updateReq.Url,
		updateReq.EffectiveDate,
		updateReq.ExpirationDate,
	)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusInternalServerError, common.InternalServerErrorMessage)
		return
	}

	// Return the updated news article
	response := FromNewsArticleDBType(updatedNewsArticle)
	writeJson(w, response, http.StatusOK)
}

// Delete news article
//
//	@Summary        Delete News Article
//	@Description    Delete an existing news article
//	@Tags           news_articles
//	@Param          id path integer true "News Article ID"
//	@Success        200 {object} object "Empty response on success"
//	@Failure        400 {object} error "Invalid news article ID format"
//	@Failure        404 {object} error "News article not found"
//	@Failure        500 {object} error "Internal server error"
//	@Router         /news_articles/{id} [delete]
func (m *Manager) Delete(w http.ResponseWriter, r *http.Request) {
	// Get the ID from the URL parameters
	idStr := chi.URLParam(r, "id")
	id, err := strconv.Atoi(idStr)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusBadRequest, "Invalid news article ID format")
		return
	}

	// Check if the news article exists
	newsArticles := m.DbClient.GetNewsArticlesByIDs([]int{id})
	if len(newsArticles) == 0 {
		common.WriteErrorJson(w, http.StatusNotFound, fmt.Sprintf("News article with ID %d not found", id))
		return
	}

	// Delete the news article
	err = m.DbClient.DeleteNewsArticle(id)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusInternalServerError, common.InternalServerErrorMessage)
		return
	}

	// Return success
	w.WriteHeader(http.StatusOK)
}

func writeJson(w http.ResponseWriter, object interface{}, status int) {
	output, err := json.Marshal(object)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusInternalServerError, common.InternalServerErrorMessage)
		return
	}
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(status)
	_, err = w.Write(output)
	if err != nil {
		panic(err)
	}
}
