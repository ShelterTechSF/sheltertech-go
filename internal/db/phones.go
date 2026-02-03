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

func (m *Manager) DeletePhoneByID(id int) error {
	_, err := m.DB.Exec("DELETE FROM public.phones WHERE id = $1", id)
	return err
}

func (m *Manager) GetPhoneByID(id int) (*Phone, error) {
	row := m.DB.QueryRow("SELECT id, number, service_type, resource_id FROM public.phones WHERE id = $1", id)
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

func (m *Manager) UpdatePhone(id int, updates map[string]interface{}) error {
	allowed := []string{"number", "service_type", "description"}
	q, args := buildUpdateQuery("phones", "id", id, updates, allowed, true)
	if q == "" {
		return nil
	}
	_, err := m.DB.Exec(q, args...)
	return err
}

func (m *Manager) InsertPhone(resourceID int, number, serviceType string) (int, error) {
	var id int
	err := m.DB.QueryRow(`
INSERT INTO public.phones (number, service_type, resource_id, created_at, updated_at)
VALUES ($1, $2, $3, now(), now())
RETURNING id`, number, serviceType, resourceID).Scan(&id)
	return id, err
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
