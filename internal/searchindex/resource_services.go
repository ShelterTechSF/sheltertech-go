package searchindex

import (
	"context"
	"database/sql"
)

// RebuildResourceAndServices mirrors ChangeRequestsController#persist_change.
func RebuildResourceAndServices(ctx context.Context, database *sql.DB, index Indexer, resourceID int) error {
	if _, disabled := index.(NoopIndexer); disabled {
		return nil
	}
	if err := RebuildResource(ctx, database, index, resourceID); err != nil {
		return err
	}
	rows, err := database.QueryContext(ctx, "SELECT id FROM public.services WHERE resource_id = $1", resourceID)
	if err != nil {
		return err
	}
	ids := []int{}
	for rows.Next() {
		var id int
		if err := rows.Scan(&id); err != nil {
			rows.Close()
			return err
		}
		ids = append(ids, id)
	}
	err = rows.Err()
	rows.Close()
	if err != nil {
		return err
	}
	for _, id := range ids {
		if err := RebuildService(ctx, database, index, id); err != nil {
			return err
		}
	}
	return nil
}
