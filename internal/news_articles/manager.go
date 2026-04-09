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

func (m *Manager) Create(w http.ResponseWriter, r *http.Request) {
	var createReq NewsArticleCreateRequest
	err := json.NewDecoder(r.Body).Decode(&createReq)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusBadRequest, "Invalid request body")
		return
	}

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

	response := FromNewsArticleDBType(newsArticle)
	writeJson(w, response, http.StatusCreated)
}

func (m *Manager) Get(w http.ResponseWriter, r *http.Request) {
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

func (m *Manager) Update(w http.ResponseWriter, r *http.Request) {
	idStr := chi.URLParam(r, "id")
	id, err := strconv.Atoi(idStr)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusBadRequest, "Invalid news article ID format")
		return
	}

	var updateReq NewsArticleUpdateRequest
	err = json.NewDecoder(r.Body).Decode(&updateReq)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusBadRequest, "Invalid request body")
		return
	}

	newsArticles := m.DbClient.GetNewsArticlesByIDs([]int{id})
	if len(newsArticles) == 0 {
		common.WriteErrorJson(w, http.StatusNotFound, fmt.Sprintf("News article with ID %d not found", id))
		return
	}

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

	response := FromNewsArticleDBType(updatedNewsArticle)
	writeJson(w, response, http.StatusOK)
}

func (m *Manager) Delete(w http.ResponseWriter, r *http.Request) {
	idStr := chi.URLParam(r, "id")
	id, err := strconv.Atoi(idStr)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusBadRequest, "Invalid news article ID format")
		return
	}

	newsArticles := m.DbClient.GetNewsArticlesByIDs([]int{id})
	if len(newsArticles) == 0 {
		common.WriteErrorJson(w, http.StatusNotFound, fmt.Sprintf("News article with ID %d not found", id))
		return
	}

	err = m.DbClient.DeleteNewsArticle(id)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusInternalServerError, common.InternalServerErrorMessage)
		return
	}

	w.WriteHeader(http.StatusOK)
}

func writeJson(w http.ResponseWriter, object interface{}, status int) {
	output, err := json.Marshal(object)
	if err != nil {
		log.Printf("error marshaling response: %v", err)
		http.Error(w, "internal server error", http.StatusInternalServerError)
		return
	}
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(status)
	if _, err = w.Write(output); err != nil {
		log.Printf("error writing response: %v", err)
	}
}
