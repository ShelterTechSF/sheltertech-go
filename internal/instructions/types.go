package instructions

import "github.com/sheltertechsf/sheltertech-go/internal/db"

type Instruction struct {
	Id int `json:"id"`
}

func FromInstructionDBType(dbInstruction *db.Instruction) *Instruction {
	instruction := &Instruction{
		Id: dbInstruction.Id,
	}
	return instruction
}

func FromInstructionDBTypeArray(dbInstructions []*db.Instruction) []*Instruction {
	var instructions []*Instruction
	for _, dbInstruction := range dbInstructions {
		instructions = append(instructions, FromInstructionDBType(dbInstruction))
	}
	return instructions
}
