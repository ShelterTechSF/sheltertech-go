package db

import (
	"database/sql"
	"fmt"
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

func (m *Manager) GetUserByUserExternalID(userExternalId string) *User {
	row := m.DB.QueryRow(userByUserExternalIDSql, userExternalId)
	return scanUser(row)
}
func scanUser(row *sql.Row) *User {
	var user User
	err := row.Scan(&user.Id, &user.Name, &user.Organization, &user.UserExternalId, &user.Email)
	if err != nil {
		switch err {
		case sql.ErrNoRows:
			fmt.Println("No rows were returned!")
			return nil
		default:
			panic(err)
		}
	}
	return &user
}
