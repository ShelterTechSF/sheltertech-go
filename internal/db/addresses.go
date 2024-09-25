package db

import (
	"database/sql"
	"fmt"
	"log"
	"time"
)

type Address struct {
	Id             int
	Attention      sql.NullString
	Address1       string
	Address2       sql.NullString
	Address3       sql.NullString
	Address4       sql.NullString
	City           string
	StateProvince  string
	PostalCode     string
	ResourceId     sql.NullInt32
	Latitude       sql.NullFloat64
	Longitude      sql.NullFloat64
	Online         sql.NullBool
	Region         sql.NullString
	Name           sql.NullString
	Description    sql.NullString
	Transportation sql.NullString
	CreatedAt      time.Time
	UpdatedAt      time.Time
}

const addressesByServiceIDSql = `
SELECT a.id, a.attention, a.address_1, a.address_2, a.address_3, a.address_4, a.city, a.state_province, a.postal_code, a.resource_id, a.latitude, a.longitude, a.online, a.region, a.name ,a.description , a.transportation
FROM public.addresses a
LEFT JOIN public.addresses_services ads on a.id = ads.address_id
WHERE ads.service_id = $1
ORDER BY a.id
`

const addressesByResourceIDSql = `
SELECT a.id, a.attention, a.address_1, a.address_2, a.address_3, a.address_4, a.city, a.state_province, a.postal_code, a.resource_id, a.latitude, a.longitude, a.online, a.region, a.name ,a.description , a.transportation
FROM public.addresses a
WHERE a.resource_id = $1
ORDER BY a.id
`

func (m *Manager) GetAddressesByServiceID(serviceId int) []*Address {
	var rows *sql.Rows
	var err error
	rows, err = m.DB.Query(addressesByServiceIDSql, serviceId)
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanAddresses(rows)
}

func (m *Manager) GetAddressesByResourceID(resourceId int) []*Address {
	var rows *sql.Rows
	var err error
	rows, err = m.DB.Query(addressesByResourceIDSql, resourceId)
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanAddresses(rows)
}

func scanAddresses(rows *sql.Rows) []*Address {
	var addresses []*Address
	for rows.Next() {
		var address Address
		err := rows.Scan(&address.Id, &address.Attention, &address.Address1, &address.Address2, &address.Address3, &address.Address4, &address.City, &address.StateProvince, &address.PostalCode, &address.ResourceId, &address.Latitude, &address.Longitude, &address.Online, &address.Region, &address.Name, &address.Description, &address.Transportation)
		switch err {
		case sql.ErrNoRows:
			fmt.Println("No rows were returned!")
			return nil
		}
		addresses = append(addresses, &address)
	}
	return addresses
}
