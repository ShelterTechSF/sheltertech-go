package db

import (
	"fmt"
	"strings"
)

// buildUpdateQuery builds "UPDATE table SET col1=$1, col2=$2, ..., updated_at=now() WHERE idColumn=$n".
// Only keys in allowedColumns are used. If addUpdatedAt is true, appends updated_at=now(). Returns query and args.
func buildUpdateQuery(table, idColumn string, id int, updates map[string]interface{}, allowedColumns []string, addUpdatedAt bool) (string, []interface{}) {
	allowedSet := make(map[string]bool)
	for _, c := range allowedColumns {
		allowedSet[c] = true
	}
	var setParts []string
	var args []interface{}
	pos := 1
	for k, v := range updates {
		if !allowedSet[k] {
			continue
		}
		setParts = append(setParts, fmt.Sprintf("%s=$%d", k, pos))
		args = append(args, v)
		pos++
	}
	if addUpdatedAt {
		setParts = append(setParts, "updated_at=now()")
	}
	if len(setParts) == 0 {
		return "", nil
	}
	args = append(args, id)
	query := fmt.Sprintf("UPDATE public.%s SET %s WHERE %s=$%d", table, strings.Join(setParts, ", "), idColumn, pos)
	return query, args
}
