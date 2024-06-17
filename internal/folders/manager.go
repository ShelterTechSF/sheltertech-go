package folders

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
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

// Get lists folders for current user 
// (note - I don't have the user auth stuff here)
//
//	@Summary		Get Folders for current User
//	@Description	get folders for user
//	@Tags			folders
//	@Accept			json
//	@Produce		json
//	@Success		200	{array}	folders.Folders
//	@Router			/folders [get]
func (m *Manager) Get(w http.ResponseWriter, r *http.Request) {
	userId, err := strconv.Atoi(chi.URLParam(r, "user_id"))
	if err != nil {
		fmt.Println("error:", err)
	}

	dbFolders := m.DbClient.GetFolders(userId)
	response := Folders{
		Folders: FromDBTypeArray(dbFolders),
	}
	writeJson(w, response)
}

// Create folder for current user 
// (note - I don't have the user auth stuff here)
//
//	@Summary		Create Folder for current User
//	@Description	new folder for user
//	@Tags			folders
//	@Accept			json
//	@Produce		json
//	@Success		200	{object}	folders.Folder
//	@Router			/folders [post]
func (m *Manager) Post(w http.ResponseWriter, r *http.Request) {
	defer r.Body.Close()
	body, _ := ioutil.ReadAll(r.Body)

	folder := &Folder{}
	err := json.Unmarshal(body, folder)
	if err != nil {
		writeStatus(w, http.StatusInternalServerError)
	}

	dBFolder := &db.Folder{
		Name:   folder.Name,
		Order:  folder.Order,
		UserId: folder.UserId,
	}

	err = m.DbClient.CreateFolder(dBFolder)
	if err != nil {
		log.Print(err)
		writeStatus(w, http.StatusInternalServerError)
	}

	writeStatus(w, http.StatusCreated)
}

// Get folder by ID
// (note - I don't have the user auth stuff here)
//
//	@Summary		Get folder by ID
//	@Description	get current folder for user
//	@Tags			folders
//	@Accept			json
//	@Produce		json
//	@Success		200	{object}	folders.Folder
//	@Router			/folders/{id} [get]
func (m *Manager) GetByID(w http.ResponseWriter, r *http.Request) {
	folderId, err := strconv.Atoi(chi.URLParam(r, "id"))
	if err != nil {
		log.Printf("%v", err)
	}
	dbFolder := m.DbClient.GetFolderById(folderId)
	writeJson(w, FromDBType(dbFolder))
}

// Update folder by ID
// not done

// (note - I don't have the user auth stuff here)
//
//	@Summary		Update folder by ID
//	@Description	update a folder for user
//	@Tags			folders
//	@Accept			json
//	@Produce		json
//	@Success		200	{object}	folders.Folder
//	@Router			/folders/{id} [put]
func (m *Manager) Put(w http.ResponseWriter, r *http.Request) {
	defer r.Body.Close()
	body, _ := ioutil.ReadAll(r.Body)

	folder := &Folder{}
	err := json.Unmarshal(body, folder)
	if err != nil {
		writeStatus(w, http.StatusInternalServerError)
	}

	dBFolder := &db.Folder{
		Id: folder.Id,
		Name:   folder.Name,
		Order:  folder.Order,
	}

	err = m.DbClient.UpdateFolder(dBFolder)
	if err != nil {
		log.Print(err)
		writeStatus(w, http.StatusInternalServerError)
	}

	writeStatus(w, http.StatusCreated)
}

// Delete folder by ID
// not done
// (note - I don't have the user auth stuff here)
//
//	@Summary		Delete folder by ID
//	@Description	delete a folder for user
//	@Tags			folders
//	@Accept			json
//	@Produce		json
//	@Success		200	{object}	folders.Folder
//	@Router			/folders/{id} [delete]
func (m *Manager) Delete(w http.ResponseWriter, r *http.Request) {
	folderId, err := strconv.Atoi(chi.URLParam(r, "id"))
	if err != nil {
		log.Printf("%v", err)
	}
	err = m.DbClient.DeleteFolderById(folderId)
	if err != nil {
		log.Print(err)
		writeStatus(w, http.StatusInternalServerError)
	}

	writeStatus(w, http.StatusCreated)
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