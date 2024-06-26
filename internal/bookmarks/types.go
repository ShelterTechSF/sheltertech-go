package bookmarks

import "github.com/sheltertechsf/sheltertech-go/internal/db"

type Bookmark struct {
	Id         int  `json:"id"`
	Order      int  `json:"order"`
	FolderID   *int `json:"folder_id"`
	ServiceID  *int `json:"service_id"`
	ResourceID *int `json:"resource_id"`
	UserID     *int `json:"user_id"`
}

type Bookmarks struct {
	Bookmarks []*Bookmark `json:"bookmarks"`
}

func FromDBType(dbBookmark *db.Bookmark) *Bookmark {
	bookmark := &Bookmark{
		Id:         dbBookmark.Id,
		Order:      dbBookmark.Order,
		ServiceID:  dbBookmark.ServiceID,
		ResourceID: dbBookmark.ResourceID,
		UserID:     dbBookmark.UserID,
		FolderID:   dbBookmark.FolderID,
	}
	return bookmark
}

func FromDBTypeArray(dbBookmarks []*db.Bookmark) []*Bookmark {
	bookmarks := []*Bookmark{}
	for _, dbBookmark := range dbBookmarks {
		bookmarks = append(bookmarks, FromDBType(dbBookmark))
	}
	return bookmarks
}
