package addresses

import "github.com/sheltertechsf/sheltertech-go/internal/db"

type Address struct {
	Id int `json:"id"`
}

func FromAddressDBType(dbAddress *db.Address) *Address {
	address := &Address{
		Id: dbAddress.Id,
	}
	return address
}

func FromAddressesDBTypeArray(dbAddresses []*db.Address) []*Address {
	var addresses []*Address
	for _, dbAddress := range dbAddresses {
		addresses = append(addresses, FromAddressDBType(dbAddress))
	}
	return addresses
}
