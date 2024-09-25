package db

import (
	"database/sql"
	"fmt"
)

type Manager struct {
	DB *sql.DB
}

func New(dbHost, dbPort, dbName, dbUser, dbPass string) *Manager {
	var psqlInfo string
	if dbPass == "" {
		psqlInfo = fmt.Sprintf("host=%s port=%s user=%s dbname=%s sslmode=disable",
			dbHost, dbPort, dbUser, dbName)
	} else {
		psqlInfo = fmt.Sprintf("host=%s port=%s user=%s dbname=%s password=%s sslmode=disable",
			dbHost, dbPort, dbUser, dbName, dbPass)
	}
	db, err := sql.Open("postgres", psqlInfo)
	if err != nil {
		panic(err)
	}

	err = db.Ping()
	if err != nil {
		panic(err)
	}

	fmt.Println("Successfully connected!")
	manager := &Manager{
		DB: db,
	}
	return manager
}
