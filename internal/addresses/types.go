package addresses

import (
	"github.com/sheltertechsf/sheltertech-go/internal/db"
)

type Address struct {
	Id            int      `json:"id"`
	Attention     *string  `json:"attention"`
	Name          *string  `json:"name"`
	Address1      string   `json:"address_1"`
	Address2      *string  `json:"address_2"`
	Address3      *string  `json:"address_3"`
	Address4      *string  `json:"address_4"`
	City          string   `json:"city"`
	StateProvince string   `json:"state_province"`
	PostalCode    string   `json:"postal_code"`
	Latitude      *float64 `json:"latitude"`
	Longitude     *float64 `json:"longitude"`
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
		address.Latitude = &dbAddress.Latitude.Float64
	}
	if dbAddress.Longitude.Valid {
		address.Longitude = &dbAddress.Longitude.Float64
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
