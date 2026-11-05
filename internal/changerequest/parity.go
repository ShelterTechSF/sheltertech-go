package changerequest

import (
	"bytes"
	"context"
	"database/sql"
	"encoding/json"
	"errors"
	"github.com/sheltertechsf/sheltertech-go/internal/common"
	"github.com/sheltertechsf/sheltertech-go/internal/searchindex"
	"net/http"
	"sort"
)

// Rails touches the owning resource and indexes it and every child service after
// persisting the change. Keep these post-persistence side effects even with indexing disabled.
func (m *Manager) finishChangeRequest(ctx context.Context, w http.ResponseWriter, id int) bool {
	var resourceID int
	err := m.DbClient.DB.QueryRowContext(ctx, `UPDATE public.resources SET updated_at = NOW()
WHERE id = (SELECT resource_id FROM public.change_requests WHERE id = $1) RETURNING id`, id).Scan(&resourceID)
	if errors.Is(err, sql.ErrNoRows) {
		return true
	}
	if err == nil {
		err = searchindex.RebuildResourceAndServices(ctx, m.DbClient.DB, m.SearchIndex, resourceID)
	}
	if err != nil {
		common.WriteErrorJson(w, http.StatusInternalServerError, common.InternalServerErrorMessage)
		return false
	}
	return true
}

// JSON objects preserve insertion order in Rails; retain that order in the audit response.
func fieldOrder(raw json.RawMessage) map[string]int {
	var wrapper map[string]json.RawMessage
	if json.Unmarshal(raw, &wrapper) == nil {
		if nested, ok := wrapper["field_changes"]; ok {
			raw = nested
		}
	}
	result := map[string]int{}
	decoder := json.NewDecoder(bytes.NewReader(raw))
	token, err := decoder.Token()
	if err != nil || token != json.Delim('{') {
		return result
	}
	for decoder.More() {
		token, err := decoder.Token()
		if err != nil {
			break
		}
		name, ok := token.(string)
		if !ok {
			break
		}
		var value json.RawMessage
		if decoder.Decode(&value) != nil {
			break
		}
		result[name] = len(result)
	}
	return result
}
func orderFieldChanges(fields []FieldChange, raw json.RawMessage) {
	positions := fieldOrder(raw)
	sort.SliceStable(fields, func(i, j int) bool {
		a, aok := positions[fields[i].FieldName]
		b, bok := positions[fields[j].FieldName]
		if !aok {
			return false
		}
		if !bok {
			return true
		}
		return a < b
	})
}
