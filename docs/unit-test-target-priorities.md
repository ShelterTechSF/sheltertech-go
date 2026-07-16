# Unit Test Target Priorities

## Purpose
This document prioritizes the internal packages that should receive unit tests first, based on regression risk, branching complexity, and the likely payoff compared with additional integration-only coverage.

## Prioritization Criteria
- Business importance of the endpoint or flow.
- Amount of branching, validation, or error mapping in the manager.
- Likelihood that a unit test can isolate logic faster than an integration test.
- Amount of existing integration coverage already protecting the same behavior.
- Expected difficulty of introducing test seams around `*db.Manager`.

## Priority 0: Start Here
| Package | Why It Is First | First Tests To Add | Testability Notes |
| --- | --- | --- | --- |
| `internal/changerequest` | Small surface area, explicit placeholder test, and meaningful request branching. Good early win. | Invalid JSON body, unsupported or missing change request type, DB lookup failure, submit failure, success path returns `201`. | Likely needs a very small interface exposing `GetServiceById` and `SubmitChangeRequest`. |
| `internal/services` | High-value endpoint with heavy response composition and multiple DB calls. Placeholder test already exists. | Invalid ID returns `400`, DB lookup error returns `400`, success response includes expected service wrapper fields, optional program and resource branches behave correctly. | Best tested by extracting a narrow dependency interface rather than mocking all of `db.Manager`. |
| `internal/news_articles` | Good amount of branching and validation, plus strong overlap with API behavior that should be validated more cheaply in unit tests. | Invalid create body, unexpected query params, invalid update/delete IDs, not-found update/delete, DB error mapping, successful create/update serialization. | A focused interface for article CRUD is enough. |
| `internal/eligibilities` | Branch-heavy logic with several explicit error-mapping paths that are expensive to exhaust via integration only. | Invalid `category_id`, unexpected query params, invalid body, update duplicate-name path, update not-found path, subeligibilities missing both `id` and `name`, successful filtered fetch. | Good candidate once a seam exists for read and update methods. |

## Priority 1: High Value After The First Slice
| Package | Why It Matters | First Tests To Add | Testability Notes |
| --- | --- | --- | --- |
| `internal/savedsearches` | Dense validation and translation logic. Likely one of the best places to add meaningful unit coverage. | Invalid JSON, invalid category names, invalid eligibility names, success path builds DB query correctly, delete invalid ID handling. | Also includes helper functions that can be tested immediately without mocks. |
| `internal/folders` | Straightforward CRUD branch coverage with several status-handling paths that should be locked down. | Missing or invalid `user_id`, create failure, created record missing after create, get invalid ID, get not found, update failure, delete failure. | Easy to cover once CRUD methods are abstracted behind a small interface. |
| `internal/users` | Current integration tests do not truly validate the authenticated success path. | Auth failure returns `400`, successful user lookup returns serialized user payload. | May be easiest to test in combination with `internal/auth` helpers or after introducing an auth seam. |
| `internal/resources` | Important read path with response composition and an independent count endpoint. | Invalid ID handling, count DB error path, response composition for `GetByID`, service/category/phone enrichment. | Similar seam shape to `internal/services`. |
| `internal/auth` | Header parsing and request-to-user resolution are currently under-protected and influence user-facing behavior. | Missing authorization header, malformed bearer header, JWT parse failure, unknown user external ID. | `getAuthToken` is a low-effort pure helper target; `GetUserFromRequest` may need a seam or careful fixture setup. |

## Priority 2: Useful But Not Urgent
| Package | Why It Is Later | First Tests To Add | Testability Notes |
| --- | --- | --- | --- |
| `internal/categories` | Important endpoint family, but current integration tests already cover its main happy paths more than most areas. | `top_level` query parsing, count aggregation and sorting, invalid ID behavior in `GetByID` and `GetSubCategoriesByID`. | Good medium-effort candidate because the count aggregation logic is deterministic. |
| `internal/bookmarks` | Coverage is currently weak, but auth behavior may complicate early unit work depending on how deep the handler relies on request context. | Bad `user_id`, get-by-ID error mapping, create/update/delete happy and error paths. | Worth moving earlier if auth seams become simple. |
| `internal/phones` | Small surface area. | Delete invalid ID, delete DB failure, successful delete status. | Fast to add once a seam exists. |
| `internal/datathon` | Low branching and likely mostly passthrough behavior. | Dataset retrieval success and DB error behavior if any. | Lower payoff than the managers above. |

## Low-Effort Coverage Wins
- `internal/auth/getAuthToken`: pure header parsing with no DB dependency.
- `internal/savedsearches/getEligibilityIdsFromDbSavedSearches`: deterministic helper.
- `internal/savedsearches/getCategoryIdsFromDbSavedSearches`: deterministic helper.
- `internal/savedsearches/diffStringSlices`: deterministic helper.
- Any DTO conversion helpers that contain nontrivial branching or nil handling.

## Suggested Implementation Order
1. Convert the placeholder tests in `internal/changerequest/manager_test.go` and `internal/services/manager_test.go` into real tests.
2. Add minimal dependency interfaces needed to unit test `internal/changerequest`, `internal/services`, and `internal/news_articles`.
3. Add helper-level tests in `internal/auth` and `internal/savedsearches` for quick coverage gains.
4. Move next into `internal/eligibilities` and `internal/savedsearches`, which both have strong negative-case potential.
5. Fill in CRUD-oriented managers like `internal/folders`, then cover simpler packages such as `internal/resources`, `internal/categories`, and `internal/phones`.

## Expected Effort
- Priority 0 package test harness and first tests: about 2 to 4 working days.
- Priority 1 packages: about 3 to 5 more working days, depending on how much seam extraction is needed.
- Priority 2 and helper backfill: about 2 to 3 more working days.

## Recommended Testing Pattern
- Prefer table-driven tests for request validation and status mapping.
- Introduce package-local interfaces with only the DB methods a manager actually uses.
- Keep unit tests focused on observable behavior: status code, response body, branch selection, and arguments passed to dependencies.
- Avoid broad fake implementations of the full `db.Manager`; they will be harder to maintain than narrow stubs.
