package changerequest

import (
	"encoding/json"
	"github.com/stretchr/testify/require"
	"testing"
)

func TestChangeRequestPreservesSubmittedFieldOrder(t *testing.T) {
	var payload ChangeRequestPayload
	require.NoError(t, json.Unmarshal([]byte(`{"change_request":{"closes_at":1700,"opens_at":900}}`), &payload))
	fields := []FieldChange{{FieldName: "opens_at"}, {FieldName: "closes_at"}}
	orderFieldChanges(fields, payload.ChangeRequest.rawJSON)
	require.Equal(t, "closes_at", fields[0].FieldName)
}
