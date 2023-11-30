package db

import (
	"database/sql"
)

type Category struct {
	Id         int
	Name       string
	TopLevel   bool
	Vocabulary string
	Featured   bool
}

type ChangeRequest struct {
	Id         int
	Type       string
	ObjectId   int
	Status     int
	Action     int
	ResourceId int
	CreatedAt  sql.NullTime
	UpdatedAt  sql.NullTime
}

type Service struct {
	Id         int
	ResourceId int
}

type CategoryCount struct {
	CategoryName string
	Count        int
}
