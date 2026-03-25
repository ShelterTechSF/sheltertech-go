package users

import "github.com/sheltertechsf/sheltertech-go/internal/db"

type User struct {
	Id           int    `json:"id"`
	Name         string `json:"name"`
	Email        string `json:"email"`
	Organization string `json:"organization"`
}

type ApiError struct {
	Error string `json:"error"`
}

type SaveUserRequest struct {
	Email        string  `json:"email"`
	Name         *string `json:"name"`
	Organization *string `json:"organization"`
}

func FromDBType(dbUser *db.User) *User {
	user := &User{
		Id:           dbUser.Id,
		Name:         dbUser.Name,
		Email:        dbUser.Email,
		Organization: dbUser.Organization,
	}
	return user
}
