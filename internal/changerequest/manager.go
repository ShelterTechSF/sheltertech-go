package changerequest

import (
	"database/sql"
	"encoding/json"
	"io"
	"log"
	"net/http"
	"strconv"
	"strings"

	"github.com/go-chi/chi/v5"
	"github.com/nyaruka/phonenumbers"
	"github.com/sheltertechsf/sheltertech-go/internal/common"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
)

const (
	StatusPending  = 0
	StatusApproved = 1
	StatusRejected = 2
	ActionAdd      = 0
	ActionEdit     = 1
	ActionRemove   = 2
)

const (
	TypeResourceChangeRequest     = "ResourceChangeRequest"
	TypeServiceChangeRequest      = "ServiceChangeRequest"
	TypeAddressChangeRequest      = "AddressChangeRequest"
	TypePhoneChangeRequest        = "PhoneChangeRequest"
	TypeNoteChangeRequest         = "NoteChangeRequest"
	TypeScheduleDayChangeRequest  = "ScheduleDayChangeRequest"
)

type Manager struct {
	DbClient *db.Manager
}

func New(dbManager *db.Manager) *Manager {
	return &Manager{DbClient: dbManager}
}

// CreateForResource handles POST /resources/{id}/change_requests
func (m *Manager) CreateForResource(w http.ResponseWriter, r *http.Request) {
	id, err := strconv.Atoi(chi.URLParam(r, "id"))
	if err != nil {
		common.WriteErrorJson(w, http.StatusBadRequest, "invalid resource id")
		return
	}
	ctx := CreateContext{ResourceID: &id}
	m.Create(w, r, &ctx)
}

// CreateForService handles POST /services/{id}/change_requests
func (m *Manager) CreateForService(w http.ResponseWriter, r *http.Request) {
	id, err := strconv.Atoi(chi.URLParam(r, "id"))
	if err != nil {
		common.WriteErrorJson(w, http.StatusBadRequest, "invalid service id")
		return
	}
	ctx := CreateContext{ServiceID: &id}
	m.Create(w, r, &ctx)
}

// CreateForAddress handles POST /addresses/{id}/change_requests
func (m *Manager) CreateForAddress(w http.ResponseWriter, r *http.Request) {
	id, err := strconv.Atoi(chi.URLParam(r, "id"))
	if err != nil {
		common.WriteErrorJson(w, http.StatusBadRequest, "invalid address id")
		return
	}
	ctx := CreateContext{AddressID: &id}
	m.Create(w, r, &ctx)
}

// CreateForPhone handles POST /phones/{id}/change_requests
func (m *Manager) CreateForPhone(w http.ResponseWriter, r *http.Request) {
	id, err := strconv.Atoi(chi.URLParam(r, "id"))
	if err != nil {
		common.WriteErrorJson(w, http.StatusBadRequest, "invalid phone id")
		return
	}
	ctx := CreateContext{PhoneID: &id}
	m.Create(w, r, &ctx)
}

// CreateForNote handles POST /notes/{id}/change_requests
func (m *Manager) CreateForNote(w http.ResponseWriter, r *http.Request) {
	id, err := strconv.Atoi(chi.URLParam(r, "id"))
	if err != nil {
		common.WriteErrorJson(w, http.StatusBadRequest, "invalid note id")
		return
	}
	ctx := CreateContext{NoteID: &id}
	m.Create(w, r, &ctx)
}

// CreateForScheduleDay handles POST /schedule_days/{id}/change_requests
func (m *Manager) CreateForScheduleDay(w http.ResponseWriter, r *http.Request) {
	id, err := strconv.Atoi(chi.URLParam(r, "id"))
	if err != nil {
		common.WriteErrorJson(w, http.StatusBadRequest, "invalid schedule_day id")
		return
	}
	ctx := CreateContext{ScheduleDayID: &id}
	m.Create(w, r, &ctx)
}

// CreateGeneric handles POST /change_requests (insert flow: type=addresses|phones|schedule_days, parent_resource_id, schedule_id)
func (m *Manager) CreateGeneric(w http.ResponseWriter, r *http.Request) {
	ctx := CreateContext{
		InsertType:        r.URL.Query().Get("type"),
		ParentResourceID: queryInt(r, "parent_resource_id"),
		ScheduleID:       queryInt(r, "schedule_id"),
	}
	m.Create(w, r, &ctx)
}

func queryInt(r *http.Request, key string) *int {
	s := r.URL.Query().Get(key)
	if s == "" {
		return nil
	}
	n, err := strconv.Atoi(s)
	if err != nil {
		return nil
	}
	return &n
}

// Submit is the legacy handler for POST /services/{id}/change_request (single path, no field_changes).
// It is kept for backward compatibility and delegates to CreateForService.
func (m *Manager) Submit(w http.ResponseWriter, r *http.Request) {
	id, err := strconv.Atoi(chi.URLParam(r, "id"))
	if err != nil {
		common.WriteErrorJson(w, http.StatusBadRequest, "invalid service id")
		return
	}
	ctx := CreateContext{ServiceID: &id}
	m.Create(w, r, &ctx)
}

func (m *Manager) Create(w http.ResponseWriter, r *http.Request, ctx *CreateContext) {
	defer r.Body.Close()
	body, err := io.ReadAll(r.Body)
	if err != nil {
		log.Printf("changerequest Create read body: %v", err)
		common.WriteErrorJson(w, http.StatusBadRequest, err.Error())
		return
	}

	var req CreateRequest
	if len(body) > 0 {
		if err := json.Unmarshal(body, &req); err != nil {
			log.Printf("changerequest Create unmarshal: %v", err)
			common.WriteErrorJson(w, http.StatusBadRequest, "invalid JSON")
			return
		}
	}

	fieldChanges := buildFieldChangesFromPayload(req.ChangeRequest)
	if fieldChanges == nil {
		fieldChanges = make(map[string]interface{})
	}

	// Insert flow: create new address/phone/schedule_day then create CR
	if ctx.ParentResourceID != nil && ctx.InsertType != "" {
		crType, objectID, resourceID, err := m.handleInsertChangeRequest(ctx, &req, fieldChanges)
		if err != nil {
			log.Printf("changerequest handleInsert: %v", err)
			common.WriteErrorJson(w, http.StatusBadRequest, err.Error())
			return
		}
		if crType == "" {
			common.WriteErrorJson(w, http.StatusPreconditionFailed, "unsupported insert type")
			return
		}
		changeReq := &db.ChangeRequest{
			Type:       crType,
			ObjectId:   objectID,
			Status:     StatusPending,
			Action:     ActionAdd,
			ResourceId: resourceID,
		}
		crID, err := m.DbClient.SubmitChangeRequest(changeReq)
		if err != nil {
			log.Printf("changerequest SubmitChangeRequest: %v", err)
			common.WriteErrorJson(w, http.StatusInternalServerError, common.InternalServerErrorMessage)
			return
		}
		for k, v := range fieldChanges {
			valStr := toString(v)
			if err := m.DbClient.InsertFieldChange(crID, k, valStr); err != nil {
				log.Printf("changerequest InsertFieldChange: %v", err)
			}
		}
		writeCreateResponse(w, crID, crType, objectID, fieldChanges)
		return
	}

	crType, objectID, resourceID, action, err := m.resolveContext(ctx)
	if err != nil {
		log.Printf("changerequest resolveContext: %v", err)
		common.WriteErrorJson(w, http.StatusBadRequest, err.Error())
		return
	}
	if crType == "" {
		common.WriteErrorJson(w, http.StatusBadRequest, "missing context (resource_id, service_id, address_id, phone_id, note_id, or schedule_day_id)")
		return
	}
	if crType == TypeAddressChangeRequest && req.ChangeRequest != nil {
		if a := req.ChangeRequest.Action; a != nil {
			if s, ok := a.(string); ok && strings.EqualFold(s, "remove") {
				action = ActionRemove
			}
		}
	}

	// Address remove action
	if crType == TypeAddressChangeRequest && action == ActionRemove {
		addr, err := m.DbClient.GetAddressByID(objectID)
		if err != nil || addr == nil {
			common.WriteErrorJson(w, http.StatusBadRequest, "address not found")
			return
		}
		if err := m.DbClient.DeleteAddress(objectID); err != nil {
			log.Printf("changerequest DeleteAddress: %v", err)
			common.WriteErrorJson(w, http.StatusInternalServerError, common.InternalServerErrorMessage)
			return
		}
		changeReq := &db.ChangeRequest{Type: crType, ObjectId: objectID, Status: StatusPending, Action: ActionRemove, ResourceId: resourceID}
		crID, _ := m.DbClient.SubmitChangeRequest(changeReq)
		writeCreateResponse(w, crID, crType, objectID, nil)
		m.DbClient.TouchResource(resourceID)
		return
	}

	changeReq := &db.ChangeRequest{
		Type:       crType,
		ObjectId:   objectID,
		Status:     StatusPending,
		Action:     action,
		ResourceId: resourceID,
	}
	crID, err := m.DbClient.SubmitChangeRequest(changeReq)
	if err != nil {
		log.Printf("changerequest SubmitChangeRequest: %v", err)
		common.WriteErrorJson(w, http.StatusInternalServerError, common.InternalServerErrorMessage)
		return
	}

	for k, v := range fieldChanges {
		valStr := toString(v)
		if err := m.DbClient.InsertFieldChange(crID, k, valStr); err != nil {
			log.Printf("changerequest InsertFieldChange: %v", err)
		}
	}

	fieldChangesList, _ := m.DbClient.GetFieldChangesByChangeRequestID(crID)
	persistChange(m.DbClient, crType, objectID, resourceID, fieldChangesList)
	m.DbClient.TouchResource(resourceID)

	writeCreateResponse(w, crID, crType, objectID, fieldChanges)
}

func (m *Manager) handleInsertChangeRequest(ctx *CreateContext, req *CreateRequest, fieldChanges map[string]interface{}) (crType string, objectID int, resourceID int, err error) {
	resourceID = *ctx.ParentResourceID
	switch ctx.InsertType {
	case "addresses":
		addr := &db.Address{
			Address1:      getStr(fieldChanges, "address_1"),
			City:          getStr(fieldChanges, "city"),
			StateProvince: getStr(fieldChanges, "state_province"),
			PostalCode:    getStr(fieldChanges, "postal_code"),
		}
		addr.ResourceId = sqlNullInt32(resourceID)
		setOptionalAddressFields(addr, fieldChanges)
		objectID, err = m.DbClient.InsertAddress(addr)
		if err != nil {
			return "", 0, 0, err
		}
		return TypeAddressChangeRequest, objectID, resourceID, nil
	case "phones":
		number := getStr(fieldChanges, "number")
		serviceType := getStr(fieldChanges, "service_type")
		if number == "" || serviceType == "" {
			return "", 0, 0, nil
		}
		objectID, err = m.DbClient.InsertPhone(resourceID, number, serviceType)
		if err != nil {
			return "", 0, 0, err
		}
		return TypePhoneChangeRequest, objectID, resourceID, nil
	default:
		return "", 0, 0, nil
	}
}

func setOptionalAddressFields(addr *db.Address, m map[string]interface{}) {
	if v := getStr(m, "attention"); v != "" {
		addr.Attention = sql.NullString{String: v, Valid: true}
	}
	if v := getStr(m, "address_2"); v != "" {
		addr.Address2 = sql.NullString{String: v, Valid: true}
	}
	if v := getStr(m, "name"); v != "" {
		addr.Name = sql.NullString{String: v, Valid: true}
	}
	if v := getStr(m, "description"); v != "" {
		addr.Description = sql.NullString{String: v, Valid: true}
	}
	// latitude/longitude could be set from geocoding; leave zero for now
}

func (m *Manager) resolveContext(ctx *CreateContext) (crType string, objectID int, resourceID int, action int, err error) {
	action = ActionEdit
	if ctx.ResourceID != nil {
		return TypeResourceChangeRequest, *ctx.ResourceID, *ctx.ResourceID, action, nil
	}
	if ctx.ServiceID != nil {
		svc, err := m.DbClient.GetServiceById(*ctx.ServiceID)
		if err != nil || svc == nil {
			return "", 0, 0, 0, err
		}
		if !svc.ResourceId.Valid {
			return "", 0, 0, 0, nil
		}
		return TypeServiceChangeRequest, *ctx.ServiceID, int(svc.ResourceId.Int32), action, nil
	}
	if ctx.AddressID != nil {
		addr, err := m.DbClient.GetAddressByID(*ctx.AddressID)
		if err != nil || addr == nil {
			return "", 0, 0, 0, err
		}
		if !addr.ResourceId.Valid {
			return "", 0, 0, 0, nil
		}
		return TypeAddressChangeRequest, *ctx.AddressID, int(addr.ResourceId.Int32), action, nil
	}
	if ctx.PhoneID != nil {
		ph, err := m.DbClient.GetPhoneByID(*ctx.PhoneID)
		if err != nil || ph == nil {
			return "", 0, 0, 0, err
		}
		return TypePhoneChangeRequest, *ctx.PhoneID, ph.ResourceId, action, nil
	}
	if ctx.NoteID != nil {
		note, err := m.DbClient.GetNoteByID(*ctx.NoteID)
		if err != nil || note == nil {
			return "", 0, 0, 0, err
		}
		if note.ResourceId.Valid {
			return TypeNoteChangeRequest, *ctx.NoteID, int(note.ResourceId.Int32), action, nil
		}
		if note.ServiceId.Valid {
			svc, _ := m.DbClient.GetServiceById(int(note.ServiceId.Int32))
			if svc != nil && svc.ResourceId.Valid {
				return TypeNoteChangeRequest, *ctx.NoteID, int(svc.ResourceId.Int32), action, nil
			}
		}
		return "", 0, 0, 0, nil
	}
	if ctx.ScheduleDayID != nil {
		_, scheduleID, err := m.DbClient.GetScheduleDayByID(*ctx.ScheduleDayID)
		if err != nil {
			return "", 0, 0, 0, err
		}
		sched, err := m.DbClient.GetScheduleByID(scheduleID)
		if err != nil || sched == nil {
			return "", 0, 0, 0, err
		}
		if sched.ResourceId.Valid {
			return TypeScheduleDayChangeRequest, *ctx.ScheduleDayID, int(sched.ResourceId.Int32), action, nil
		}
		if sched.ServiceId.Valid {
			svc, _ := m.DbClient.GetServiceById(int(sched.ServiceId.Int32))
			if svc != nil && svc.ResourceId.Valid {
				return TypeScheduleDayChangeRequest, *ctx.ScheduleDayID, int(svc.ResourceId.Int32), action, nil
			}
		}
		return "", 0, 0, 0, nil
	}
	return "", 0, 0, 0, nil
}

func buildFieldChangesFromPayload(p *ChangeRequestPayload) map[string]interface{} {
	if p == nil {
		return nil
	}
	out := make(map[string]interface{})
	if len(p.FieldChanges) > 0 {
		for k, v := range p.FieldChanges {
			if k == "categories" {
				out["category_ids"] = v
				continue
			}
			if k == "eligibilities" {
				out["eligibility_ids"] = v
				continue
			}
			out[k] = v
		}
		return out
	}
	// Flat fields
	if p.Website != "" {
		out["website"] = p.Website
	}
	if p.Name != "" {
		out["name"] = p.Name
	}
	if p.Note != "" {
		out["note"] = p.Note
	}
	if p.Number != "" {
		out["number"] = p.Number
	}
	if p.ServiceType != "" {
		out["service_type"] = p.ServiceType
	}
	if p.Address1 != "" {
		out["address_1"] = p.Address1
	}
	if p.City != "" {
		out["city"] = p.City
	}
	if p.StateProvince != "" {
		out["state_province"] = p.StateProvince
	}
	if p.PostalCode != "" {
		out["postal_code"] = p.PostalCode
	}
	if p.OpensAt != nil {
		out["opens_at"] = p.OpensAt
	}
	if p.ClosesAt != nil {
		out["closes_at"] = p.ClosesAt
	}
	if p.Day != "" {
		out["day"] = p.Day
	}
	if len(p.Categories) > 0 {
		ids := make([]int, len(p.Categories))
		for i, c := range p.Categories {
			ids[i] = c.Id
		}
		out["category_ids"] = ids
	}
	return out
}

func persistChange(dbc *db.Manager, crType string, objectID int, resourceID int, fieldChanges []*db.FieldChange) {
	updates := make(map[string]interface{})
	for _, fc := range fieldChanges {
		if fc.FieldName == "action" {
			continue
		}
		updates[fc.FieldName] = toDBValueFromString(fc.FieldName, fc.FieldValue)
	}

	switch crType {
	case TypeServiceChangeRequest:
		_ = dbc.UpdateService(objectID, updates)
	case TypeResourceChangeRequest:
		_ = dbc.UpdateResource(objectID, updates)
	case TypeAddressChangeRequest:
		_ = dbc.UpdateAddress(objectID, updates)
	case TypePhoneChangeRequest:
		if num, ok := updates["number"].(string); ok && num != "" {
			if parsed, err := phonenumbers.Parse(num, "US"); err == nil {
				updates["number"] = phonenumbers.Format(parsed, phonenumbers.E164)
			}
		}
		_ = dbc.UpdatePhone(objectID, updates)
	case TypeNoteChangeRequest:
		_ = dbc.UpdateNote(objectID, updates)
	case TypeScheduleDayChangeRequest:
		opensAt, _ := updates["opens_at"]
		closesAt, _ := updates["closes_at"]
		if opensAt == nil && closesAt == nil && len(updates) <= 1 {
			_ = dbc.DeleteScheduleDay(objectID)
		} else {
			_ = dbc.UpdateScheduleDay(objectID, updates)
		}
	}
}

func toDBValueFromString(fieldName, fieldValue string) interface{} {
	switch fieldName {
	case "opens_at", "closes_at":
		n, _ := strconv.Atoi(fieldValue)
		return n
	case "category_ids", "eligibility_ids":
		return fieldValue
	default:
		return fieldValue
	}
}

func toString(v interface{}) string {
	switch x := v.(type) {
	case string:
		return x
	case float64:
		return strconv.FormatFloat(x, 'f', -1, 64)
	case int:
		return strconv.Itoa(x)
	default:
		b, _ := json.Marshal(v)
		return string(b)
	}
}

func getStr(m map[string]interface{}, key string) string {
	if m == nil {
		return ""
	}
	v, ok := m[key]
	if !ok {
		return ""
	}
	s, _ := v.(string)
	return s
}

func sqlNullInt32(n int) sql.NullInt32 {
	return sql.NullInt32{Int32: int32(n), Valid: true}
}

func writeCreateResponse(w http.ResponseWriter, id int, crType string, objectID int, fieldChanges map[string]interface{}) {
	resp := CreateResponse{ID: id, Status: StatusPending, Type: crType, ObjectID: objectID}
	for k, v := range fieldChanges {
		resp.FieldChanges = append(resp.FieldChanges, FieldChangeResponse{FieldName: k, FieldValue: toString(v)})
	}
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)
	_ = json.NewEncoder(w).Encode(resp)
}
