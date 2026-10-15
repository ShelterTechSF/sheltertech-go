# Service note parity

Scope: `POST /api/services/:id/notes` (tracker endpoint 12). Rails reference:
`askdarcel-api` commit `5a644e810e4d2ece25c378eed1f14c169df967f6`,
`app/controllers/notes_controller.rb`, `app/models/note.rb`, `app/models/service.rb`,
and `app/models/schedule.rb`. Go baseline: `9628eb0aad2b75fe584fc3b7b9324dd495911ed9`.

## Original differences

Both APIs returned HTTP 201 for `{"note":{"note":"Parity service note"}}`.
Rails inserted one note without changing its service or resource. Go also changed
both parents' `updated_at` values:

| Record | Before and after Rails | After original Go |
| --- | --- | --- |
| Resource 1700000013 | `2025-12-04T04:23:59.120196` | `2026-10-13T04:21:54.438458` |
| Service 1700000016 | `2025-12-04T04:23:59.106316` | `2026-10-13T04:21:54.438458` |

Go left one note in `service_1700000016` in Algolia; Rails rebuilt the record with
two. Go's response also used variable timestamp precision, whereas Rails emits
exactly three decimal places. Additional checks found that Rails accepts null or
omitted note text inside the `note` object; Go rejected it.

The original [field-level differences](https://drive.google.com/file/d/1KOeLIplS0qmFFaSGH63ZWGE4jkSiCX-e/view)
and [full evidence archive](https://drive.google.com/file/d/1vM6d3Fh5Eqed7mHL-CWWguotzDPBrfK-/view)
are linked from the [verification report](https://docs.google.com/document/d/1sWX5N7j8zeSGP4VnQYCqVAmOKSmlCAZe6H6qpIzQ0_8/edit).
Inside the archive, `evidence/12/result.json` contains the exact requests,
responses, changed row versions, and expected/actual Algolia records. The three
`.json.gz` snapshots in that directory retain every public table.

## Behavior preserved from Rails

- Insert the note without touching either parent, even though a related object changed.
- Emit UTC note timestamps with millisecond precision and preserve null note text.
- After the database commit, rebuild the entire approved service record, including a missing index record. Unapproved services are removed from the index.
- Use the Rails service model's attributes and association scopes, including address and schedule fallbacks, nulls, enum names, coordinate precision, and half-hour opening-time buckets. No additional array sorting is introduced.
- Submit the index operation asynchronously, as Rails does. Verification polls until the record appears before comparing it. Index failures return HTTP 500 after the note has committed, consistent with Rails' after-commit callback behavior.

Only this endpoint invokes the new service builder. Other endpoint handlers retain
their existing indexing behavior. No schema migration or new dependency is needed.

## Validation

`go test ./...` and `go vet ./...` pass, including a complete Rails-derived service
record fixture, null/missing note text, transaction failure, index failure, and
unapproved-service removal. The HTTP-client test verifies that the complete record
is sent using Algolia's replace-object API.

Live comparison uses separate local Rails and Go API processes and the isolated
`parity_rails` and `parity_go` databases. Each scenario starts from the same dataset, with fresh statistics (`ANALYZE`)
in both databases. Rails associations have no declared ordering; stale versus
fresh statistics can change their query plans and array order even without data
changes. The test keeps array comparisons strict and does not sort either side.
The comparison checks all 51 public tables, excluding primary and foreign key
columns only, and compares the parsed HTTP bodies without sorting arrays or
normalizing field values. The verification setup fixes only the note-creation
clocks at `2026-10-14T12:34:56.123456Z` so timestamps can be compared exactly.
This clock override is test-only and is not part of the application change.

Algolia is observed after Go and before Rails can overwrite the same fixture
record. An independent Rails serializer reads the Go database to determine the
expected record; the result is also compared with the Rails endpoint's result.
Only four reserved fixture object IDs in the personal `jjfreund_services_search`
index are used, and they are restored after each run. Index settings are unchanged.

| Live scenario | HTTP body/status | All 51 Postgres tables | Full Algolia record |
| --- | --- | --- | --- |
| approved | Exact match | Exact match | Exact match |
| missing-index | Exact match | Exact match | Exact match |
| pending | Exact match | Exact match | Exact match |
| empty-note | Exact match | Exact match | Exact match |
| null-note | Exact match | Exact match | Exact match |
| omitted-text | Exact match | Exact match | Exact match |
| rejected | Exact match | Exact match | Exact match |
| inactive | Exact match | Exact match | Exact match |
| service-address | Exact match | Exact match | Exact match |

All nine final snapshots also match with primary and foreign keys retained. The
service and resource timestamps remain unchanged in every scenario. Full raw
requests, responses, table snapshots, and Algolia records accompany this PR.

[Download the fix verification evidence](https://drive.google.com/file/d/1RcsepHEpWp658XIm-Jv40deRAQJFyswc/view)
for the nine requests, complete responses, all table snapshots, raw Algolia records,
source copies, and a SHA-256 manifest. `cleanup.json` confirms fixture restoration,
unchanged index settings, and removal of the test clock override.
