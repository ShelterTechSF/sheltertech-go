package db

import (
	"database/sql"
	"fmt"
	"log"
)

type Phone struct {
	Id          int
	Number      string
	ServiceType string
	ResourceId  int
}

const phonesByResourceIDSql = `
SELECT p.id, p.number, p.service_type
FROM public.phones p
WHERE p.resource_id = $1`

const phoneByIDSql = `
SELECT id, number, service_type, resource_id
FROM public.phones
WHERE id = $1`

const updatePhoneSql = `
UPDATE public.phones SET number = $1, service_type = $2
WHERE id = $3`

func (m *Manager) GetPhonesByResourceID(resourceId int) []*Phone {
	var rows *sql.Rows
	var err error
	rows, err = m.DB.Query(phonesByResourceIDSql, resourceId)
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanPhones(rows)
}

func (m *Manager) DeletePhoneByID(id int) error {
	_, err := m.DB.Exec("DELETE FROM public.phones WHERE id = $1", id)
	return err
}

func (m *Manager) UpdatePhone(phone *Phone) error {
	_, err := m.DB.Exec(
		updatePhoneSql,
		phone.Number,
		phone.ServiceType,
		phone.Id,
	)

	return err
}

func (m *Manager) GetPhoneByID(id int) (*Phone, error) {
	row := m.DB.QueryRow(phoneByIDSql, id)
	var phone Phone
	err := row.Scan(&phone.Id, &phone.Number, &phone.ServiceType, &phone.ResourceId)
	if err == sql.ErrNoRows {
		return nil, nil
	}
	if err != nil {
		return nil, err
	}
	return &phone, nil
}

func scanPhones(rows *sql.Rows) []*Phone {
	var phones []*Phone
	for rows.Next() {
		var phone Phone
		err := rows.Scan(&phone.Id, &phone.Number, &phone.ServiceType)
		switch err {
		case sql.ErrNoRows:
			fmt.Println("No rows were returned!")
			return nil
		}
		phones = append(phones, &phone)
	}
	return phones
}
