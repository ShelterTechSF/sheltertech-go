package folders

import (
	"encoding/json"
	"io"
	"log"
	"net/http"
	"strconv"

	"github.com/go-chi/chi/v5"
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

func (m *Manager) Get(w http.ResponseWriter, r *http.Request) {
	userId, err := strconv.Atoi(r.URL.Query().Get("user_id"))
	if err != nil {
		log.Printf("error: %v", err)
		w.WriteHeader(http.StatusBadRequest)
		return
	}

	dbFolders, err := m.DbClient.GetFolders(userId)
	if err != nil {
		log.Printf("error: %v", err)
		w.WriteHeader(http.StatusInternalServerError)
		return
	}
	response := Folders{
		Folders: FromDBTypeArray(dbFolders),
	}
	writeJson(w, response)
}

func (m *Manager) Post(w http.ResponseWriter, r *http.Request) {
	defer r.Body.Close()
	body, err := io.ReadAll(r.Body)
	if err != nil {
		log.Printf("error reading body: %v", err)
		w.WriteHeader(http.StatusBadRequest)
		return
	}

	folder := &Folder{}
	err = json.Unmarshal(body, folder)
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		return
	}

	dbFolder := &db.Folder{
		Name:   folder.Name,
		Order:  folder.Order,
		UserId: folder.UserId,
	}

	folderId, err := m.DbClient.CreateFolder(dbFolder)
	if err != nil {
		log.Print(err)
		w.WriteHeader(http.StatusInternalServerError)
		return
	}

	dbFolder, err = m.DbClient.GetFolderById(folderId)
	if err != nil {
		log.Print(err)
		w.WriteHeader(http.StatusInternalServerError)
		return
	}
	if dbFolder == nil {
		// This really shouldn't happen, since we just created it.
		w.WriteHeader(http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusCreated)
	writeJson(w, FromDBType(dbFolder))
}

func (m *Manager) GetByID(w http.ResponseWriter, r *http.Request) {
	folderId, err := strconv.Atoi(chi.URLParam(r, "id"))
	if err != nil {
		log.Printf("%v", err)
		w.WriteHeader(http.StatusBadRequest)
		return
	}
	dbFolder, err := m.DbClient.GetFolderById(folderId)
	if err != nil {
		log.Printf("%v", err)
		w.WriteHeader(http.StatusInternalServerError)
		return
	}
	if dbFolder == nil {
		w.WriteHeader(http.StatusNotFound)
	} else {
		writeJson(w, FromDBType(dbFolder))
	}
}

func (m *Manager) Put(w http.ResponseWriter, r *http.Request) {
	defer r.Body.Close()
	body, err := io.ReadAll(r.Body)
	if err != nil {
		log.Printf("error reading body: %v", err)
		w.WriteHeader(http.StatusBadRequest)
		return
	}

	folder := &Folder{}
	err = json.Unmarshal(body, folder)
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		return
	}

	dBFolder := &db.Folder{
		Id:    folder.Id,
		Name:  folder.Name,
		Order: folder.Order,
	}

	err = m.DbClient.UpdateFolder(dBFolder)
	if err != nil {
		log.Print(err)
		w.WriteHeader(http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusCreated)
}

func (m *Manager) Delete(w http.ResponseWriter, r *http.Request) {
	folderId, err := strconv.Atoi(chi.URLParam(r, "id"))
	if err != nil {
		log.Printf("%v", err)
		w.WriteHeader(http.StatusBadRequest)
		return
	}
	err = m.DbClient.DeleteFolderById(folderId)
	if err != nil {
		log.Print(err)
		w.WriteHeader(http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusNoContent)
}

func writeJson(w http.ResponseWriter, object interface{}) {
	output, err := json.Marshal(object)
	if err != nil {
		log.Printf("error marshaling response: %v", err)
		http.Error(w, "internal server error", http.StatusInternalServerError)
		return
	}
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	if _, err = w.Write(output); err != nil {
		log.Printf("error writing response: %v", err)
	}
}
