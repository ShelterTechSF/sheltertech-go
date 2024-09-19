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
}

const phonesByResourceIDSql = `
SELECT p.id, p.number, p.service_type
FROM public.phones p
WHERE p.resource_id = $1
`

func (m *Manager) GetPhonesByResourceID(resourceId int) []*Phone {
	var rows *sql.Rows
	var err error
	rows, err = m.DB.Query(phonesByResourceIDSql, resourceId)
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanPhones(rows)
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
