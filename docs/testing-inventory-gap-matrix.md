# Testing Inventory And Gap Matrix

## Scope
This document inventories the current automated tests in `sheltertech-go` and highlights the most important coverage gaps, with emphasis on unit coverage, API integration depth, and readiness for future coverage metrics.

## Current State Summary
- Unit coverage is effectively nonexistent. The only unit test files are placeholders in `internal/services/manager_test.go` and `internal/changerequest/manager_test.go`.
- Integration coverage is API-first and concentrated in `cmd/sheltertech-go/*_integration_test.go`.
- CI already runs unit and integration suites separately via `make test` and `make integration-test`.
- Coverage reporting is not present locally or in CI.
- Integration tests currently use a per-file `init()` plus `go main()` pattern, which is likely to be flaky and makes test setup harder to control.

## Integration Test Inventory
| Area | Test File | Current Coverage | Current Depth | Main Gaps | Priority |
| --- | --- | --- | --- | --- | --- |
| Categories | `cmd/sheltertech-go/categories_integration_test.go` | `GET /categories`, `GET /categories/{id}`, `GET /categories/subcategories/{id}`, `GET /categories/featured`, `GET /categories/counts` | Medium | Good payload parsing, but little negative coverage. Missing invalid ID, not found, invalid query handling, and `top_level` query coverage. Some assertions depend on seeded ordering and fixed data. | Medium |
| Services | `cmd/sheltertech-go/services_integration_test.go` | `GET /services/{id}`, invalid ID, `POST /services/{id}/change_request` | Low to medium | Only one field is asserted on the read path. Missing not-found, malformed body, invalid change request type, and post-submit side-effect checks. | High |
| Resources | `cmd/sheltertech-go/resources_integration_test.go` | `GET /resources/count` | Low | No `GET /resources/{id}` coverage, no invalid ID or error-path coverage, and no payload assertions beyond count parsing. | High |
| Folders | `cmd/sheltertech-go/folders_integration_test.go` | Full CRUD plus invalid ID on read | Medium | Better than most suites because it verifies create then read and update then read. Still missing missing `user_id`, malformed body, 404 cases, and delete-followed-by-read validation. | High |
| Saved Searches | `cmd/sheltertech-go/saved_searches_integration_test.go` | `GET`, `POST`, `GET /{id}`, `DELETE`, invalid ID | Medium | Mostly happy-path CRUD. Missing invalid categories and eligibilities, missing `user_id`, malformed JSON, delete verification, and response-content assertions beyond IDs. | High |
| Bookmarks | `cmd/sheltertech-go/bookmarks_integration_test.go` | Bad query case, lookup error case, skipped auth tests | Low | No working happy-path CRUD coverage and auth scenarios are skipped. This area has meaningful functional exposure with very little test protection. | High |
| News Articles | `cmd/sheltertech-go/news_articles_integration_test.go` | `GET`, `POST`, `PUT`, `DELETE`, invalid IDs for update and delete | Medium | Good endpoint spread, but assertions remain shallow. Missing invalid body tests, not-found tests, `active` query behavior, unexpected query param validation, and response field verification. | High |
| Eligibilities | `cmd/sheltertech-go/eligibilities_integration_test.go` | `GET`, filtered `GET`, `GET /{id}`, featured, subeligibilities, update | Medium to high | This is one of the more detailed suites. Still missing several negative cases already encoded in handlers: invalid `category_id`, unexpected query params, duplicate-name updates, constraint violations, and missing `id` or `name` for subeligibilities. | Medium |
| Users | `cmd/sheltertech-go/users_integration_test.go` | `GET /users/current` without auth and with dummy auth header | Low | No validated success path, no response payload assertions, and behavior is environment-dependent when JWT verification changes. | Medium to high |
| Datathon | `cmd/sheltertech-go/datathon_integration_test.go` | Two dataset endpoints | Low | Likely smoke-level only. Missing payload shape checks, content sanity checks, and negative behavior if upstream assumptions change. | Medium |
| Phones | `cmd/sheltertech-go/phones_integration_test.go` | Delete endpoint | Low | Very narrow endpoint coverage. Missing invalid ID, not-found, and successful delete verification. | Medium |
| Swagger | `cmd/sheltertech-go/swagger_integration_test.go` | Swagger docs endpoint | Low | Mostly smoke coverage, which is probably fine. | Low |
| Metrics | `cmd/sheltertech-go/metrics_integration_test.go` | Prometheus metrics endpoint | Low | Mostly smoke coverage, which is probably fine unless metrics format stability matters. | Low |

## Unit Test Inventory
| Package | Current State | Gap |
| --- | --- | --- |
| `internal/services` | Placeholder unit test only | No coverage for request parsing, DB error handling, or large response composition logic. |
| `internal/changerequest` | Placeholder unit test only | No coverage for JSON parsing, error mapping, request validation, or submit behavior. |
| Remaining `internal/*` packages | No unit tests present | Most business logic currently relies on integration tests to detect regressions. |

## Cross-Cutting Gaps
- Very little explicit verification of error response bodies and error-message consistency across endpoints.
- Many tests still validate status codes without validating response payload semantics.
- Several integration suites depend on seeded database records or fixed IDs, which increases brittleness.
- Auth-protected paths are under-tested because JWT-related behavior is environment-sensitive.
- There is no reusable integration test harness for server startup, seeded data management, or teardown.
- There is no coverage baseline to show whether additional tests are actually improving confidence.

## Highest-Value Gaps To Address First
1. Strengthen low-depth but high-value API areas: `services`, `resources`, `bookmarks`, `saved_searches`, and `news_articles`.
2. Add negative API scenarios already implied by handler code: invalid IDs, malformed bodies, unexpected query params, not-found paths, and validation failures.
3. Replace or centralize the current integration startup pattern so the suite is stable enough to scale.
4. Add unit tests around the most branch-heavy managers so regressions can be caught without booting the whole server.

## Notes For Follow-On Coverage Work
- The current layout supports an API-first testing strategy well, but it needs deeper assertions and more deliberate negative coverage.
- Unit coverage should focus on handler and manager logic with narrow DB seams, not on trying to fully mock the entire `db.Manager`.
- A first coverage metric should target the default `go test ./...` path and treat integration coverage as a later expansion.
