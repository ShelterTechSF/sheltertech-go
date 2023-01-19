package changerequest

import (
	"encoding/json"
	"io/ioutil"
	"log"
	"net/http"

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

func (m *Manager) Submit(w http.ResponseWriter, r *http.Request) {

	defer r.Body.Close()
	body, _ := ioutil.ReadAll(r.Body)

	changeRequest := &ChangeRequest{}
	err := json.Unmarshal(body, changeRequest)
	if err != nil {
		writeStatus(w, http.StatusInternalServerError)
	}

	var service *db.Service
	switch changeRequest.Type {
	case "ServiceChangeRequest":
		service = m.DbClient.GetServiceById(changeRequest.ObjectID)
		break
	}
	if err != nil || service == nil {
		writeStatus(w, http.StatusInternalServerError)
	}

	dBChangeRequest := &db.ChangeRequest{
		Type:       changeRequest.Type,
		ObjectId:   changeRequest.ObjectID,
		Status:     changeRequest.Status,
		Action:     changeRequest.Action,
		ResourceId: service.ResourceId,
	}

	err = m.DbClient.SubmitChangeRequest(dBChangeRequest)
	if err != nil {
		log.Print(err)
		writeStatus(w, http.StatusInternalServerError)
	}

	writeStatus(w, http.StatusCreated)
}

func writeStatus(w http.ResponseWriter, responseStatus int) {
	w.WriteHeader(responseStatus)
}
