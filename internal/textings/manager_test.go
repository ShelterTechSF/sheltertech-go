package textings

import (
	"database/sql"
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"regexp"
	"strings"
	"testing"
	"time"

	"github.com/DATA-DOG/go-sqlmock"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

const (
	resourceByIDQuery = `
SELECT id, name, short_description, long_description, website, verified_at, email, status, certified, alternate_name, legal_status, contact_id, funding_id, certified_at, featured, source_attribution, internal_note, updated_at
FROM public.resources
WHERE id = $1
`

	categoriesByResourceIDQuery = `
SELECT c.id, c.name, c.top_level, c.featured 
FROM public.categories c
LEFT JOIN public.categories_resources cs on c.id = cs.category_id
WHERE cs.resource_id = $1
ORDER BY c.id
`

	phonesByResourceIDQuery = `
SELECT p.id, p.number, p.service_type
FROM public.phones p
WHERE p.resource_id = $1`

	addressesByResourceIDQuery = `
SELECT a.id, a.attention, a.address_1, a.address_2, a.address_3, a.address_4, a.city, a.state_province, a.postal_code, a.resource_id, a.latitude, a.longitude, a.online, a.region, a.name ,a.description , a.transportation
FROM public.addresses a
WHERE a.resource_id = $1
ORDER BY a.id
`

	textingRecipientByPhoneNumberQuery = `
SELECT id, recipient_name, phone_number
FROM public.texting_recipients
WHERE phone_number = $1
`

	createTextingRecipientQuery = `
INSERT INTO public.texting_recipients (recipient_name, phone_number, created_at, updated_at)
VALUES ($1, $2, NOW(), NOW())
RETURNING id
`

	createTextingQuery = `
INSERT INTO public.textings (texting_recipient_id, service_id, resource_id, created_at, updated_at)
VALUES ($1, $2, $3, NOW(), NOW())
`
)

type fakeTextSender struct {
	err     error
	payload map[string]interface{}
}

func (f *fakeTextSender) Send(data map[string]interface{}) error {
	f.payload = data
	return f.err
}

func TestManager_CreateResourceTexting(t *testing.T) {
	sqlDB, mock, err := sqlmock.New()
	require.NoError(t, err)
	defer sqlDB.Close()

	resourceID := 123
	mockResourceQueries(mock, resourceID)
	mock.ExpectBegin()
	mock.ExpectQuery(regexp.QuoteMeta(textingRecipientByPhoneNumberQuery)).
		WithArgs("4155551212").
		WillReturnError(sql.ErrNoRows)
	mock.ExpectQuery(regexp.QuoteMeta(createTextingRecipientQuery)).
		WithArgs("Joe", "4155551212").
		WillReturnRows(sqlmock.NewRows([]string{"id"}).AddRow(9))
	mock.ExpectExec(regexp.QuoteMeta(createTextingQuery)).
		WithArgs(9, nil, resourceID).
		WillReturnResult(sqlmock.NewResult(1, 1))
	mock.ExpectCommit()

	sender := &fakeTextSender{}
	manager := NewWithDependencies(&db.Manager{DB: sqlDB}, sender)
	req := httptest.NewRequest(http.MethodPost, "/api/textings", strings.NewReader(`{"data":{"recipient_name":"Joe","phone_number":"(415) 555-1212","resource_id":123}}`))
	w := httptest.NewRecorder()

	manager.Create(w, req)

	assert.Equal(t, http.StatusOK, w.Code)
	assert.Equal(t, `{"message":"success"}`, w.Body.String())
	assert.Equal(t, "4155551212", sender.payload["mobilePhone"])
	assert.Equal(t, []string{"Shelter"}, sender.payload["tags"])
	engagementInfo := sender.payload["engagementInfo"].(map[string]string)
	assert.Equal(t, "Mission Resource", engagementInfo["Org_Name"])
	assert.Equal(t, "123 Main St", engagementInfo["Org_Address1"])
	assert.Equal(t, "San Francisco", engagementInfo["City"])
	assert.Equal(t, "415-555-9999", engagementInfo["Org_Phone"])
	assert.NoError(t, mock.ExpectationsWereMet())
}

func TestManager_CreateReturnsBadRequestWhenTextellentFails(t *testing.T) {
	sqlDB, mock, err := sqlmock.New()
	require.NoError(t, err)
	defer sqlDB.Close()

	mockResourceQueries(mock, 123)

	manager := NewWithDependencies(&db.Manager{DB: sqlDB}, &fakeTextSender{err: ErrTextellentFailure})
	req := httptest.NewRequest(http.MethodPost, "/api/textings", strings.NewReader(`{"data":{"recipient_name":"Joe","phone_number":"415-555-1212","resource_id":123}}`))
	w := httptest.NewRecorder()

	manager.Create(w, req)

	assert.Equal(t, http.StatusBadRequest, w.Code)
	assert.Equal(t, `{"error":"failure","status_code":400}`, w.Body.String())
	assert.NoError(t, mock.ExpectationsWereMet())
}

func TestManager_CreateRejectsInvalidTarget(t *testing.T) {
	manager := NewWithDependencies(&db.Manager{}, &fakeTextSender{})
	req := httptest.NewRequest(http.MethodPost, "/api/textings", strings.NewReader(`{"data":{"recipient_name":"Joe","phone_number":"415-555-1212"}}`))
	w := httptest.NewRecorder()

	manager.Create(w, req)

	assert.Equal(t, http.StatusBadRequest, w.Code)
	assert.Equal(t, `{"error":"Exactly one of service_id or resource_id is required","status_code":400}`, w.Body.String())
}

func TestTextellentSender_Send(t *testing.T) {
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		assert.Equal(t, http.MethodPost, r.Method)
		assert.Equal(t, "application/json", r.Header.Get("Content-Type"))
		assert.Equal(t, "secret-key", r.Header.Get("authCode"))

		var payload map[string]interface{}
		require.NoError(t, json.NewDecoder(r.Body).Decode(&payload))
		assert.Equal(t, "4155551212", payload["mobilePhone"])

		w.WriteHeader(http.StatusOK)
		_, err := w.Write([]byte(`{"status":"success"}`))
		require.NoError(t, err)
	}))
	defer server.Close()

	sender := NewTextellentSender(server.URL, "secret-key", server.Client())

	err := sender.Send(map[string]interface{}{"mobilePhone": "4155551212"})

	assert.NoError(t, err)
}

func TestTextellentSender_SendReturnsFailureForNonSuccessResponse(t *testing.T) {
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		w.WriteHeader(http.StatusOK)
		_, err := w.Write([]byte(`{"status":"failed"}`))
		require.NoError(t, err)
	}))
	defer server.Close()

	sender := NewTextellentSender(server.URL, "secret-key", server.Client())

	err := sender.Send(map[string]interface{}{"mobilePhone": "4155551212"})

	assert.ErrorIs(t, err, ErrTextellentFailure)
}

func TestParsePhoneNumber(t *testing.T) {
	phoneNumber, err := parsePhoneNumber("(415) 555-1212")

	assert.NoError(t, err)
	assert.Equal(t, "4155551212", phoneNumber)

	_, err = parsePhoneNumber("not a phone number")
	assert.Error(t, err)
}

func mockResourceQueries(mock sqlmock.Sqlmock, resourceID int) {
	updatedAt := time.Date(2026, 8, 13, 12, 0, 0, 0, time.UTC)
	mock.ExpectQuery(regexp.QuoteMeta(resourceByIDQuery)).
		WithArgs(resourceID).
		WillReturnRows(sqlmock.NewRows([]string{
			"id", "name", "short_description", "long_description", "website", "verified_at", "email", "status", "certified", "alternate_name", "legal_status", "contact_id", "funding_id", "certified_at", "featured", "source_attribution", "internal_note", "updated_at",
		}).AddRow(resourceID, "Mission Resource", nil, nil, nil, nil, nil, "approved", true, nil, nil, nil, nil, nil, false, nil, nil, updatedAt))
	mock.ExpectQuery(regexp.QuoteMeta(categoriesByResourceIDQuery)).
		WithArgs(resourceID).
		WillReturnRows(sqlmock.NewRows([]string{"id", "name", "top_level", "featured"}).
			AddRow(1, "Shelter", true, false))
	mock.ExpectQuery(regexp.QuoteMeta(phonesByResourceIDQuery)).
		WithArgs(resourceID).
		WillReturnRows(sqlmock.NewRows([]string{"id", "number", "service_type"}).
			AddRow(55, "415-555-9999", "Main"))
	mock.ExpectQuery(regexp.QuoteMeta(addressesByResourceIDQuery)).
		WithArgs(resourceID).
		WillReturnRows(sqlmock.NewRows([]string{
			"id", "attention", "address_1", "address_2", "address_3", "address_4", "city", "state_province", "postal_code", "resource_id", "latitude", "longitude", "online", "region", "name", "description", "transportation",
		}).AddRow(77, nil, "123 Main St", "Suite 4", nil, nil, "San Francisco", "CA", "94103", resourceID, 37.77, -122.42, false, nil, nil, nil, nil))
}
