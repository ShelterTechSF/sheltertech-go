package programs

import "github.com/sheltertechsf/sheltertech-go/internal/db"

type Program struct {
	Id int `json:"id"`
}

func FromDBProgramType(dbProgram *db.Program) *Program {
	program := &Program{
		Id: dbProgram.Id,
	}
	return program
}
