package db

import (
	"database/sql"
	"fmt"
	"log"
)

type User struct {
	Id             int
	Name           string
	Organization   string
	UserExternalId string
	Email          string
}

const userByUserExternalIDSql = `
SELECT u.id, u.name, u.organization, u.user_external_id, u.email
FROM public.users u
WHERE u.user_external_id = $1
`

const usersByEmailSql = `
SELECT u.id, u.name, u.organization, u.user_external_id, u.email
FROM public.users u
WHERE lower(u.email) = lower($1)
`

const createUserSql = `
INSERT INTO public.users (name, organization, user_external_id, email)
VALUES ($1, $2, $3, $4)
RETURNING id
`

const updateUserSql = `
UPDATE public.users u
SET name = $2, organization = $3, user_external_id = $4, email = $5
WHERE u.id = $1
`

func (m *Manager) GetUserByUserExternalID(userExternalId string) *User {
	users := m.GetUsersByUserExternalID(userExternalId)
	if len(users) == 0 {
		return nil
	}
	if len(users) > 1 {
		log.Printf("multiple users found for external id: %s", userExternalId)
	}
	return users[0]
}

func (m *Manager) GetUsersByUserExternalID(userExternalId string) []*User {
	rows, err := m.DB.Query(userByUserExternalIDSql, userExternalId)
	if err != nil {
		panic(err)
	}
	defer rows.Close()
	return scanUsers(rows)
}

func (m *Manager) GetUserByEmail(email string) *User {
	users := m.GetUsersByEmail(email)
	if len(users) == 0 {
		return nil
	}
	if len(users) > 1 {
		log.Printf("multiple users found for email: %s", email)
	}
	return users[0]
}

func (m *Manager) GetUsersByEmail(email string) []*User {
	rows, err := m.DB.Query(usersByEmailSql, email)
	if err != nil {
		panic(err)
	}
	defer rows.Close()
	return scanUsers(rows)
}

func (m *Manager) CreateUser(user *User) (int, error) {
	tx, err := m.DB.Begin()
	if err != nil {
		return -1, err
	}

	row := tx.QueryRow(createUserSql, user.Name, user.Organization, user.UserExternalId, user.Email)
	var id int
	err = row.Scan(&id)
	if err != nil {
		defer tx.Rollback()
		return -1, err
	}

	err = tx.Commit()
	if err != nil {
		return -1, err
	}

	return id, nil
}

func (m *Manager) UpdateUser(user *User) error {
	tx, err := m.DB.Begin()
	if err != nil {
		return err
	}

	res, err := tx.Exec(updateUserSql, user.Id, user.Name, user.Organization, user.UserExternalId, user.Email)
	if err != nil {
		defer tx.Rollback()
		return err
	}

	rowCount, err := res.RowsAffected()
	if err != nil {
		defer tx.Rollback()
		return err
	}
	if rowCount != 1 {
		defer tx.Rollback()
		return fmt.Errorf("unexpected rows modified, expected one, saw %v", rowCount)
	}

	return tx.Commit()
}

func scanUsers(rows *sql.Rows) []*User {
	var users []*User
	for rows.Next() {
		var user User
		err := rows.Scan(&user.Id, &user.Name, &user.Organization, &user.UserExternalId, &user.Email)
		if err != nil {
			panic(err)
		}
		users = append(users, &user)
	}

	err := rows.Err()
	if err != nil {
		panic(err)
	}

	return users
}
