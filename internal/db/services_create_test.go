package db

import (
	"regexp"
	"testing"
	"time"

	"github.com/DATA-DOG/go-sqlmock"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestCreateServicesForResourceCreatesApprovedServiceWithNestedData(t *testing.T) {
	sqlDB, mock, err := sqlmock.New()
	require.NoError(t, err)
	defer sqlDB.Close()

	now := time.Now()
	name := "Food pantry"
	longDescription := "Weekly groceries for families."
	email := "pantry@example.org"
	url := "https://example.org/pantry"
	note := "Bring ID."
	instruction := "Call before referring."
	opensAt := 900
	closesAt := 1700

	mock.ExpectBegin()
	mock.ExpectQuery(regexp.QuoteMeta(insertServiceSql)).
		WithArgs(
			nil,
			nil,
			nil,
			email,
			nil,
			nil,
			longDescription,
			name,
			nil,
			url,
			nil,
			7,
			ServiceStatusApproved,
		).
		WillReturnRows(sqlmock.NewRows([]string{"id"}).AddRow(123))
	mock.ExpectExec(regexp.QuoteMeta(insertCategoryServiceSql)).
		WithArgs(123, 41).
		WillReturnResult(sqlmock.NewResult(0, 1))
	mock.ExpectExec(regexp.QuoteMeta(insertEligibilityServiceSql)).
		WithArgs(123, 5).
		WillReturnResult(sqlmock.NewResult(0, 1))
	mock.ExpectExec(regexp.QuoteMeta(insertServiceNoteSql)).
		WithArgs(note, 123).
		WillReturnResult(sqlmock.NewResult(0, 1))
	mock.ExpectExec(regexp.QuoteMeta(insertServiceInstructionSql)).
		WithArgs(instruction, 123).
		WillReturnResult(sqlmock.NewResult(0, 1))
	mock.ExpectQuery(regexp.QuoteMeta(insertServiceScheduleSql)).
		WithArgs(123).
		WillReturnRows(sqlmock.NewRows([]string{"id"}).AddRow(88))
	mock.ExpectExec(regexp.QuoteMeta(insertServiceScheduleDaySql)).
		WithArgs("Monday", opensAt, closesAt, 88).
		WillReturnResult(sqlmock.NewResult(0, 1))
	mock.ExpectExec(regexp.QuoteMeta(touchResourceSql)).
		WithArgs(7).
		WillReturnResult(sqlmock.NewResult(0, 1))
	mock.ExpectCommit()
	mock.ExpectQuery(regexp.QuoteMeta(serviceByIDSql)).
		WithArgs(123).
		WillReturnRows(sqlmock.NewRows(serviceColumns()).AddRow(
			123,
			now,
			now,
			name,
			longDescription,
			nil,
			nil,
			nil,
			nil,
			7,
			nil,
			email,
			ServiceStatusApproved,
			false,
			nil,
			nil,
			url,
			nil,
			nil,
			nil,
			nil,
			nil,
			nil,
			0,
			nil,
			nil,
		))

	manager := &Manager{DB: sqlDB}
	createdServices, err := manager.CreateServicesForResource(7, []ServiceCreate{
		{
			Name:            &name,
			LongDescription: &longDescription,
			Email:           &email,
			Url:             &url,
			Categories:      []int{41},
			Eligibilities:   []int{5},
			Notes:           []ServiceNoteCreate{{Note: &note}},
			Instructions:    []ServiceInstructionCreate{{Instruction: &instruction}},
			Schedule: &ServiceScheduleCreate{
				ScheduleDays: []ServiceScheduleDayCreate{
					{
						Day:      "Monday",
						OpensAt:  &opensAt,
						ClosesAt: &closesAt,
					},
				},
			},
		},
	})

	require.NoError(t, err)
	require.Len(t, createdServices, 1)
	assert.Equal(t, 123, createdServices[0].Id)
	assert.Equal(t, name, createdServices[0].Name.String)
	assert.Equal(t, ServiceStatusApproved, int(createdServices[0].Status.Int32))
	assert.Equal(t, int32(7), createdServices[0].ResourceId.Int32)
	assert.NoError(t, mock.ExpectationsWereMet())
}

func serviceColumns() []string {
	return []string{
		"id",
		"created_at",
		"updated_at",
		"name",
		"long_description",
		"eligibility",
		"required_documents",
		"fee",
		"application_process",
		"resource_id",
		"verified_at",
		"email",
		"status",
		"certified",
		"program_id",
		"interpretation_services",
		"url",
		"wait_time",
		"contact_id",
		"funding_id",
		"alternate_name",
		"certified_at",
		"featured",
		"source_attribution",
		"internal_note",
		"short_description",
	}
}
