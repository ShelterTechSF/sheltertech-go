package addresses

import (
	"database/sql"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
	"github.com/stretchr/testify/require"
	"testing"
)

func TestAddressCoordinatesRetainRailsPrecision(t *testing.T) {
	address := FromAddressDBType(&db.Address{Latitude: sql.NullFloat64{Float64: 37.7820802732529, Valid: true}, Longitude: sql.NullFloat64{Float64: -122.395060956365, Valid: true}})
	require.Equal(t, "37.7820802732529", *address.Latitude)
	require.Equal(t, "-122.395060956365", *address.Longitude)
	empty := FromAddressDBType(&db.Address{})
	require.Nil(t, empty.Latitude)
	require.Nil(t, empty.Longitude)
	zero := FromAddressDBType(&db.Address{Latitude: sql.NullFloat64{Valid: true}})
	require.Equal(t, "0", *zero.Latitude)
}
