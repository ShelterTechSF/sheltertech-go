package bookmarks

import (
	"encoding/json"
	"io"
	"log"
	"net/http"
	"strconv"

	"github.com/sheltertechsf/sheltertech-go/internal/common"
	"github.com/sheltertechsf/sheltertech-go/internal/db"

	"github.com/go-chi/chi/v5"
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

func (m *Manager) Get(w http.ResponseWriter, r *http.Request) {
	userId := r.URL.Query().Get("user_id")
	if userId == "" {
		common.WriteErrorJson(w, http.StatusBadRequest, "user_id query parameter is required")
		return
	}

	iUserId, err := strconv.Atoi(userId)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusBadRequest, err.Error())
		return
	}

	dbBookmarks, err := m.DbClient.GetBookmarksByUserID(iUserId)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusInternalServerError, common.InternalServerErrorMessage)
		return
	}

	response := Bookmarks{
		Bookmarks: FromDBTypeArray(dbBookmarks),
	}
	writeJson(w, response)
}

func (m *Manager) GetByID(w http.ResponseWriter, r *http.Request) {

	id, err := strconv.Atoi(chi.URLParam(r, "id"))
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusBadRequest, err.Error())
		return
	}

	dbBookmark, err := m.DbClient.GetBookmarkByID(id)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusInternalServerError, common.InternalServerErrorMessage)
		return
	}

	response := FromDBType(dbBookmark)

	writeJson(w, response)
}

func (m *Manager) Submit(w http.ResponseWriter, r *http.Request) {

	defer r.Body.Close()
	body, err := io.ReadAll(r.Body)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusBadRequest, "failed to read request body")
		return
	}

	bookmark := &Bookmark{}
	err = json.Unmarshal(body, bookmark)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusBadRequest, err.Error())
		return
	}

	dbBookmark := &db.Bookmark{
		Order:      bookmark.Order,
		FolderID:   bookmark.FolderID,
		ServiceID:  bookmark.ServiceID,
		ResourceID: bookmark.ResourceID,
		UserID:     bookmark.UserID,
		Name:       bookmark.Name,
	}

	err = m.DbClient.SubmitBookmark(dbBookmark)
	if err != nil {
		log.Print(err)
		common.WriteErrorJson(w, http.StatusInternalServerError, common.InternalServerErrorMessage)
		return
	}

	w.WriteHeader(http.StatusCreated)
}

func (m *Manager) Update(w http.ResponseWriter, r *http.Request) {

	defer r.Body.Close()
	body, err := io.ReadAll(r.Body)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusBadRequest, "failed to read request body")
		return
	}

	bookmark := &Bookmark{}
	err = json.Unmarshal(body, bookmark)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusBadRequest, err.Error())
		return
	}

	dbBookmark := &db.Bookmark{
		Id:         bookmark.Id,
		Order:      bookmark.Order,
		FolderID:   bookmark.FolderID,
		ServiceID:  bookmark.ServiceID,
		ResourceID: bookmark.ResourceID,
		UserID:     bookmark.UserID,
		Name:       bookmark.Name,
	}

	err = m.DbClient.UpdateBookmark(dbBookmark)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusInternalServerError, common.InternalServerErrorMessage)
		return
	}

	w.WriteHeader(http.StatusCreated)
}

func (m *Manager) DeleteByID(w http.ResponseWriter, r *http.Request) {

	bookmarkId, err := strconv.Atoi(chi.URLParam(r, "id"))
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusBadRequest, err.Error())
		return
	}

	err = m.DbClient.DeleteBookmarkByID(bookmarkId)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusBadRequest, err.Error())
	}
}

func writeJson(w http.ResponseWriter, object interface{}) {
	output, err := json.Marshal(object)
	if err != nil {
		log.Printf("error: %v", err)
		http.Error(w, "internal server error", http.StatusInternalServerError)
		return
	}
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	if _, err = w.Write(output); err != nil {
		log.Printf("error writing response: %v", err)
	}
}
