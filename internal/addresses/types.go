package addresses

import (
	"github.com/sheltertechsf/sheltertech-go/internal/db"
)

type Address struct {
	Id             int     `json:"id"`
	Attention      *string `json:"attention"`
	Address1       string  `json:"address_1"`
	Address2       *string `json:"address_2"`
	Address3       *string `json:"address_3"`
	Address4       *string `json:"address_4"`
	City           string  `json:"city"`
	StateProvince  string  `json:"state_province"`
	PostalCode     string  `json:"postal_code"`
	ResourceId     *int    `json:"resource_id"`
	Latitude       *int    `json:"latitude"`
	Longitude      *int    `json:"longitude"`
	Online         *bool   `json:"online"`
	Region         *string `json:"region"`
	Name           *string `json:"name"`
	Description    *string `json:"description"`
	Transportation *string `json:"transportation"`
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
