package db

import (
	"database/sql"
	"errors"
	"regexp"
	"testing"

	"github.com/DATA-DOG/go-sqlmock"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestUpdateNoteCreatesChangeRequestWithNoteResourceID(t *testing.T) {
	sqlDB, mock, err := sqlmock.New()
	require.NoError(t, err)
	defer sqlDB.Close()

	mock.ExpectBegin()
	mock.ExpectQuery(regexp.QuoteMeta(noteForChangeRequestSql)).
		WithArgs(14).
		WillReturnRows(sqlmock.NewRows([]string{"resource_id", "service_id"}).AddRow(22, nil))
	mock.ExpectQuery(regexp.QuoteMeta(insertChangeRequestSql)).
		WithArgs("NoteChangeRequest", 14, StatusPending, ActionEdit, 22).
		WillReturnRows(sqlmock.NewRows([]string{"id"}).AddRow(61))
	mock.ExpectExec(regexp.QuoteMeta(insertFieldChangeSql)).
		WithArgs("note", "Updated note text", 61).
		WillReturnResult(sqlmock.NewResult(1, 1))
	mock.ExpectExec(regexp.QuoteMeta(updateNoteForChangeRequestSql)).
		WithArgs("Updated note text", 14).
		WillReturnResult(sqlmock.NewResult(1, 1))
	mock.ExpectExec(regexp.QuoteMeta(touchResourceForNoteChangeRequestSql)).
		WithArgs(22).
		WillReturnResult(sqlmock.NewResult(1, 1))
	mock.ExpectCommit()

	manager := &Manager{DB: sqlDB}
	changeRequestId, err := manager.UpdateNote(14, "Updated note text")

	require.NoError(t, err)
	require.NotNil(t, changeRequestId)
	assert.Equal(t, 61, *changeRequestId)
	assert.NoError(t, mock.ExpectationsWereMet())
}

func TestUpdateNoteCreatesChangeRequestWithServiceResourceID(t *testing.T) {
	sqlDB, mock, err := sqlmock.New()
	require.NoError(t, err)
	defer sqlDB.Close()

	mock.ExpectBegin()
	mock.ExpectQuery(regexp.QuoteMeta(noteForChangeRequestSql)).
		WithArgs(15).
		WillReturnRows(sqlmock.NewRows([]string{"resource_id", "service_id"}).AddRow(nil, 7))
	mock.ExpectQuery(regexp.QuoteMeta(serviceResourceIDForNoteChangeRequestSql)).
		WithArgs(7).
		WillReturnRows(sqlmock.NewRows([]string{"resource_id"}).AddRow(33))
	mock.ExpectQuery(regexp.QuoteMeta(insertChangeRequestSql)).
		WithArgs("NoteChangeRequest", 15, StatusPending, ActionEdit, 33).
		WillReturnRows(sqlmock.NewRows([]string{"id"}).AddRow(62))
	mock.ExpectExec(regexp.QuoteMeta(insertFieldChangeSql)).
		WithArgs("note", "Service note text", 62).
		WillReturnResult(sqlmock.NewResult(1, 1))
	mock.ExpectExec(regexp.QuoteMeta(updateNoteForChangeRequestSql)).
		WithArgs("Service note text", 15).
		WillReturnResult(sqlmock.NewResult(1, 1))
	mock.ExpectExec(regexp.QuoteMeta(touchResourceForNoteChangeRequestSql)).
		WithArgs(33).
		WillReturnResult(sqlmock.NewResult(1, 1))
	mock.ExpectCommit()

	manager := &Manager{DB: sqlDB}
	changeRequestId, err := manager.UpdateNote(15, "Service note text")

	require.NoError(t, err)
	require.NotNil(t, changeRequestId)
	assert.Equal(t, 62, *changeRequestId)
	assert.NoError(t, mock.ExpectationsWereMet())
}

func TestUpdateNoteDoesNotUpdateWhenNoteIsMissing(t *testing.T) {
	sqlDB, mock, err := sqlmock.New()
	require.NoError(t, err)
	defer sqlDB.Close()

	mock.ExpectBegin()
	mock.ExpectQuery(regexp.QuoteMeta(noteForChangeRequestSql)).
		WithArgs(404).
		WillReturnRows(sqlmock.NewRows([]string{"resource_id", "service_id"}))
	mock.ExpectRollback()

	manager := &Manager{DB: sqlDB}
	changeRequestId, err := manager.UpdateNote(404, "Should not update")

	assert.Nil(t, changeRequestId)
	assert.True(t, errors.Is(err, sql.ErrNoRows))
	assert.NoError(t, mock.ExpectationsWereMet())
}
