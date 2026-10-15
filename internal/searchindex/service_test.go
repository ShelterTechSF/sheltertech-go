package searchindex

import (
	"context"
	"encoding/json"
	"errors"
	"os"
	"testing"

	"github.com/DATA-DOG/go-sqlmock"
	"github.com/stretchr/testify/require"
)

type recordingIndex struct {
	savedID   string
	record    interface{}
	deletedID string
	err       error
}

func (i *recordingIndex) SaveObject(id string, record interface{}) error {
	i.savedID, i.record = id, record
	return i.err
}
func (i *recordingIndex) DeleteObject(id string) error { i.deletedID = id; return i.err }

func TestRebuildServiceMatchesRailsRecord(t *testing.T) {
	// Captured from the Rails model serializer, with synthetic fixture data.
	source, err := os.ReadFile("testdata/service_source.json")
	require.NoError(t, err)
	expected, err := os.ReadFile("testdata/service_rails.json")
	require.NoError(t, err)
	database, mock, err := sqlmock.New()
	require.NoError(t, err)
	defer database.Close()
	mock.ExpectQuery("SELECT json_build_object").WithArgs(1700000016).
		WillReturnRows(sqlmock.NewRows([]string{"json"}).AddRow(source))
	index := &recordingIndex{}
	require.NoError(t, RebuildService(context.Background(), database, index, 1700000016))
	require.Equal(t, "service_1700000016", index.savedID)
	actual, err := json.Marshal(index.record)
	require.NoError(t, err)
	require.JSONEq(t, string(expected), string(actual))
	require.NoError(t, mock.ExpectationsWereMet())
}

func TestRebuildServiceVisibilityAndErrors(t *testing.T) {
	for _, status := range []interface{}{0, 2, 3, nil} {
		database, mock, err := sqlmock.New()
		require.NoError(t, err)
		source, err := json.Marshal(map[string]interface{}{"service": map[string]interface{}{"status": status}})
		require.NoError(t, err)
		mock.ExpectQuery("SELECT json_build_object").WithArgs(42).
			WillReturnRows(sqlmock.NewRows([]string{"json"}).AddRow(source))
		index := &recordingIndex{}
		require.NoError(t, RebuildService(context.Background(), database, index, 42))
		require.Equal(t, "service_42", index.deletedID)
		require.Empty(t, index.savedID)
		require.NoError(t, mock.ExpectationsWereMet())
		database.Close()
	}
	database, mock, err := sqlmock.New()
	require.NoError(t, err)
	defer database.Close()
	index := &recordingIndex{}
	mock.ExpectQuery("SELECT json_build_object").WillReturnError(errors.New("database unavailable"))
	require.Error(t, RebuildService(context.Background(), database, index, 42))
	require.Empty(t, index.savedID)
	mock.ExpectQuery("SELECT json_build_object").WillReturnRows(sqlmock.NewRows([]string{"json"}).AddRow(`{"service":{"status":1}}`))
	index.err = errors.New("Algolia unavailable")
	require.ErrorIs(t, RebuildService(context.Background(), database, index, 42), index.err)
	require.NoError(t, mock.ExpectationsWereMet())
	require.NoError(t, RebuildService(context.Background(), nil, NoopIndexer{}, 42))
}

func TestServiceRecordFallbacks(t *testing.T) {
	var source serviceIndexSource
	require.NoError(t, json.Unmarshal([]byte(`{
		"service":{"status":1,"source_attribution":1,"created_at":"2026-10-13T12:34:56.123456","updated_at":null},
		"addresses":[{"latitude":37.7820802732529,"longitude":-122.395060956365},{}],
		"resource_addresses":[{"latitude":9,"longitude":10}],
		"schedule":{"days":[]},
		"resource_schedule":{"days":[{"day":"Tuesday","opens_at":815,"closes_at":915}]},
		"categories":["MOHCD Funded"],"notes":[],"instructions":[],"documents":[],"phones":[],"eligibilities":[],"associated_sites":[]
	}`), &source))
	r, err := source.record(42)
	require.NoError(t, err)
	require.Equal(t, "2026-10-13T12:34:56.123Z", r["created_at"])
	require.Equal(t, "service_net", r["source_attribution"])
	require.Equal(t, true, r["is_mohcd_funded"])
	require.Equal(t, true, r["use_resource_schedule"])
	require.Equal(t, []string{"Tu-8:00", "Tu-8:30", "Tu-9:00"}, r["open_times"])
	require.Empty(t, r["schedule"])
	geolocations, err := json.Marshal(r["_geoloc"])
	require.NoError(t, err)
	require.JSONEq(t, `[{"lat":37.7820802732529,"lng":-122.395060956365},null]`, string(geolocations))
	addresses := r["addresses"].([]map[string]interface{})
	require.Equal(t, float64(0), addresses[1]["latitude"])
	source.Addresses, source.ResourceAddresses = nil, nil
	source.Schedule, source.ResourceSchedule = nil, nil
	r, err = source.record(42)
	require.NoError(t, err)
	require.Nil(t, r["open_times"])
	require.Nil(t, r["schedule"])
	encoded, err := json.Marshal(r["addresses"])
	require.NoError(t, err)
	require.Equal(t, "null", string(encoded))
}

func TestOpenTimesRailsRounding(t *testing.T) {
	var schedule indexSchedule
	require.NoError(t, json.Unmarshal([]byte(`{"days":[
		{"day":"Monday","opens_at":2345,"closes_at":2400},
		{"day":"Tuesday","opens_at":2200,"closes_at":200},
		{"day":"Wednesday","opens_at":null,"closes_at":900},
		{"day":"Thursday","opens_at":0,"closes_at":0}
	]}`), &schedule))
	actual, err := schedule.openTimes()
	require.NoError(t, err)
	require.Equal(t, []string{"M-23:30"}, actual)
}
