package db

import (
	"database/sql"
	"errors"
	"fmt"
	"log"
)

type Bookmark struct {
	Id         int
	Order      int
	FolderID   *int
	ServiceID  *int
	ResourceID *int
	UserID     *int
	Name       string
	CreatedAt  sql.NullTime
	UpdatedAt  sql.NullTime
}

const findBookmarksSql = `
SELECT id, "order", user_id, folder_id, service_id, resource_id, name from public.bookmarks`

const findBookmarksByUserIDSql = `
SELECT id, "order", user_id, folder_id, service_id, resource_id, name from public.bookmarks WHERE user_id=$1`

const findBookmarksByIDSql = `
SELECT id, "order", user_id, folder_id, service_id, resource_id, name from public.bookmarks WHERE id=$1`

const submitBookmark = `
INSERT INTO public.bookmarks ("order", user_id, folder_id, resource_id, service_id, name, created_at, updated_at)
VALUES ($1, $2, $3, $4, $5, $6, now(), now())`

const updateBookmark = `
UPDATE public.bookmarks SET "order" = $2, user_id = $3, folder_id= $4, resource_id = $5, service_id = $6, name = $7 where id = $1`

const deleteBookmarkByIDSql = `
DELETE FROM public.bookmarks WHERE id = $1
`

// const bookmarksByFolderIDSQL = `
// SELECT b.if, b.order, b.service_id
// FROM public.bookmarks b
// WHERE b.folder_id = $1
// `

func (m *Manager) GetBookmarks() ([]*Bookmark, error) {
	var rows *sql.Rows
	var err error
	rows, err = m.DB.Query(findBookmarksSql)
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanBookmarks(rows), err
}

func (m *Manager) GetBookmarkByID(bookmarkId int) (*Bookmark, error) {
	row := m.DB.QueryRow(findBookmarksByIDSql, bookmarkId)
	return scanBookmark(row)
}

func (m *Manager) GetBookmarksByUserID(userId int) ([]*Bookmark, error) {
	var rows *sql.Rows
	var err error
	rows, err = m.DB.Query(findBookmarksByUserIDSql, userId)
	if err != nil {
		log.Printf("%v\n", err)
		return nil, err
	}
	return scanBookmarks(rows), err
}

func (m *Manager) SubmitBookmark(bookmark *Bookmark) error {
	tx, err := m.DB.Begin()
	if err != nil {
		return err
	}
	res, err := tx.Exec(submitBookmark, bookmark.Order, bookmark.UserID, bookmark.FolderID, bookmark.ResourceID, bookmark.ServiceID, bookmark.Name)
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

func (m *Manager) UpdateBookmark(bookmark *Bookmark) error {
	tx, err := m.DB.Begin()
	if err != nil {
		return err
	}
	res, err := tx.Exec(updateBookmark, bookmark.Id, bookmark.Order, bookmark.UserID, bookmark.FolderID, bookmark.ResourceID, bookmark.ServiceID, bookmark.Name)
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

func (m *Manager) DeleteBookmarkByID(bookmarkId int) error {
	tx, err := m.DB.Begin()
	if err != nil {
		return err
	}

	res, err := tx.Exec(deleteBookmarkByIDSql, bookmarkId)
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

func scanBookmarks(rows *sql.Rows) []*Bookmark {
	var bookmarks []*Bookmark
	for rows.Next() {
		var bookmark Bookmark
		err := rows.Scan(&bookmark.Id, &bookmark.Order, &bookmark.UserID, &bookmark.FolderID, &bookmark.ServiceID, &bookmark.ResourceID, &bookmark.Name)
		switch err {
		case sql.ErrNoRows:
			fmt.Println("No rows were returned!")
			return nil
		}
		bookmarks = append(bookmarks, &bookmark)
	}
	return bookmarks
}

func scanBookmark(row *sql.Row) (*Bookmark, error) {
	var bookmark Bookmark
	err := row.Scan(&bookmark.Id, &bookmark.Order, &bookmark.UserID, &bookmark.FolderID, &bookmark.ServiceID, &bookmark.ResourceID, &bookmark.Name)
	return &bookmark, err
}
