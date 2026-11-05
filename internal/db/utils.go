package db

import (
	"fmt"
	"sort"
	"strings"
)

// buildUpdateQuery builds "UPDATE table SET col1=$1, col2=$2, ..., updated_at=now() WHERE idCol=$n".
// Only keys in allowedColumns are used. Keys are sorted to guarantee deterministic parameter ordering.
// Returns query and args.
func buildUpdateQuery(table, idCol string, id int, updates map[string]interface{}, allowedColumns []string) (string, []interface{}) {
	allowedSet := make(map[string]bool)
	for _, c := range allowedColumns {
		allowedSet[c] = true
	}

	// Collect and sort allowed keys for deterministic ordering
	var keys []string
	for key := range updates {
		if allowedSet[key] {
			keys = append(keys, key)
		}
	}
	sort.Strings(keys)

	var setParts []string
	var args []interface{}
	pos := 1
	for _, key := range keys {
		setParts = append(setParts, fmt.Sprintf("%s=$%d", key, pos))
		args = append(args, updates[key])
		pos++
	}
	setParts = append(setParts, "updated_at=now()")

	args = append(args, id)
	query := fmt.Sprintf("UPDATE public.%s SET %s WHERE %s=$%d", table, strings.Join(setParts, ", "), idCol, pos)

	return query, args
}

// buildInsertQuery builds "INSERT INTO table (col1, col2, ..., created_at, updated_at) VALUES ($1, $2, ..., now(), now()) RETURNING id".
// Only keys in allowedColumns are used. Keys are sorted to guarantee deterministic parameter ordering.
// Returns query and args.
func buildInsertQuery(table string, values map[string]interface{}, allowedColumns []string) (string, []interface{}) {
	allowedSet := make(map[string]bool)
	for _, c := range allowedColumns {
		allowedSet[c] = true
	}

	// Collect and sort allowed keys for deterministic ordering
	var keys []string
	for key := range values {
		if allowedSet[key] {
			keys = append(keys, key)
		}
	}
	sort.Strings(keys)

	var colParts []string
	var valParts []string
	var args []interface{}
	pos := 1
	for _, key := range keys {
		colParts = append(colParts, key)
		valParts = append(valParts, fmt.Sprintf("$%d", pos))
		args = append(args, values[key])
		pos++
	}
	colParts = append(colParts, "created_at, updated_at")
	valParts = append(valParts, "now(), now()")

	cols := strings.Join(colParts, ", ")
	vals := strings.Join(valParts, ", ")
	query := fmt.Sprintf("INSERT INTO public.%s (%s) VALUES (%s) RETURNING id", table, cols, vals)

	return query, args
}
