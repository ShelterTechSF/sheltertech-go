package db

import (
	"database/sql"
	"errors"
	"fmt"
	"log"
)

type Folder struct {
	Id     int
	Name   string
	Order  int
	UserId int
}

const folderByIDSql = `
SELECT id, name, "order", user_id
FROM public.folders
WHERE id = $1
`

const foldersByUserIDSql = `
SELECT f.id, f.name, f.order, f.user_id
FROM public.folders f
WHERE f.user_id = $1
`

const createFolder = `
INSERT INTO public.folders (name, "order", user_id, created_at, updated_at)
VALUES ($1, $2, $3, now(), now())
RETURNING id
`

const updateFolder = `
UPDATE public.folders f
SET name = $2, "order" = $3
WHERE f.id = $1
`

const deleteFolder = `
DELETE FROM public.folders f
WHERE f.id = $1
`

func (m *Manager) GetFolderById(folderId int) *Folder {
	row := m.DB.QueryRow(folderByIDSql, folderId)
	return scanFolder(row)
}

func (m *Manager) GetFolders(userId int) []*Folder {
	var rows *sql.Rows
	var err error
	rows, err = m.DB.Query(foldersByUserIDSql, userId)
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanFolders(rows)
}

func (m *Manager) CreateFolder(folder *Folder) (int, error) {
	tx, err := m.DB.Begin()
	if err != nil {
		return -1, err
	}
	row := tx.QueryRow(createFolder, folder.Name, folder.Order, folder.UserId)
	var id int
	err = row.Scan(&id)
	if err != nil {
		return -1, err
	}
	return id, tx.Commit()
}

func (m *Manager) UpdateFolder(folder *Folder) error {
	tx, err := m.DB.Begin()
	if err != nil {
		return err
	}
	res, err := tx.Exec(updateFolder, folder.Id, folder.Name, folder.Order)
	if err != nil {
		return err
	}
	rowCount, err := res.RowsAffected()
	if err != nil {
		return err
	}
	if rowCount != 1 {
		defer tx.Rollback()
		return errors.New(fmt.Sprintf("unexpected rows modified, expected one, saw %v", rowCount))
	}
	return tx.Commit()
}

func (m *Manager) DeleteFolderById(folderId int) error {
	tx, err := m.DB.Begin()
	if err != nil {
		return err
	}

	res, err := tx.Exec(deleteFolder, folderId)
	if err != nil {
		return err
	}
	rowCount, err := res.RowsAffected()
	if err != nil {
		return err
	}
	if rowCount != 1 {
		defer tx.Rollback()
		return errors.New(fmt.Sprintf("unexpected rows modified, expected one, saw %v", rowCount))
	}
	return tx.Commit()
}

func scanFolders(rows *sql.Rows) []*Folder {
	var folders []*Folder
	for rows.Next() {
		var folder Folder
		err := rows.Scan(&folder.Id, &folder.Name, &folder.Order, &folder.UserId)
		switch err {
		case sql.ErrNoRows:
			fmt.Println("No rows were returned!")
			return nil
		}
		folders = append(folders, &folder)
	}
	return folders
}

func scanFolder(row *sql.Row) *Folder {
	var folder Folder
	err := row.Scan(&folder.Id, &folder.Name, &folder.Order, &folder.UserId)
	if err != nil {
		switch err {
		case sql.ErrNoRows:
			fmt.Println("No rows were returned!")
			return nil
		default:
			panic(err)
		}
	}
	return &folder
}
