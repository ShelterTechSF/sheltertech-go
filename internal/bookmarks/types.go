package bookmarks

type Bookmark struct {

	Id int `json:"id"`
	Order int `json:"order"`
	FolderID int `json:"folder_id"`
	ServiceID int `json:"service_id"`
	ResourceID int `json:"resource_id"`
	UserID int `json:"user_id"`

}

