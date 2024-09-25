package db

import (
	"database/sql"
	"fmt"
)

type Program struct {
	Id            int
	Name          sql.NullString
	AlternateName sql.NullString
	Description   sql.NullString
	CreatedAt     sql.NullTime
	UpdatedAt     sql.NullTime
}

const programByIDSql = `
SELECT id, name, alterante_name, description
FROM public.programs
WHERE id = $1
`

func (m *Manager) GetProgramById(programId int) *Program {
	row := m.DB.QueryRow(programByIDSql, programId)
	return scanProgram(row)
}

func scanProgram(row *sql.Row) *Program {
	var program Program
	err := row.Scan(&program.Id, &program.Name, &program.AlternateName, &program.Description)
	if err != nil {
		switch err {
		case sql.ErrNoRows:
			fmt.Println("No rows were returned!")
			return nil
		default:
			panic(err)
		}
	}
	return &program
}
