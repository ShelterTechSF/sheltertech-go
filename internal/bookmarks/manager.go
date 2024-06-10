package bookmarks

import (
	"log"
	"net/http"
	"strconv"

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