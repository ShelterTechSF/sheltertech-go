package changerequest

import (
	"github.com/DATA-DOG/go-sqlmock"
	"github.com/go-chi/chi/v5"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
	"github.com/stretchr/testify/require"
	"net/http/httptest"
	"strings"
	"testing"
)

func TestNoteEditFinalizesResourceAfterCommit(t *testing.T) {
	database, mock, err := sqlmock.New()
	require.NoError(t, err)
	defer database.Close()
	mock.ExpectBegin()
	mock.ExpectQuery("SELECT resource_id, service_id").WithArgs(14).WillReturnRows(sqlmock.NewRows([]string{"resource_id", "service_id"}).AddRow(34, nil))
	mock.ExpectQuery("INSERT INTO public.change_requests").WithArgs("NoteChangeRequest", 14, db.StatusPending, db.ActionEdit, 34).WillReturnRows(sqlmock.NewRows([]string{"id"}).AddRow(99))
	mock.ExpectExec("INSERT INTO public.field_changes").WithArgs("note", "Updated", 99).WillReturnResult(sqlmock.NewResult(0, 1))
	mock.ExpectExec("UPDATE public.notes").WithArgs("Updated", 14).WillReturnResult(sqlmock.NewResult(0, 1))
	mock.ExpectExec("UPDATE public.resources").WithArgs(34).WillReturnResult(sqlmock.NewResult(0, 1))
	mock.ExpectCommit()
	expectParityFinalization(mock)
	router := chi.NewRouter()
	router.Post("/api/notes/{id}/change_requests", New(&db.Manager{DB: database}).UpdateNote)
	w := httptest.NewRecorder()
	router.ServeHTTP(w, httptest.NewRequest("POST", "/api/notes/14/change_requests", strings.NewReader(`{"change_request":{"note":"Updated"}}`)))
	require.Equal(t, 201, w.Code)
	require.JSONEq(t, `{"note_change_request":{"id":99,"status":"pending","type":"NoteChangeRequest","object_id":14,"field_changes":[{"field_name":"note","field_value":"Updated"}]}}`, w.Body.String())
	require.NoError(t, mock.ExpectationsWereMet())
}
