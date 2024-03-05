package programs

import "github.com/sheltertechsf/sheltertech-go/internal/db"

type Program struct {
	Id            int     `json:"id"`
	Name          *string `json:"name"`
	AlternateName *string `json:"alternate_name"`
	Description   *string `json:"description"`
}

func FromDBProgramType(dbProgram *db.Program) *Program {
	program := &Program{
		Id: dbProgram.Id,
	}
	if dbProgram.Name.Valid {
		program.Name = &dbProgram.Name.String
	}
	if dbProgram.AlternateName.Valid {
		program.AlternateName = &dbProgram.AlternateName.String
	}
	if dbProgram.Description.Valid {
		program.Description = &dbProgram.Description.String
	}
	return program
}
