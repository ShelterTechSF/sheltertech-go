package db

import (
	"fmt"
	"strings"
)

// buildUpdateQuery builds "UPDATE table SET col1=$1, col2=$2, ..., updated_at=now() WHERE idCol=$n".
// Only keys in allowedColumns are used. Returns query and args.
func buildUpdateQuery(table, idCol string, id int, updates map[string]interface{}, allowedColumns []string) (string, []interface{}) {
	allowedSet := make(map[string]bool)
	for _, c := range allowedColumns {
		allowedSet[c] = true
	}
	var setParts []string
	var args []interface{}
	pos := 1
	for key, val := range updates {
		if !allowedSet[key] {
			continue
		}
		setParts = append(setParts, fmt.Sprintf("%s=$%d", key, pos))
		args = append(args, val)
		pos++
	}
	setParts = append(setParts, "updated_at=now()")

	if len(setParts) == 0 {
		return "", nil
	}
	args = append(args, id)
	query := fmt.Sprintf("UPDATE public.%s SET %s WHERE %s=$%d", table, strings.Join(setParts, ", "), idCol, pos)

	return query, args
}

// buildInsertQuery builds "INSERT INTO table (col1, col2, ..., created_at, updated_at) VALUES ($1, $2, ..., now(), now()) RETURNING id".
// Only keys in allowedColumns are used. Returns query and args.
func buildInsertQuery(table string, values map[string]interface{}, allowedColumns []string) (string, []interface{}) {
	allowedSet := make(map[string]bool)
	for _, c := range allowedColumns {
		allowedSet[c] = true
	}
	var colParts []string
	var valParts []string
	var args []interface{}
	pos := 1
	for key, val := range values {
		if !allowedSet[key] {
			continue
		}
		colParts = append(colParts, fmt.Sprintf("%s", key))
		valParts = append(valParts, fmt.Sprintf("$%d", pos))
		args = append(args, val)
		pos++
	}
	colParts = append(colParts, "created_at, updated_at")
	valParts = append(valParts, "now(), now()")
	if len(colParts) == 0 {
		return "", nil
	}

	cols := strings.Join(colParts, ", ")
	vals := strings.Join(valParts, ", ")
	query := fmt.Sprintf("INSERT INTO public.%s (%s) VALUES (%s) RETURNING id", table, cols, vals)

	return query, args
}
