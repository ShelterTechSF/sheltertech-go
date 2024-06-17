package folders

import "github.com/sheltertechsf/sheltertech-go/internal/db"

type Folder struct {
	Name   string `json:"name"`
	Id     int    `json:"id"`
	Order  int    `json:"order"`
	UserId int    `json:"user_id"`
}

type Folders struct {
	Folders []*Folder `json:"folders"`
}

func FromDBType(dbFolder *db.Folder) *Folder {
	folder := &Folder{
		Id:     dbFolder.Id,
		Name:   dbFolder.Name,
		Order:  dbFolder.Order,
		UserId: dbFolder.UserId,
	}
	return folder
}

func FromDBTypeArray(dbFolders []*db.Folder) []*Folder {
	folders := []*Folder{}
	for _, dbFolder := range dbFolders {
		folders = append(folders, FromDBType(dbFolder))
	}
	return folders
}