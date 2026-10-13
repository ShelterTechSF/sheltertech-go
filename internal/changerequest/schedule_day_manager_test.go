package changerequest

import (
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"regexp"
	"strings"
	"testing"

	"github.com/DATA-DOG/go-sqlmock"
	"github.com/go-chi/chi/v5"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

const selectScheduleDayResourceForChangeRequestTest = `
SELECT COALESCE(s.resource_id, sv.resource_id)
FROM public.schedule_days sd
JOIN public.schedules s ON s.id = sd.schedule_id
LEFT JOIN public.services sv ON sv.id = s.service_id
WHERE sd.id = $1
`

const selectScheduleResourceForChangeRequestTest = `
SELECT COALESCE(s.resource_id, sv.resource_id)
FROM public.schedules s
LEFT JOIN public.services sv ON sv.id = s.service_id
WHERE s.id = $1
`

const insertScheduleDayForChangeRequestTest = `
INSERT INTO public.schedule_days (schedule_id, day, opens_at, closes_at, created_at, updated_at)
VALUES ($1, $2, $3, $4, now(), now())
RETURNING id
`

const insertChangeRequestForScheduleDayTest = `
INSERT INTO public.change_requests (type, object_id, status, action, resource_id, created_at, updated_at)
VALUES ($1, $2, $3, $4, $5, now(), now())
RETURNING id`

const insertScheduleDayFieldChangeTest = `
INSERT INTO public.field_changes (field_name, field_value, change_request_id)
VALUES ($1, $2, $3)`

func TestManagerUpdateScheduleDayCreatesChangeRequestAndAppliesHours(t *testing.T) {
	sqlDB, mock, err := sqlmock.New()
	require.NoError(t, err)
	defer sqlDB.Close()

	mock.ExpectBegin()
	mock.ExpectQuery(regexp.QuoteMeta(selectScheduleDayResourceForChangeRequestTest)).
		WithArgs(12).
		WillReturnRows(sqlmock.NewRows([]string{"resource_id"}).AddRow(33))
	mock.ExpectExec(regexp.QuoteMeta("UPDATE public.schedule_days SET opens_at = $1, closes_at = $2, updated_at = now() WHERE id = $3")).
		WithArgs(900, 1700, 12).
		WillReturnResult(sqlmock.NewResult(0, 1))
	mock.ExpectQuery(regexp.QuoteMeta(insertChangeRequestForScheduleDayTest)).
		WithArgs("ScheduleDayChangeRequest", 12, db.StatusPending, db.ActionEdit, 33).
		WillReturnRows(sqlmock.NewRows([]string{"id"}).AddRow(44))
	mock.ExpectExec(regexp.QuoteMeta(insertScheduleDayFieldChangeTest)).
		WithArgs("opens_at", "900", 44).
		WillReturnResult(sqlmock.NewResult(0, 1))
	mock.ExpectExec(regexp.QuoteMeta(insertScheduleDayFieldChangeTest)).
		WithArgs("closes_at", "1700", 44).
		WillReturnResult(sqlmock.NewResult(0, 1))
	mock.ExpectCommit()

	manager := New(&db.Manager{DB: sqlDB})
	router := chi.NewRouter()
	router.Post("/api/schedule_days/{id}/change_requests", manager.UpdateScheduleDay)

	requestBody := strings.NewReader(`{"change_request":{"opens_at":900,"closes_at":1700}}`)
	req := httptest.NewRequest(http.MethodPost, "/api/schedule_days/12/change_requests", requestBody)
	w := httptest.NewRecorder()

	router.ServeHTTP(w, req)

	assert.Equal(t, http.StatusCreated, w.Code)
	assert.Equal(t, "application/json", w.Header().Get("Content-Type"))

	var response ScheduleDayChangeRequest
	require.NoError(t, json.Unmarshal(w.Body.Bytes(), &response))
	assert.Equal(t, ChangeRequestResponse{
		Id:       44,
		Status:   "pending",
		Type:     "ScheduleDayChangeRequest",
		ObjectID: 12,
		FieldChanges: []FieldChange{
			{FieldName: "opens_at", FieldValue: "900"},
			{FieldName: "closes_at", FieldValue: "1700"},
		},
	}, response.ScheduleDayChangeRequest)
	assert.NoError(t, mock.ExpectationsWereMet())
}

func TestManagerCreateScheduleDayChangeRequestInsertsScheduleDay(t *testing.T) {
	sqlDB, mock, err := sqlmock.New()
	require.NoError(t, err)
	defer sqlDB.Close()

	mock.ExpectBegin()
	mock.ExpectQuery(regexp.QuoteMeta(selectScheduleResourceForChangeRequestTest)).
		WithArgs(77).
		WillReturnRows(sqlmock.NewRows([]string{"resource_id"}).AddRow(55))
	mock.ExpectQuery(regexp.QuoteMeta(insertScheduleDayForChangeRequestTest)).
		WithArgs(77, "Tuesday", 1000, 1430).
		WillReturnRows(sqlmock.NewRows([]string{"id"}).AddRow(88))
	mock.ExpectQuery(regexp.QuoteMeta(insertChangeRequestForScheduleDayTest)).
		WithArgs("ScheduleDayChangeRequest", 88, db.StatusPending, db.ActionEdit, 55).
		WillReturnRows(sqlmock.NewRows([]string{"id"}).AddRow(99))
	mock.ExpectExec(regexp.QuoteMeta(insertScheduleDayFieldChangeTest)).
		WithArgs("day", "Tuesday", 99).
		WillReturnResult(sqlmock.NewResult(0, 1))
	mock.ExpectExec(regexp.QuoteMeta(insertScheduleDayFieldChangeTest)).
		WithArgs("opens_at", "1000", 99).
		WillReturnResult(sqlmock.NewResult(0, 1))
	mock.ExpectExec(regexp.QuoteMeta(insertScheduleDayFieldChangeTest)).
		WithArgs("closes_at", "1430", 99).
		WillReturnResult(sqlmock.NewResult(0, 1))
	mock.ExpectCommit()

	manager := New(&db.Manager{DB: sqlDB})
	router := chi.NewRouter()
	router.Post("/api/change_requests", manager.Create)

	requestBody := strings.NewReader(`{"change_request":{"day":"Tuesday","opens_at":1000,"closes_at":1430},"type":"schedule_days","schedule_id":77}`)
	req := httptest.NewRequest(http.MethodPost, "/api/change_requests", requestBody)
	w := httptest.NewRecorder()

	router.ServeHTTP(w, req)

	assert.Equal(t, http.StatusCreated, w.Code)
	assert.Equal(t, "application/json", w.Header().Get("Content-Type"))

	var response ScheduleDayChangeRequest
	require.NoError(t, json.Unmarshal(w.Body.Bytes(), &response))
	assert.Equal(t, ChangeRequestResponse{
		Id:       99,
		Status:   "pending",
		Type:     "ScheduleDayChangeRequest",
		ObjectID: 88,
		FieldChanges: []FieldChange{
			{FieldName: "day", FieldValue: "Tuesday"},
			{FieldName: "opens_at", FieldValue: "1000"},
			{FieldName: "closes_at", FieldValue: "1430"},
		},
	}, response.ScheduleDayChangeRequest)
	assert.NoError(t, mock.ExpectationsWereMet())
}
