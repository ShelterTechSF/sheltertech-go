package db

import (
	"database/sql"
	"fmt"
	"log"
	"time"
)

type Instruction struct {
	Id          int
	Instruction sql.NullString
	CreatedAt   time.Time
	UpdatedAt   time.Time
}

const instructionsByServiceIDSql = `
SELECT i.id, i.instruction
FROM public.instructions i
WHERE i.service_id = $1
`

const createInstructionSql = `
INSERT INTO public.instructions (service_id, instruction, created_at, updated_at)
VALUES ($1, $2, NOW(), NOW())
RETURNING id, instruction
`

func (m *Manager) GetInstructionsByServiceID(serviceId int) []*Instruction {
	var rows *sql.Rows
	var err error
	rows, err = m.DB.Query(instructionsByServiceIDSql, serviceId)
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanInstructions(rows)
}

func (m *Manager) CreateInstruction(serviceId int, instruction string) (*Instruction, error) {
	row := m.DB.QueryRow(createInstructionSql, serviceId, instruction)

	var created Instruction
	err := row.Scan(&created.Id, &created.Instruction)
	if err != nil {
		return nil, err
	}

	return &created, nil
}

func scanInstructions(rows *sql.Rows) []*Instruction {
	var instructions []*Instruction
	for rows.Next() {
		var instruction Instruction
		err := rows.Scan(&instruction.Id, &instruction.Instruction)
		switch err {
		case sql.ErrNoRows:
			fmt.Println("No rows were returned!")
			return nil
		}
		instructions = append(instructions, &instruction)
	}
	return instructions
}
