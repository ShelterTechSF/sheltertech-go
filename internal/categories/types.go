package categories

import "github.com/sheltertechsf/sheltertech-go/internal/db"

type Category struct {
	Name     string `json:"name"`
	Id       int    `json:"id"`
	TopLevel bool   `json:"top_level"`
	Featured bool   `json:"featured"`
}

type Categories struct {
	Categories []*Category `json:"categories"`
}

type CategoryCountDTO struct {
	Name      string `json:"name"`
	Services  int    `json:"services"`
	Resources int    `json:"resources"`
}

func FromDBType(dbCategory *db.Category) *Category {
	category := &Category{
		Id:       dbCategory.Id,
		Name:     dbCategory.Name,
		TopLevel: dbCategory.TopLevel,
		Featured: dbCategory.Featured,
	}
	return category
}

func FromDBTypeArray(dbCategories []*db.Category) []*Category {
	categories := []*Category{}
	for _, dbCategory := range dbCategories {
		categories = append(categories, FromDBType(dbCategory))
	}
	return categories
}
