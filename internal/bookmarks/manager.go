package bookmarks

import (
	"encoding/json"
	"io/ioutil"
	"log"
	"net/http"
	"strconv"

	"github.com/go-chi/chi/v5"
	"github.com/sheltertechsf/sheltertech-go/internal/auth"
	"github.com/sheltertechsf/sheltertech-go/internal/common"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
)

// BookmarkDB defines the database operations used by this manager.
// *db.Manager satisfies this interface automatically.
type BookmarkDB interface {
	GetBookmarksByUserID(userId int) ([]*db.Bookmark, error)
	GetBookmarkByID(bookmarkId int) (*db.Bookmark, error)
	SubmitBookmark(bookmark *db.Bookmark) error
	UpdateBookmark(bookmark *db.Bookmark) error
	DeleteBookmarkByID(bookmarkId int) error
}

type Manager struct {
	DbClient BookmarkDB
}

func New(dbManager *db.Manager) *Manager {
	return &Manager{DbClient: dbManager}
}

func (m *Manager) Get(w http.ResponseWriter, r *http.Request) {
	user, err := auth.UserFromContext(r.Context())
	if err != nil {
		log.Printf("authentication failed: %v", err)
		common.WriteErrorJson(w, http.StatusUnauthorized, err.Error())
		return
	}

	dbBookmarks, err := m.DbClient.GetBookmarksByUserID(user.Id)
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
	user, err := auth.UserFromContext(r.Context())
	if err != nil {
		log.Printf("authentication failed: %v", err)
		common.WriteErrorJson(w, http.StatusUnauthorized, err.Error())
		return
	}

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
	if dbBookmark == nil {
		common.WriteErrorJson(w, http.StatusNotFound, "bookmark not found")
		return
	}
	if dbBookmark.UserID == nil || !auth.CanModify(user, *dbBookmark.UserID) {
		common.WriteErrorJson(w, http.StatusForbidden, "forbidden")
		return
	}

	writeJson(w, FromDBType(dbBookmark))
}

func (m *Manager) Submit(w http.ResponseWriter, r *http.Request) {
	user, err := auth.UserFromContext(r.Context())
	if err != nil {
		log.Printf("authentication failed: %v", err)
		common.WriteErrorJson(w, http.StatusUnauthorized, err.Error())
		return
	}

	defer r.Body.Close()
	body, _ := ioutil.ReadAll(r.Body)

	bookmark := &Bookmark{}
	err = json.Unmarshal(body, bookmark)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusBadRequest, err.Error())
		return
	}

	// Always use the authenticated user's ID, never the client-supplied value.
	bookmark.UserID = &user.Id

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

func (m *Manager) Update(w http.ResponseWriter, r *http.Request) {
	user, err := auth.UserFromContext(r.Context())
	if err != nil {
		log.Printf("authentication failed: %v", err)
		common.WriteErrorJson(w, http.StatusUnauthorized, err.Error())
		return
	}

	id, err := strconv.Atoi(chi.URLParam(r, "id"))
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusBadRequest, err.Error())
		return
	}

	existing, err := m.DbClient.GetBookmarkByID(id)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusInternalServerError, common.InternalServerErrorMessage)
		return
	}
	if existing == nil {
		common.WriteErrorJson(w, http.StatusNotFound, "bookmark not found")
		return
	}
	if existing.UserID == nil || !auth.CanModify(user, *existing.UserID) {
		common.WriteErrorJson(w, http.StatusForbidden, "forbidden")
		return
	}

	defer r.Body.Close()
	body, _ := ioutil.ReadAll(r.Body)

	bookmark := &Bookmark{}
	err = json.Unmarshal(body, bookmark)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusBadRequest, err.Error())
		return
	}

	dbBookmark := &db.Bookmark{
		Id:         id,
		Order:      bookmark.Order,
		FolderID:   bookmark.FolderID,
		ServiceID:  bookmark.ServiceID,
		ResourceID: bookmark.ResourceID,
		UserID:     &user.Id, // preserve ownership — never let client change this
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

func (m *Manager) DeleteByID(w http.ResponseWriter, r *http.Request) {
	user, err := auth.UserFromContext(r.Context())
	if err != nil {
		log.Printf("authentication failed: %v", err)
		common.WriteErrorJson(w, http.StatusUnauthorized, err.Error())
		return
	}

	bookmarkId, err := strconv.Atoi(chi.URLParam(r, "id"))
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusBadRequest, err.Error())
		return
	}

	existing, err := m.DbClient.GetBookmarkByID(bookmarkId)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusInternalServerError, common.InternalServerErrorMessage)
		return
	}
	if existing == nil {
		common.WriteErrorJson(w, http.StatusNotFound, "bookmark not found")
		return
	}
	if existing.UserID == nil || !auth.CanModify(user, *existing.UserID) {
		common.WriteErrorJson(w, http.StatusForbidden, "forbidden")
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
