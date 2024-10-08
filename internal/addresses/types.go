package addresses

import (
	"fmt"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
	"strings"
)

type Address struct {
	Id            int     `json:"id"`
	Attention     *string `json:"attention"`
	Name          *string `json:"name"`
	Address1      string  `json:"address_1"`
	Address2      *string `json:"address_2"`
	Address3      *string `json:"address_3"`
	Address4      *string `json:"address_4"`
	City          string  `json:"city"`
	StateProvince string  `json:"state_province"`
	PostalCode    string  `json:"postal_code"`
	Latitude      *string `json:"latitude"`
	Longitude     *string `json:"longitude"`
}

func FromAddressDBType(dbAddress *db.Address) *Address {
	address := &Address{
		Id:            dbAddress.Id,
		Address1:      dbAddress.Address1,
		City:          dbAddress.City,
		StateProvince: dbAddress.StateProvince,
		PostalCode:    dbAddress.PostalCode,
	}
	if dbAddress.Attention.Valid {
		address.Attention = &dbAddress.Attention.String
	}
	if dbAddress.Address2.Valid {
		address.Address2 = &dbAddress.Address2.String
	}
	if dbAddress.Address3.Valid {
		address.Address3 = &dbAddress.Address3.String
	}
	if dbAddress.Address4.Valid {
		address.Address4 = &dbAddress.Address4.String
	}
	if dbAddress.Latitude.Valid {
		// This probably isn't the cleanest way to remove trailing zeros
		latitude := fmt.Sprintf("%.7f", dbAddress.Latitude.Float64)
		latitude = strings.TrimRight(strings.TrimRight(latitude, "0"), ".")
		address.Latitude = &latitude
	}
	if dbAddress.Longitude.Valid {
		// This probably isn't the cleanest way to remove trailing zeros
		longitude := fmt.Sprintf("%.7f", dbAddress.Longitude.Float64)
		longitude = strings.TrimRight(strings.TrimRight(longitude, "0"), ".")
		address.Longitude = &longitude
	}
	if dbAddress.Name.Valid {
		address.Name = &dbAddress.Name.String
	}
	return address
}

func FromAddressesDBTypeArray(dbAddresses []*db.Address) []*Address {
	addresses := []*Address{}
	for _, dbAddress := range dbAddresses {
		addresses = append(addresses, FromAddressDBType(dbAddress))
	}
	return addresses
}
