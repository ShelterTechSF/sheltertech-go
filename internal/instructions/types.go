package instructions

import "github.com/sheltertechsf/sheltertech-go/internal/db"

type Instruction struct {
	Id          int     `json:"id"`
	Instruction *string `json:"instruction"`
}

func FromInstructionDBType(dbInstruction *db.Instruction) *Instruction {
	instruction := &Instruction{
		Id: dbInstruction.Id,
	}
	if dbInstruction.Instruction.Valid {
		instruction.Instruction = &dbInstruction.Instruction.String
	}
	return instruction
}

func FromInstructionDBTypeArray(dbInstructions []*db.Instruction) []*Instruction {
	instructions := []*Instruction{}
	for _, dbInstruction := range dbInstructions {
		instructions = append(instructions, FromInstructionDBType(dbInstruction))
	}
	return instructions
}
