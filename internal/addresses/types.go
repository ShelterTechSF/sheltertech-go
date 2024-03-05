package addresses

import (
	"github.com/sheltertechsf/sheltertech-go/internal/db"
)

type Address struct {
	Id             int `json:"id"`
	Attention      *string
	Address1       string
	Address2       *string
	Address3       *string
	Address4       *string
	City           string
	StateProvince  string
	PostalCode     string
	ResourceId     *int
	Latitude       *int
	Longitude      *int
	Online         *bool
	Region         *string
	Name           *string
	Description    *string
	Transportation *string
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
	if dbAddress.ResourceId.Valid {
		resourceId := int(dbAddress.ResourceId.Int32)
		address.ResourceId = &resourceId
	}
	if dbAddress.Latitude.Valid {
		latitude := int(dbAddress.Latitude.Int32)
		address.Latitude = &latitude
	}
	if dbAddress.Longitude.Valid {
		longitude := int(dbAddress.Longitude.Int32)
		address.Longitude = &longitude
	}
	if dbAddress.Online.Valid {
		online := dbAddress.Online.Bool
		address.Online = &online
	}
	if dbAddress.Region.Valid {
		address.Region = &dbAddress.Region.String
	}
	if dbAddress.Name.Valid {
		address.Name = &dbAddress.Name.String
	}
	if dbAddress.Description.Valid {
		address.Description = &dbAddress.Description.String
	}
	if dbAddress.Transportation.Valid {
		address.Transportation = &dbAddress.Transportation.String
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
