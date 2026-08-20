# AskDarcel Web Endpoint Migration Plan

This plan is based on a source review of `askdarcel-web`, `askdarcel-api`,
and `sheltertech-go`.

## Routing Rule

`askdarcel-web` routes backend calls by path prefix:

- `/api/v2/*` goes to `sheltertech-go`, with `/api/v2/` rewritten to `/api/`.
- `/api/*` goes to Rails, with `/api/` stripped before Rails receives the request.

This means an endpoint can already exist in Go but still be served by Rails if the web app still calls the plain `/api/*` path.

Excluded from this inventory: Cypress/test-only calls, documentation examples, Algolia browser searches, Google Maps/Street View calls, Auth0 calls, and `/api-docs`.

## Endpoint Inventory

| # | Web endpoint call | Web flow | Current backend | Go migration status | Effort to finish if not migrated |
|---|---|---|---|---|---|
| 1 | `GET /api/v2/resources/:id` | Organization listing and edit page load | Go | Migrated | N/A |
| 2 | `GET /api/resources/count` | Home page resource count | Rails | Go route exists as `/api/v2/resources/count`, but web still calls Rails | Low: switch `getResourceCount` to `/api/v2/resources/count` and verify the plain integer response matches Rails. |
| 3 | `DELETE /api/resources/:id` | Deactivate resource | Rails | Missing in Go | Large: set resource inactive, set approved child services inactive, preserve precondition behavior, and remove from Algolia. |
| 4 | `POST /api/resources/:id/certify` | HAP certification | Rails | Missing in Go | Small/Medium: set `certified` and `certified_at`, then preserve related indexing behavior. |
| 5 | `POST /api/v2/resources/:id/change_requests` | Resource field edits | Go | Migrated for field edit changes currently sent by the edit page | N/A |
| 6 | `POST /api/resources/:id/change_requests` | Resource reactivation | Rails | Partially covered by Go handler, but Go does not support the `status` reactivation payload | Low/Medium: add `status` handling and confirm Rails-compatible request/response semantics for activation. |
| 7 | `POST /api/resources/:id/notes` | Add resource note | Rails | Missing in Go | Medium: create note under a resource, return Rails-compatible JSON/status, and preserve resource touch/index side effects if required. |
| 8 | `POST /api/resources/:id/services` | Create new service under a resource | Rails | Missing in Go | Large: nested service create with categories, eligibilities, addresses, schedule days, notes, approved status, validation, and response shape. |
| 9 | `GET /api/v2/services/:id` | Service listing and PDF pages | Go | Migrated | N/A |
| 10 | `POST /api/services/:id/change_requests` | Service edits | Rails | Missing in Go | Medium/Large: support service field changes plus category and eligibility array transforms, instructions/notes/schedule companion calls, and approval/index side effects. |
| 11 | `DELETE /api/services/:id` | Deactivate service | Rails | Missing in Go | Medium: set approved service inactive, preserve precondition behavior, and remove from Algolia. |
| 12 | `POST /api/services/:id/notes` | Add service note | Rails | Missing in Go | Medium: create note under a service, return Rails-compatible JSON/status, and preserve parent resource touch/index behavior if required. |
| 13 | `PUT /api/services/:id/addresses/:address_id` | Add address to service | Rails | Missing in Go | Small/Medium: create the `addresses_services` association, preserve idempotent Rails statuses, and validate both records exist. |
| 14 | `DELETE /api/services/:id/addresses/:address_id` | Remove address from service | Rails | Missing in Go | Small/Medium: delete the `addresses_services` association, preserve Rails status behavior, and validate both records exist. |
| 15 | `POST /api/services/html_to_pdf` | Service and IPV handout PDFs | Rails | Go route exists as `/api/v2/services/html_to_pdf`, but web still calls Rails and Go currently parses form data while web sends JSON | Medium: make Go accept the current JSON payload or change web to send form data, then verify PDFCrowd output, translation, headers, and blob handling. |
| 16 | `GET /api/v2/categories/:id` | Service discovery category lookup | Go | Migrated | N/A |
| 17 | `GET /api/v2/categories/subcategories/:id` | Service discovery subcategory lookup | Go | Migrated | N/A |
| 18 | `GET /api/categories` | Edit-page category multi-select options | Rails | Go route exists as `/api/v2/categories`, but web still calls Rails | Low: switch the dropdown option route to `/api/v2/categories` and verify `{ categories: [...] }` shape/order. |
| 19 | `GET /api/v2/eligibilities?category_id=:id` | Service discovery eligibility lookup | Go | Migrated | N/A |
| 20 | `GET /api/v2/eligibilities/subeligibilities?id=:id` | Navigator dashboard subeligibility lookup | Go | Migrated | N/A |
| 21 | `GET /api/eligibilities` | Edit-page eligibility multi-select options | Rails | Go route exists as `/api/v2/eligibilities`, but web still calls Rails | Low: switch the dropdown option route to `/api/v2/eligibilities` and verify `{ eligibilities: [...] }` shape/order. |
| 22 | `POST /api/v2/phones/:id/change_requests` | Edit existing phone | Go | Migrated | N/A |
| 23 | `POST /api/v2/change_requests` with `type=phones` | Add new phone | Go | Migrated for phone insert only | N/A |
| 24 | `DELETE /api/phones/:id` | Remove phone | Rails | Go route exists as `/api/v2/phones/:id`, but web still calls Rails | Low: switch delete calls to `/api/v2/phones/:id` and verify 204/error handling does not regress the edit page. |
| 25 | `POST /api/addresses/:id/change_requests` | Edit or remove address | Rails | Missing in Go | Medium: support address edit/remove change requests, geocoding on approval if that remains required, and resource touch/index behavior. |
| 26 | `POST /api/change_requests` with `type=addresses` | Add new address | Rails | Missing in Go; Go generic create currently handles phones only | Medium/Large: create address records, attach to resource, record field changes, preserve geocoding and approval semantics. |
| 27 | `POST /api/schedule_days/:id/change_requests` | Edit existing schedule day | Rails | Missing in Go | Medium: support schedule-day field changes and Rails-compatible field-change persistence. |
| 28 | `POST /api/change_requests` with `type=schedule_days` | Add schedule day | Rails | Missing in Go; Go generic create currently handles phones only | Medium: create schedule-day change request with schedule association and matching approval behavior. |
| 29 | `POST /api/notes/:id/change_requests` | Edit existing note | Rails | Missing in Go | Medium: support note change requests and parent resource/service side effects. |
| 30 | `DELETE /api/notes/:id` | Remove note | Rails | Missing in Go | Low/Medium: delete note and confirm status handling expected by edit-page `Promise.all`. |
| 31 | `POST /api/instructions` | Add instruction to service edit data | Rails | Missing route/manager in Go, although DB/types files exist | Low/Medium: wire create route/manager using existing DB helpers if complete, then verify payload shape. |
| 32 | `PUT /api/instructions/:id` | Update instruction | Rails | Missing route/manager in Go, although DB/types files exist | Low/Medium: wire update route/manager using existing DB helpers if complete, then verify payload shape. |
| 33 | `GET /api/v2/news_articles?active=true` | Public breaking-news carousel | Go | Migrated | N/A |
| 34 | `GET /api/v2/news_articles` | Breaking-news admin page load | Go | Migrated | N/A |
| 35 | `POST /api/news_articles/` | Create breaking-news article | Rails | Go route exists as `/api/v2/news_articles`, but web still calls Rails | Low/Medium: switch to `/api/v2/news_articles`, normalize the trailing slash, and make Go accept the web's `YYYY-MM-DD` date strings. |
| 36 | `PUT /api/news_articles/:id` | Update breaking-news article | Rails | Go route exists as `/api/v2/news_articles/:id`, but web still calls Rails | Low/Medium: switch to `/api/v2/news_articles/:id` and make Go accept the web's `YYYY-MM-DD` date strings. |
| 37 | `DELETE /api/news_articles/:id` | Delete breaking-news article | Rails | Go route exists as `/api/v2/news_articles/:id`, but web still calls Rails | Low: switch to `/api/v2/news_articles/:id` and verify admin-page optimistic state behavior. |
| 38 | `POST /api/textings` | Text listing information to a user | Rails | Missing in Go | Large: port Textellent integration, phone normalization, listing aggregation, recipient upsert, and texting record creation. |
| 39 | `POST /api/translation/translate_text` | Translate search query before Algolia search | Rails | Missing standalone Go route; Go translation code is currently PDF-scoped | Medium: expose a standalone text translation endpoint with Google Translate credentials/config and Rails-compatible `{ result }` response/errors. |
| 40 | `GET /api/v2/users/current` | Authenticated user lookup | Go | Migrated | N/A |
| 41 | `POST /api/v2/users` | Save/reconcile user after Auth0 signup/login | Go | Migrated | N/A |
| 42 | `GET /api/v2/bookmarks?user_id=:id` | Bookmark menu/modal | Go | Migrated | N/A |
| 43 | `POST /api/v2/bookmarks` | Create bookmark | Go | Migrated | N/A |
| 44 | `GET /api/v2/folders?user_id=:id` | Bookmark menu/modal and navigator dashboard | Go | Migrated | N/A |
| 45 | `POST /api/v2/folders` | Create bookmark folder | Go | Migrated | N/A |
| 46 | `GET /api/v2/saved_searches?user_id=:id` | Navigator dashboard saved searches | Go | Migrated | N/A |
| 47 | `POST /api/v2/saved_searches` | Save search | Go | Migrated | N/A |

## Suggested Implementation Order

1. Flip low-risk web routes where Go already exists and appears shape-compatible:
   `GET /api/resources/count`, `GET /api/categories`, `GET /api/eligibilities`, and `DELETE /api/phones/:id`.

2. Finish nearly migrated Go routes that need compatibility cleanup:
   `POST /api/services/html_to_pdf` for JSON payload support, and breaking-news create/update for date-only strings plus trailing-slash normalization.

3. Implement small direct-write endpoints:
   resource certification, service-address add/remove, note deletion, and instructions create/update.

4. Implement change-request families together:
   resources reactivation/status, addresses, schedule days, notes, and services. The Rails approval path has important shared behavior: persist field changes, touch the parent resource, and update Algolia where configured.

5. Leave complex workflows for last:
   service creation, resource/service deactivation, texting, and standalone query translation.

## Test Plan

- For every Go endpoint, add focused unit tests around handler/database behavior and integration tests where the sample resource-count conversion already established a pattern.
- For route-only web flips, run the corresponding web flows: home resource count, edit-page category/eligibility dropdowns, phone removal, breaking-news admin, PDF handout generation, signup/user save, and saved-list actions.
- For edit workflow migrations, verify resource edits, service edits, resource reactivation, address add/edit/remove, schedule edits, note add/edit/delete, service creation, and resource/service deactivation.
- Mock or isolate external services in Go tests: PDFCrowd, Google Translate, Textellent, and Algolia.
- Compare Rails and Go response shape/status codes before flipping each web route, especially for endpoints consumed through `Promise.all` without detailed response parsing.

## Notes And Assumptions

- "Migrated" means the current web runtime call reaches Go via `/api/v2`, not merely that a Go handler exists.
- `askdarcel-web` and `askdarcel-api` use `master` as their remote default branch. `sheltertech-go` currently uses `main` as its remote default branch.
- Effort estimates are relative:
  - Low: mostly route flip or one simple handler/DB operation.
  - Medium: nontrivial DB writes, request/response compatibility, or approval side effects.
  - Large: nested model creation/deactivation or external service integration.
