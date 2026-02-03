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

const addressByIDSql = `
SELECT a.id, a.attention, a.address_1, a.address_2, a.address_3, a.address_4, a.city, a.state_province, a.postal_code, a.resource_id, a.latitude, a.longitude, a.online, a.region, a.name, a.description, a.transportation
FROM public.addresses a
WHERE a.id = $1
`

func (m *Manager) GetAddressByID(id int) (*Address, error) {
	row := m.DB.QueryRow(addressByIDSql, id)
	var addr Address
	err := row.Scan(&addr.Id, &addr.Attention, &addr.Address1, &addr.Address2, &addr.Address3, &addr.Address4, &addr.City, &addr.StateProvince, &addr.PostalCode, &addr.ResourceId, &addr.Latitude, &addr.Longitude, &addr.Online, &addr.Region, &addr.Name, &addr.Description, &addr.Transportation)
	if err == sql.ErrNoRows {
		return nil, nil
	}
	if err != nil {
		return nil, err
	}
	return &addr, nil
}

var addressUpdateAllowed = []string{"attention", "address_1", "address_2", "address_3", "address_4", "city", "state_province", "postal_code", "latitude", "longitude", "online", "region", "name", "description", "transportation"}

func (m *Manager) UpdateAddress(id int, updates map[string]interface{}) error {
	q, args := buildUpdateQuery("addresses", "id", id, updates, addressUpdateAllowed, true)
	if q == "" {
		return nil
	}
	_, err := m.DB.Exec(q, args...)
	return err
}

func (m *Manager) DeleteAddress(id int) error {
	_, err := m.DB.Exec("DELETE FROM public.addresses WHERE id = $1", id)
	return err
}

func (m *Manager) InsertAddress(addr *Address) (int, error) {
	var id int
	err := m.DB.QueryRow(`
INSERT INTO public.addresses (attention, address_1, address_2, address_3, address_4, city, state_province, postal_code, resource_id, latitude, longitude, online, region, name, description, transportation, created_at, updated_at)
VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, now(), now())
RETURNING id`,
		addr.Attention, addr.Address1, addr.Address2, addr.Address3, addr.Address4, addr.City, addr.StateProvince, addr.PostalCode, addr.ResourceId, addr.Latitude, addr.Longitude, addr.Online, addr.Region, addr.Name, addr.Description, addr.Transportation).Scan(&id)
	return id, err
}

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
