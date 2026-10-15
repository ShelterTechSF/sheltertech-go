package services

import (
	"encoding/json"
	"errors"
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"
	"time"

	"github.com/DATA-DOG/go-sqlmock"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
	"github.com/stretchr/testify/require"
)

type noteIndex struct {
	record interface{}
	id     string
	err    error
}

func (i *noteIndex) SaveObject(id string, record interface{}) error {
	i.id, i.record = id, record
	return i.err
}
func (i *noteIndex) DeleteObject(id string) error { i.id = id; return i.err }

func TestCreateNoteReindexesAfterCommit(t *testing.T) {
	for _, scenario := range []struct {
		name, body                        string
		null, indexFailure, insertFailure bool
	}{
		{name: "text", body: `{"note":{"note":"new note"}}`},
		{name: "null", body: `{"note":{"note":null}}`, null: true},
		{name: "omitted text", body: `{"note":{}}`, null: true},
		{name: "index failure", body: `{"note":{"note":"new note"}}`, indexFailure: true},
		{name: "insert failure", body: `{"note":{"note":"new note"}}`, insertFailure: true},
	} {
		t.Run(scenario.name, func(t *testing.T) {
			database, mock, err := sqlmock.New()
			require.NoError(t, err)
			defer database.Close()
			mock.ExpectQuery("SELECT EXISTS").WithArgs(42).WillReturnRows(sqlmock.NewRows([]string{"exists"}).AddRow(true))
			mock.ExpectBegin()
			query := mock.ExpectQuery("INSERT INTO public.notes")
			var text interface{} = "new note"
			if scenario.null {
				text = nil
			}
			query.WithArgs(text, 42)
			now := time.Date(2026, 10, 14, 12, 34, 56, 123456000, time.UTC)
			if scenario.insertFailure {
				query.WillReturnError(errors.New("insert failed"))
				mock.ExpectRollback()
			} else {
				query.WillReturnRows(sqlmock.NewRows([]string{"id", "note", "resource_id", "service_id", "created_at", "updated_at"}).AddRow(123, text, nil, 42, now, now))
				// Any parent UPDATE, or index read before commit, fails this expectation.
				mock.ExpectCommit()
				source, _ := json.Marshal(map[string]interface{}{"service": map[string]interface{}{"id": 42, "status": 1}, "notes": []interface{}{"existing", text}})
				mock.ExpectQuery("SELECT json_build_object").WithArgs(42).WillReturnRows(sqlmock.NewRows([]string{"json"}).AddRow(source))
			}
			index := &noteIndex{}
			if scenario.indexFailure {
				index.err = errors.New("index unavailable")
			}
			manager := NewWithDependencies(&db.Manager{DB: database}, nil, nil, GoogleConfig{}, PDFCrowdConfig{}, index)
			request := requestWithServiceNoteID(httptest.NewRequest(http.MethodPost, "/api/services/42/notes", strings.NewReader(scenario.body)), "42")
			response := httptest.NewRecorder()
			manager.CreateNote(response, request)
			if scenario.insertFailure || scenario.indexFailure {
				require.Equal(t, http.StatusInternalServerError, response.Code)
			} else {
				require.Equal(t, http.StatusCreated, response.Code)
				var body map[string]interface{}
				require.NoError(t, json.Unmarshal(response.Body.Bytes(), &body))
				require.Equal(t, text, body["note"])
				require.Equal(t, "2026-10-14T12:34:56.123Z", body["created_at"])
				require.Equal(t, body["created_at"], body["updated_at"])
			}
			if scenario.insertFailure {
				require.Empty(t, index.id)
			} else {
				require.Equal(t, "service_42", index.id)
			}
			require.NoError(t, mock.ExpectationsWereMet())
		})
	}
}
