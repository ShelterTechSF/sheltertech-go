package instructions

import (
	"encoding/json"
	"log"
	"net/http"

	"github.com/sheltertechsf/sheltertech-go/internal/common"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
)

type Manager struct {
	DbClient *db.Manager
}

func New(dbManager *db.Manager) *Manager {
	return &Manager{
		DbClient: dbManager,
	}
}

type createInstructionRequest struct {
	Instruction instructionPayload `json:"instruction"`
}

type instructionPayload struct {
	ServiceID   int    `json:"service_id"`
	Instruction string `json:"instruction"`
}

// Create creates an instruction for a service.
//
//	@Summary		Create Instruction
//	@Description	create an instruction for a service
//	@Tags			instructions
//	@Accept			json
//	@Produce		json
//	@Success		201	{object}	instructions.Instruction
//	@Failure		400	{object}	common.Error
//	@Failure		500	{object}	common.Error
//	@Router			/instructions [post]
func (m *Manager) Create(w http.ResponseWriter, r *http.Request) {
	var req createInstructionRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusBadRequest, "Invalid request body")
		return
	}

	if req.Instruction.ServiceID == 0 {
		common.WriteErrorJson(w, http.StatusBadRequest, "Service ID is required")
		return
	}

	created, err := m.DbClient.CreateInstruction(req.Instruction.ServiceID, req.Instruction.Instruction)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusInternalServerError, common.InternalServerErrorMessage)
		return
	}

	writeJSON(w, FromInstructionDBType(created), http.StatusCreated)
}

func writeJSON(w http.ResponseWriter, object interface{}, status int) {
	output, err := json.Marshal(object)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusInternalServerError, common.InternalServerErrorMessage)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(status)
	_, err = w.Write(output)
	if err != nil {
		log.Printf("%v", err)
	}
}
