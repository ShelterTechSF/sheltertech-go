package db

type Category struct {
	Id         int
	Name       string
	TopLevel   bool
	Vocabulary string
	Featured   bool
}
