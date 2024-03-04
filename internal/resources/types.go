package resources

import "github.com/sheltertechsf/sheltertech-go/internal/db"

type Resource struct {
	Id int `json:"id"`
}

func FromDBType(dbResource *db.Resource) *Resource {
	resource := &Resource{
		Id: dbResource.Id,
	}
	return resource
}
