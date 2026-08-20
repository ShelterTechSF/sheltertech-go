package db

import (
	"database/sql"
	"errors"
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

var ErrServiceAddressMissing = errors.New("service or address missing")

const addressExistsSql = `
SELECT EXISTS (
SELECT 1
FROM public.addresses
WHERE id = $1
)
`

const serviceAddressExistsSql = `
SELECT EXISTS (
SELECT 1
FROM public.addresses_services
WHERE service_id = $1
AND address_id = $2
)
`

const createServiceAddressSql = `
INSERT INTO public.addresses_services (service_id, address_id)
VALUES ($1, $2)
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

func (m *Manager) AddressExists(addressId int) (bool, error) {
	row := m.DB.QueryRow(addressExistsSql, addressId)
	var exists bool
	err := row.Scan(&exists)
	return exists, err
}

func (m *Manager) AddAddressToService(serviceId, addressId int) (bool, error) {
	serviceExists, err := m.ServiceExists(serviceId)
	if err != nil {
		return false, err
	}
	if !serviceExists {
		return false, ErrServiceAddressMissing
	}

	addressExists, err := m.AddressExists(addressId)
	if err != nil {
		return false, err
	}
	if !addressExists {
		return false, ErrServiceAddressMissing
	}

	associationExists, err := m.serviceAddressExists(serviceId, addressId)
	if err != nil {
		return false, err
	}
	if associationExists {
		return false, nil
	}

	_, err = m.DB.Exec(createServiceAddressSql, serviceId, addressId)
	return true, err
}

func (m *Manager) serviceAddressExists(serviceId, addressId int) (bool, error) {
	row := m.DB.QueryRow(serviceAddressExistsSql, serviceId, addressId)
	var exists bool
	err := row.Scan(&exists)
	return exists, err
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
