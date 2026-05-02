package bookmarks

import (
	"encoding/json"
	"io/ioutil"
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

// Get lists all bookmarks, optionally filtered by user_id
//
//	@Summary		Get Bookmarks
//	@Description	get all bookmarks, optionally filtered by user_id
//	@Tags			bookmarks
//	@Accept			json
//	@Produce		json
//	@Param			user_id	query		int	false	"Filter by user ID"
//	@Success		200		{object}	bookmarks.Bookmarks
//	@Failure		400		{object}	common.Error
//	@Failure		500		{object}	common.Error
//	@Router			/bookmarks [get]
func (m *Manager) Get(w http.ResponseWriter, r *http.Request) {

	var dbBookmarks []*db.Bookmark

	userId := r.URL.Query().Get("user_id")

	if userId != "" {
		iUserId, err := strconv.Atoi(userId)
		if err != nil {
			log.Printf("%v", err)
			common.WriteErrorJson(w, http.StatusBadRequest, err.Error())
			return
		}
		dbBookmarks, err = m.DbClient.GetBookmarksByUserID(iUserId)
		if err != nil {
			log.Printf("%v", err)
			common.WriteErrorJson(w, http.StatusInternalServerError, common.InternalServerErrorMessage)
			return
		}
	} else {
		var err error
		dbBookmarks, err = m.DbClient.GetBookmarks()
		if err != nil {
			log.Printf("%v", err)
			common.WriteErrorJson(w, http.StatusInternalServerError, common.InternalServerErrorMessage)
			return
		}
	}
	response := Bookmarks{
		Bookmarks: FromDBTypeArray(dbBookmarks),
	}
	writeJson(w, response)
}

// GetByID gets a bookmark by ID
//
//	@Summary		Get Bookmark by ID
//	@Description	get a single bookmark by its ID
//	@Tags			bookmarks
//	@Accept			json
//	@Produce		json
//	@Param			id	path		int	true	"Bookmark ID"
//	@Success		200	{object}	bookmarks.Bookmark
//	@Failure		400	{object}	common.Error
//	@Failure		500	{object}	common.Error
//	@Router			/bookmarks/{id} [get]
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

// Submit creates a new bookmark
//
//	@Summary		Create Bookmark
//	@Description	create a new bookmark
//	@Tags			bookmarks
//	@Accept			json
//	@Produce		json
//	@Param			bookmark	body	bookmarks.Bookmark	true	"Bookmark object"
//	@Success		201
//	@Failure		400	{object}	common.Error
//	@Failure		500	{object}	common.Error
//	@Router			/bookmarks [post]
func (m *Manager) Submit(w http.ResponseWriter, r *http.Request) {

	defer r.Body.Close()
	body, _ := ioutil.ReadAll(r.Body)

	bookmark := &Bookmark{}
	err := json.Unmarshal(body, bookmark)
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

	writeStatus(w, http.StatusCreated)
}

// Update updates an existing bookmark
//
//	@Summary		Update Bookmark
//	@Description	update an existing bookmark by ID
//	@Tags			bookmarks
//	@Accept			json
//	@Produce		json
//	@Param			id			path	int					true	"Bookmark ID"
//	@Param			bookmark	body	bookmarks.Bookmark	true	"Bookmark object"
//	@Success		201
//	@Failure		400	{object}	common.Error
//	@Failure		500	{object}	common.Error
//	@Router			/bookmarks/{id} [put]
func (m *Manager) Update(w http.ResponseWriter, r *http.Request) {

	defer r.Body.Close()
	body, _ := ioutil.ReadAll(r.Body)

	bookmark := &Bookmark{}
	err := json.Unmarshal(body, bookmark)
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

	writeStatus(w, http.StatusCreated)

}

// DeleteByID deletes a bookmark by ID
//
//	@Summary		Delete Bookmark
//	@Description	delete a bookmark by its ID
//	@Tags			bookmarks
//	@Accept			json
//	@Param			id	path		int	true	"Bookmark ID"
//	@Success		204
//	@Failure		400	{object}	common.Error
//	@Router			/bookmarks/{id} [delete]
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
		log.Println("error:", err)
	}
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	_, err = w.Write(output)
	if err != nil {
		panic(err)
	}
}

func writeStatus(w http.ResponseWriter, responseStatus int) {
	w.WriteHeader(responseStatus)
}
