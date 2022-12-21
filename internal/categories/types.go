package categories

type Category struct {
	Id       int    `json:"id"`
	Name     string `json:"name"`
	TopLevel bool   `json:"top_level"`
	Featured bool   `json:"featured"`
}

type Categories struct {
	Categories []*Category `json:"categories"`
}
