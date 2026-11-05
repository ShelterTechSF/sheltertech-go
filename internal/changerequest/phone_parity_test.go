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

func TestPhoneEditPreservesSubmittedAuditNumber(t *testing.T) {
	database, mock, err := sqlmock.New()
	require.NoError(t, err)
	defer database.Close()
	mock.ExpectBegin()
	mock.ExpectQuery("SELECT resource_id FROM public.phones").WithArgs(12).WillReturnRows(sqlmock.NewRows([]string{"resource_id"}).AddRow(34))
	mock.ExpectExec("UPDATE public.phones").WithArgs("+14155550101", 12).WillReturnResult(sqlmock.NewResult(0, 1))
	mock.ExpectQuery("INSERT INTO public.change_requests").WithArgs("PhoneChangeRequest", 12, db.StatusPending, db.ActionEdit, 34).WillReturnRows(sqlmock.NewRows([]string{"id"}).AddRow(99))
	mock.ExpectExec("INSERT INTO public.field_changes").WithArgs("number", "4155550101", 99).WillReturnResult(sqlmock.NewResult(0, 1))
	mock.ExpectCommit()
	expectParityFinalization(mock)
	router := chi.NewRouter()
	router.Post("/api/phones/{id}/change_requests", New(&db.Manager{DB: database}).UpdatePhone)
	w := httptest.NewRecorder()
	router.ServeHTTP(w, httptest.NewRequest("POST", "/api/phones/12/change_requests", strings.NewReader(`{"change_request":{"field_changes":{"number":"4155550101"}}}`)))
	require.Equal(t, 201, w.Code)
	require.Contains(t, w.Body.String(), `"field_value":"4155550101"`)
	require.NoError(t, mock.ExpectationsWereMet())
}
