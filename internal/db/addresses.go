package db

import (
	"database/sql"
	"errors"
	"fmt"
	"log"
	"strings"
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

var ErrAddressNotFound = errors.New("address not found")

var addressChangeRequestEditableColumns = []string{
	"attention",
	"name",
	"address_1",
	"address_2",
	"address_3",
	"address_4",
	"city",
	"state_province",
	"postal_code",
	"latitude",
	"longitude",
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

const addressResourceIDByIDSql = `
SELECT resource_id
FROM public.addresses
WHERE id = $1`

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

func (m *Manager) UpdateAddress(addressId int, fieldChanges map[string]interface{}) (*int, error) {
	tx, err := m.DB.Begin()
	if err != nil {
		return nil, err
	}
	defer tx.Rollback()

	resourceId, err := addressResourceIDForChangeRequest(tx, addressId)
	if err != nil {
		return nil, err
	}

	changeRequestId, err := insertAddressChangeRequest(tx, addressId, ActionEdit, resourceId)
	if err != nil {
		return nil, err
	}

	for _, fieldName := range addressChangeRequestEditableColumns {
		fieldValue, ok := fieldChanges[fieldName]
		if !ok {
			continue
		}
		_, err = tx.Exec(insertFieldChangeSql, fieldName, fieldValue, changeRequestId)
		if err != nil {
			return nil, err
		}
	}

	if len(fieldChanges) != 0 {
		updateAddressSql, args := buildAddressUpdateQuery(addressId, fieldChanges)
		_, err = tx.Exec(updateAddressSql, args...)
		if err != nil {
			return nil, err
		}
	}

	err = tx.Commit()
	if err != nil {
		return nil, err
	}

	return &changeRequestId, nil
}

func (m *Manager) RemoveAddress(addressId int) (*int, error) {
	tx, err := m.DB.Begin()
	if err != nil {
		return nil, err
	}
	defer tx.Rollback()

	resourceId, err := addressResourceIDForChangeRequest(tx, addressId)
	if err != nil {
		return nil, err
	}

	changeRequestId, err := insertAddressChangeRequest(tx, addressId, ActionRemove, resourceId)
	if err != nil {
		return nil, err
	}

	_, err = tx.Exec("DELETE FROM public.addresses_services WHERE address_id = $1", addressId)
	if err != nil {
		return nil, err
	}

	result, err := tx.Exec("DELETE FROM public.addresses WHERE id = $1", addressId)
	if err != nil {
		return nil, err
	}
	rowsAffected, err := result.RowsAffected()
	if err == nil && rowsAffected == 0 {
		return nil, ErrAddressNotFound
	}

	err = tx.Commit()
	if err != nil {
		return nil, err
	}

	return &changeRequestId, nil
}

func addressResourceIDForChangeRequest(tx *sql.Tx, addressId int) (sql.NullInt32, error) {
	row := tx.QueryRow(addressResourceIDByIDSql, addressId)

	var resourceId sql.NullInt32
	err := row.Scan(&resourceId)
	if err == sql.ErrNoRows {
		return sql.NullInt32{}, ErrAddressNotFound
	}
	if err != nil {
		return sql.NullInt32{}, err
	}

	return resourceId, nil
}

func insertAddressChangeRequest(tx *sql.Tx, addressId int, action int, resourceId sql.NullInt32) (int, error) {
	var changeRequestId int
	err := tx.QueryRow(
		insertChangeRequestSql,
		"AddressChangeRequest",
		addressId,
		StatusPending,
		action,
		addressResourceIDValue(resourceId),
	).Scan(&changeRequestId)
	if err != nil {
		return 0, err
	}

	return changeRequestId, nil
}

func addressResourceIDValue(resourceId sql.NullInt32) interface{} {
	if !resourceId.Valid {
		return nil
	}

	return int(resourceId.Int32)
}

func buildAddressUpdateQuery(addressId int, fieldChanges map[string]interface{}) (string, []interface{}) {
	setParts := []string{}
	args := []interface{}{}
	position := 1

	for _, fieldName := range addressChangeRequestEditableColumns {
		fieldValue, ok := fieldChanges[fieldName]
		if !ok {
			continue
		}
		setParts = append(setParts, fmt.Sprintf("%s=$%d", fieldName, position))
		args = append(args, fieldValue)
		position++
	}

	setParts = append(setParts, "updated_at=now()")
	args = append(args, addressId)

	return fmt.Sprintf(
		"UPDATE public.addresses SET %s WHERE id=$%d",
		strings.Join(setParts, ", "),
		position,
	), args
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
