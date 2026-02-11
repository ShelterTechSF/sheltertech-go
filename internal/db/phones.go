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

func (m *Manager) InsertPhone(fieldChanges map[string]interface{}) (*int, *int, error) {
	tx, err := m.DB.Begin()
	if err != nil {
		return nil, nil, err
	}
	defer tx.Rollback()

	allowed := []string{"number", "service_type", "resource_id"}
	insertPhoneSql, args := buildInsertQuery("phones", fieldChanges, allowed)
	var phoneId int

	err = tx.QueryRow(insertPhoneSql, args...).Scan(&phoneId)
	if err != nil {
		return nil, nil, err
	}

	var changeRequestId int
	err = tx.QueryRow(
		insertChangeRequestSql,
		"PhoneChangeRequest",
		phoneId,
		0, // StatusPending
		1, // ActionEdit
		fieldChanges["resource_id"],
	).Scan(&changeRequestId)

	for key, value := range fieldChanges {
		if key == "resource_id" {
			continue
		}
		_, err = tx.Exec(insertFieldChangeSql, key, value, changeRequestId)
		if err != nil {
			return nil, nil, err
		}
	}

	err = tx.Commit()

	if err != nil {
		return nil, nil, err
	}

	return &phoneId, &changeRequestId, nil
}

func (m *Manager) UpdatePhone(
	phoneId int,
	fieldChanges map[string]interface{},
) (*int, error) {
	tx, err := m.DB.Begin()
	if err != nil {
		return nil, err
	}
	defer tx.Rollback()

	// Need to get resource_id from db since its not included with request payload
	res := tx.QueryRow("SELECT resource_id FROM public.phones where id = $1", phoneId)
	var resourceId int
	err = res.Scan(&resourceId)

	if err != nil {
		return nil, err
	}

	// Only update the phones row if there are field changes
	if len(fieldChanges) != 0 {
		allowed := []string{"number", "service_type"}
		updatePhoneSql, args := buildUpdateQuery(
			"phones",
			"id",
			phoneId,
			fieldChanges,
			allowed,
		)

		_, err = tx.Exec(updatePhoneSql, args...)

		if err != nil {
			return nil, err
		}
	}

	// change_requests row is inserted even if there are no field changes
	var changeRequestId int
	err = tx.QueryRow(
		insertChangeRequestSql,
		"PhoneChangeRequest",
		phoneId,
		0, // StatusPending
		1, // ActionEdit
		resourceId,
	).Scan(&changeRequestId)

	// insert field_changes row for each field change
	for key, value := range fieldChanges {
		_, err = tx.Exec(insertFieldChangeSql, key, value, changeRequestId)
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

func (m *Manager) GetPhoneByID(id int) (*Phone, error) {
	row := m.DB.QueryRow("SELECT id, number, service_type FROM public.phones WHERE id = $1", id)
	var phone Phone
	err := row.Scan(&phone.Id, &phone.Number, &phone.ServiceType)
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
