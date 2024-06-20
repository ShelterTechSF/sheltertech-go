package bookmarks

import (
	"log"
	"net/http"
	"strconv"
	"encoding/json"
	"io/ioutil"


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

func (m *Manager) Submit(w http.ResponseWriter, r *http.Request) {

	log.Printf("In submit")

	defer r.Body.Close()
	body, _ := ioutil.ReadAll(r.Body)

	bookmark := &Bookmark{}
	err := json.Unmarshal(body, bookmark)
	if err != nil {
		writeStatus(w, http.StatusInternalServerError)
	}

	dbBookmark := &db.Bookmark {
		Order: bookmark.Order,
		FolderID: bookmark.FolderID,
		ServiceID: bookmark.ServiceID,
		ResourceID: bookmark.ResourceID,
		UserID: bookmark.UserID,
	}

	log.Printf("Unmarshalled")

	
	err = m.DbClient.SubmitBookmark(dbBookmark)
	if err != nil {
		log.Print(err)
		writeStatus(w, http.StatusInternalServerError)
	}
	 
	writeStatus(w, http.StatusCreated)

}

func (m *Manager) DeleteByID(w http.ResponseWriter, r *http.Request) {
	log.Printf("Hello world")

	bookmarkId, err := strconv.Atoi(chi.URLParam(r, "id"))
	if err != nil {
		log.Printf("%v", err)
	}

	log.Printf("id: %d", bookmarkId)

	err = m.DbClient.DeleteBookmarkByID(bookmarkId)
	if err != nil {
		log.Printf("%v", err)
	}

}

func writeStatus(w http.ResponseWriter, responseStatus int) {
	w.WriteHeader(responseStatus)
}