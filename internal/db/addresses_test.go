package db

import (
	"regexp"
	"testing"

	"github.com/DATA-DOG/go-sqlmock"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestManagerInsertAddressCreatesPendingAddChangeRequest(t *testing.T) {
	sqlDB, mock, err := sqlmock.New()
	require.NoError(t, err)
	defer sqlDB.Close()
	mock.MatchExpectationsInOrder(false)

	fieldChanges := map[string]interface{}{
		"address_1":      "601 4th Street",
		"city":           "San Francisco",
		"state_province": "CA",
		"postal_code":    "49032",
		"resource_id":    1,
	}

	mock.ExpectBegin()
	mock.ExpectQuery(regexp.QuoteMeta("INSERT INTO public.addresses")).
		WithArgs(sqlmock.AnyArg(), sqlmock.AnyArg(), sqlmock.AnyArg(), sqlmock.AnyArg(), sqlmock.AnyArg()).
		WillReturnRows(sqlmock.NewRows([]string{"id"}).AddRow(42))
	mock.ExpectQuery(regexp.QuoteMeta(insertChangeRequestSql)).
		WithArgs("AddressChangeRequest", 42, StatusPending, ActionAdd, 1).
		WillReturnRows(sqlmock.NewRows([]string{"id"}).AddRow(77))
	mock.ExpectExec(regexp.QuoteMeta(insertFieldChangeSql)).
		WithArgs("address_1", "601 4th Street", 77).
		WillReturnResult(sqlmock.NewResult(1, 1))
	mock.ExpectExec(regexp.QuoteMeta(insertFieldChangeSql)).
		WithArgs("city", "San Francisco", 77).
		WillReturnResult(sqlmock.NewResult(1, 1))
	mock.ExpectExec(regexp.QuoteMeta(insertFieldChangeSql)).
		WithArgs("state_province", "CA", 77).
		WillReturnResult(sqlmock.NewResult(1, 1))
	mock.ExpectExec(regexp.QuoteMeta(insertFieldChangeSql)).
		WithArgs("postal_code", "49032", 77).
		WillReturnResult(sqlmock.NewResult(1, 1))
	mock.ExpectCommit()

	manager := &Manager{DB: sqlDB}
	addressId, changeRequestId, err := manager.InsertAddress(fieldChanges)

	require.NoError(t, err)
	assert.Equal(t, 42, *addressId)
	assert.Equal(t, 77, *changeRequestId)
	assert.NoError(t, mock.ExpectationsWereMet())
}
