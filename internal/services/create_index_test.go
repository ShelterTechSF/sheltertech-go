package services

import (
	"context"
	"encoding/json"
	"errors"
	"github.com/DATA-DOG/go-sqlmock"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
	"github.com/stretchr/testify/require"
	"testing"
)

func TestCreatedServicePresenterOmitsShowOnlyFields(t *testing.T) {
	raw, err := json.Marshal(&CreatedServiceResponse{Service: &CreatedService{Service: &Service{Id: 42}}})
	require.NoError(t, err)
	var response map[string]map[string]interface{}
	require.NoError(t, json.Unmarshal(raw, &response))
	require.NotContains(t, response["service"], "resource")
	require.NotContains(t, response["service"], "program")
	var request ServiceCreateRequest
	require.NoError(t, json.Unmarshal([]byte(`{"instructions":[{"instruction":"ignored"}]}`), &request))
	require.Empty(t, request.ToDBType().Instructions)
}
func TestCreatedServicesPublishResourceAndNewServices(t *testing.T) {
	for _, failed := range []bool{false, true} {
		database, mock, err := sqlmock.New()
		require.NoError(t, err)
		mock.ExpectQuery("SELECT json_build_object").WithArgs(1).WillReturnRows(sqlmock.NewRows([]string{"json"}).AddRow(`{"resource":{"id":1,"status":1},"services":[{"name":"New"}]}`))
		if !failed {
			mock.ExpectQuery("SELECT json_build_object").WithArgs(2).WillReturnRows(sqlmock.NewRows([]string{"json"}).AddRow(`{"service":{"id":2,"status":1,"name":"New"}}`))
		}
		index := &noteIndex{}
		if failed {
			index.err = errors.New("index unavailable")
		}
		manager := NewWithDependencies(&db.Manager{DB: database}, nil, nil, GoogleConfig{}, PDFCrowdConfig{}, index)
		err = manager.reindexCreatedServices(context.Background(), 1, []*db.Service{{Id: 2}})
		if failed {
			require.Error(t, err)
			require.Equal(t, "resource_1", index.id)
		} else {
			require.NoError(t, err)
			require.Equal(t, "service_2", index.id)
			require.Equal(t, "New", index.record.(map[string]interface{})["name"])
		}
		require.NoError(t, mock.ExpectationsWereMet())
		database.Close()
	}
}
