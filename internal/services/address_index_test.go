package services

import (
	"errors"
	"github.com/DATA-DOG/go-sqlmock"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
	"github.com/stretchr/testify/require"
	"net/http/httptest"
	"testing"
)

func TestAddressAssociationRebuildsServiceAfterInsert(t *testing.T) {
	for _, failed := range []bool{false, true} {
		database, mock, err := sqlmock.New()
		require.NoError(t, err)
		mock.ExpectQuery("SELECT EXISTS").WithArgs(1).WillReturnRows(sqlmock.NewRows([]string{"exists"}).AddRow(true))
		mock.ExpectQuery("SELECT EXISTS").WithArgs(2).WillReturnRows(sqlmock.NewRows([]string{"exists"}).AddRow(true))
		mock.ExpectQuery("SELECT EXISTS").WithArgs(1, 2).WillReturnRows(sqlmock.NewRows([]string{"exists"}).AddRow(false))
		mock.ExpectExec("INSERT INTO public.addresses_services").WithArgs(1, 2).WillReturnResult(sqlmock.NewResult(0, 1))
		mock.ExpectQuery("SELECT json_build_object").WithArgs(1).WillReturnRows(sqlmock.NewRows([]string{"json"}).AddRow(`{"service":{"id":1,"status":1},"addresses":[{"address_1":"New address","latitude":37.7,"longitude":-122.4}]}`))
		index := &noteIndex{}
		if failed {
			index.err = errors.New("index unavailable")
		}
		manager := NewWithDependencies(&db.Manager{DB: database}, nil, nil, GoogleConfig{}, PDFCrowdConfig{}, index)
		w := httptest.NewRecorder()
		manager.AddAddress(w, newAddAddressRequest("1", "2"))
		if failed {
			require.Equal(t, 500, w.Code)
		} else {
			require.Equal(t, 201, w.Code)
			require.Contains(t, index.record.(map[string]interface{})["_geoloc"], map[string]float64{"lat": 37.7, "lng": -122.4})
		}
		require.Equal(t, "service_1", index.id)
		require.NoError(t, mock.ExpectationsWereMet())
		database.Close()
	}
}
