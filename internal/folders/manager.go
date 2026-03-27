package folders

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"strconv"

	"github.com/go-chi/chi/v5"
	"github.com/sheltertechsf/sheltertech-go/internal/auth"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
)

// FolderDB defines the database operations used by this manager.
// *db.Manager satisfies this interface automatically.
type FolderDB interface {
	GetFolders(userId int) []*db.Folder
	GetFolderById(folderId int) *db.Folder
	CreateFolder(folder *db.Folder) (int, error)
	UpdateFolder(folder *db.Folder) error
	DeleteFolderById(folderId int) error
}

type Manager struct {
	DbClient FolderDB
}

func New(dbManager *db.Manager) *Manager {
	return &Manager{DbClient: dbManager}
}

// Get lists folders for the authenticated user
//
//	@Summary		Get Folders for current User
//	@Description	get folders for user
//	@Tags			folders
//	@Accept			json
//	@Produce		json
//	@Success		200	{array}	folders.Folders
//	@Router			/folders [get]
func (m *Manager) Get(w http.ResponseWriter, r *http.Request) {
	user, err := auth.UserFromContext(r.Context())
	if err != nil {
		log.Printf("authentication failed: %v", err)
		writeStatus(w, http.StatusUnauthorized)
		return
	}

	dbFolders := m.DbClient.GetFolders(user.Id)
	response := Folders{
		Folders: FromDBTypeArray(dbFolders),
	}
	writeJson(w, response)
}

// Post creates a folder for the authenticated user
//
//	@Summary		Create Folder for current User
//	@Description	new folder for user
//	@Tags			folders
//	@Accept			json
//	@Produce		json
//	@Success		200	{object}	folders.Folder
//	@Router			/folders [post]
func (m *Manager) Post(w http.ResponseWriter, r *http.Request) {
	user, err := auth.UserFromContext(r.Context())
	if err != nil {
		log.Printf("authentication failed: %v", err)
		writeStatus(w, http.StatusUnauthorized)
		return
	}

	defer r.Body.Close()
	body, _ := ioutil.ReadAll(r.Body)

	folder := &Folder{}
	err = json.Unmarshal(body, folder)
	if err != nil {
		writeStatus(w, http.StatusInternalServerError)
		return
	}

	dbFolder := &db.Folder{
		Name:   folder.Name,
		Order:  folder.Order,
		UserId: user.Id, // Always use the authenticated user's ID.
	}

	folderId, err := m.DbClient.CreateFolder(dbFolder)
	if err != nil {
		log.Print(err)
		writeStatus(w, http.StatusInternalServerError)
		return
	}

	dbFolder = m.DbClient.GetFolderById(folderId)
	if dbFolder == nil {
		// This really shouldn't happen, since we just created it.
		writeStatus(w, http.StatusInternalServerError)
		return
	}

	writeStatus(w, http.StatusCreated)
	writeJson(w, FromDBType(dbFolder))
}

// GetByID gets a folder by ID, only if owned by the authenticated user
//
//	@Summary		Get folder by ID
//	@Description	get current folder for user
//	@Tags			folders
//	@Accept			json
//	@Produce		json
//	@Success		200	{object}	folders.Folder
//	@Router			/folders/{id} [get]
func (m *Manager) GetByID(w http.ResponseWriter, r *http.Request) {
	user, err := auth.UserFromContext(r.Context())
	if err != nil {
		log.Printf("authentication failed: %v", err)
		writeStatus(w, http.StatusUnauthorized)
		return
	}

	folderId, err := strconv.Atoi(chi.URLParam(r, "id"))
	if err != nil {
		log.Printf("%v", err)
		writeStatus(w, http.StatusBadRequest)
		return
	}

	dbFolder := m.DbClient.GetFolderById(folderId)
	if dbFolder == nil {
		writeStatus(w, http.StatusNotFound)
		return
	}
	if !auth.CanModify(user, dbFolder.UserId) {
		writeStatus(w, http.StatusForbidden)
		return
	}

	writeJson(w, FromDBType(dbFolder))
}

// Put updates a folder by ID, only if owned by the authenticated user
//
//	@Summary		Update folder by ID
//	@Description	update a folder for user
//	@Tags			folders
//	@Accept			json
//	@Produce		json
//	@Success		200	{object}	folders.Folder
//	@Router			/folders/{id} [put]
func (m *Manager) Put(w http.ResponseWriter, r *http.Request) {
	user, err := auth.UserFromContext(r.Context())
	if err != nil {
		log.Printf("authentication failed: %v", err)
		writeStatus(w, http.StatusUnauthorized)
		return
	}

	folderId, err := strconv.Atoi(chi.URLParam(r, "id"))
	if err != nil {
		log.Printf("%v", err)
		writeStatus(w, http.StatusBadRequest)
		return
	}

	dbFolder := m.DbClient.GetFolderById(folderId)
	if dbFolder == nil {
		writeStatus(w, http.StatusNotFound)
		return
	}
	if !auth.CanModify(user, dbFolder.UserId) {
		writeStatus(w, http.StatusForbidden)
		return
	}

	defer r.Body.Close()
	body, _ := ioutil.ReadAll(r.Body)

	folder := &Folder{}
	err = json.Unmarshal(body, folder)
	if err != nil {
		writeStatus(w, http.StatusInternalServerError)
		return
	}

	dBFolder := &db.Folder{
		Id:    folderId,
		Name:  folder.Name,
		Order: folder.Order,
	}

	err = m.DbClient.UpdateFolder(dBFolder)
	if err != nil {
		log.Print(err)
		writeStatus(w, http.StatusInternalServerError)
		return
	}

	writeStatus(w, http.StatusCreated)
}

// Delete deletes a folder by ID, only if owned by the authenticated user
//
//	@Summary		Delete folder by ID
//	@Description	delete a folder for user
//	@Tags			folders
//	@Accept			json
//	@Produce		json
//	@Success		200	{object}	folders.Folder
//	@Router			/folders/{id} [delete]
func (m *Manager) Delete(w http.ResponseWriter, r *http.Request) {
	user, err := auth.UserFromContext(r.Context())
	if err != nil {
		log.Printf("authentication failed: %v", err)
		writeStatus(w, http.StatusUnauthorized)
		return
	}

	folderId, err := strconv.Atoi(chi.URLParam(r, "id"))
	if err != nil {
		log.Printf("%v", err)
		writeStatus(w, http.StatusBadRequest)
		return
	}

	dbFolder := m.DbClient.GetFolderById(folderId)
	if dbFolder == nil {
		writeStatus(w, http.StatusNotFound)
		return
	}
	if !auth.CanModify(user, dbFolder.UserId) {
		writeStatus(w, http.StatusForbidden)
		return
	}

	err = m.DbClient.DeleteFolderById(folderId)
	if err != nil {
		log.Print(err)
		writeStatus(w, http.StatusInternalServerError)
		return
	}

	writeStatus(w, http.StatusNoContent)
}

func writeJson(w http.ResponseWriter, object interface{}) {
	output, err := json.Marshal(object)
	if err != nil {
		fmt.Println("error:", err)
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
