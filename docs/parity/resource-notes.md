# Resource note parity

`POST /api/resources/:id/notes` (tracker 7) now replaces the resource's complete
Algolia record after committing the note, matching `NotesController#create` and
`Resource` in Rails commit `5a644e810e4d2ece25c378eed1f14c169df967f6`.
The resource is touched as before; child services are not touched or reindexed.
Pending, rejected and inactive resources are removed from the index. Index errors
return HTTP 500 after the note has committed, as with Rails' callback.

The response retains null/omitted text and emits UTC timestamps with exactly three
decimal places. The resource serializer preserves every table attribute, nulls,
association order, coordinates, enum values and Rails schedule rounding.

Validation: `go test ./...`; complete Rails-captured resource fixture; visibility
and index-error tests; handler assertions that indexing follows the database
commit, including null/omitted notes and timestamp precision.
