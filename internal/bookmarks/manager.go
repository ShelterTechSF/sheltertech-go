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

func (m *Manager) Get(w http.ResponseWriter, r *http.Request) {

	dbBookmarks := m.DbClient.GetBookmarks()
	response := Bookmarks{
		Bookmarks: FromDBTypeArray(dbBookmarks),
	}
	writeJson(w, response)
}


func (m *Manager) Submit(w http.ResponseWriter, r *http.Request) {

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
	
	err = m.DbClient.SubmitBookmark(dbBookmark)
	if err != nil {
		log.Print(err)
		writeStatus(w, http.StatusInternalServerError)
	}
	 
	writeStatus(w, http.StatusCreated)

}

func (m *Manager) Update(w http.ResponseWriter, r *http.Request) {


	defer r.Body.Close()
	body, _ := ioutil.ReadAll(r.Body)

	bookmark := &Bookmark{}
	err := json.Unmarshal(body, bookmark)
	if err != nil {
		writeStatus(w, http.StatusInternalServerError)
	}

	dbBookmark := &db.Bookmark {
		Id: bookmark.Id,
		Order: bookmark.Order,
		FolderID: bookmark.FolderID,
		ServiceID: bookmark.ServiceID,
		ResourceID: bookmark.ResourceID,
		UserID: bookmark.UserID,
	}
	
	err = m.DbClient.UpdateBookmark(dbBookmark)
	if err != nil {
		log.Print(err)
		writeStatus(w, http.StatusInternalServerError)
	}
	 
	writeStatus(w, http.StatusCreated)

}


func (m *Manager) DeleteByID(w http.ResponseWriter, r *http.Request) {

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