# Testing Implementation Roadmap

## Purpose
This document turns the testing inventory and unit-test priorities into a phased implementation plan, with recommended batching, effort, and an initial coverage threshold strategy.

## Guiding Principles
- Keep the API as the primary integration test boundary.
- Add unit tests where they reduce feedback time or make negative-path coverage much easier.
- Favor small, mergeable batches over a large test rewrite.
- Introduce coverage reporting early, but start with a modest gate that matches the current baseline.

## Recommended Phases

### Phase 1: Establish The Baseline
Goal: make current testing measurable and stable enough to expand.

Work:
- Add a local coverage command for the default unit-test path.
- Record baseline package-level and total line coverage.
- Document current integration suite depth using the inventory in `docs/testing-inventory-gap-matrix.md`.
- Identify and standardize how integration tests boot the app, since the current `init()` plus `go main()` pattern in `cmd/sheltertech-go/*_integration_test.go` is a likely source of flakiness.

Deliverables:
- `make coverage` or equivalent.
- Initial coverage artifact such as `coverage.out`.
- Short note in project docs on how to run unit, integration, and coverage commands.

Estimate:
- About 0.5 to 1 day.

### Phase 2: First Unit-Test Slice
Goal: add real unit tests in the highest-payoff internal packages.

Work:
- Replace placeholder tests in `internal/changerequest/manager_test.go` and `internal/services/manager_test.go`.
- Add the minimum dependency seams needed to isolate those managers from `*db.Manager`.
- Add a small set of helper-level tests in `internal/auth` and `internal/savedsearches` to raise coverage quickly with low implementation cost.

Deliverables:
- Real tests for `internal/changerequest` and `internal/services`.
- Initial helper coverage for pure or mostly pure functions.
- Repeatable test patterns for future manager tests.

Estimate:
- About 2 to 4 days.

### Phase 3: Deepen High-Value API Integration Coverage
Goal: strengthen the endpoint families that currently have the biggest gap between business importance and assertion depth.

Work:
- Expand `services`, `resources`, `saved_searches`, `bookmarks`, and `news_articles` integration suites first.
- Add response-content assertions, not just status-code checks.
- Add negative cases already implied by current handlers: invalid IDs, malformed JSON, not found, invalid query params, validation failures, and side-effect verification where applicable.
- Prefer create-read-update-read and create-delete-read patterns for mutable resources.

Deliverables:
- Strengthened integration coverage in the highest-priority endpoint families.
- Reduced dependence on fixed seeded IDs where practical.
- Better error-body assertions for user-visible failures.

Estimate:
- About 3 to 5 days for the first endpoint batch.

### Phase 4: Expand Branch-Heavy Unit Coverage
Goal: cover the next layer of internal logic that is expensive or awkward to test only through the HTTP surface.

Work:
- Add unit tests for `internal/news_articles`, `internal/eligibilities`, `internal/savedsearches`, and `internal/folders`.
- Cover explicit branch points and error mapping before adding broader CRUD happy-path duplication.
- Keep seams narrow and package-local.

Deliverables:
- Solid unit coverage around validation, branching, and error translation.
- Shared stubbing pattern that can be reused for other managers.

Estimate:
- About 3 to 5 days.

### Phase 5: Broaden Remaining API And Unit Coverage
Goal: close the most visible remaining gaps without over-testing low-value code.

Work:
- Add follow-on integration coverage for `users`, `phones`, `categories`, and `datathon`.
- Add unit tests to `resources`, `categories`, `bookmarks`, and any small managers still unprotected.
- Revisit auth-dependent scenarios once JWT behavior is testable in a stable way.

Deliverables:
- Coverage across the major endpoint families.
- Fewer endpoint areas with only smoke-level protection.

Estimate:
- About 1 to 2 additional weeks, depending on auth and environment complexity.

## Suggested Batch Order
1. Coverage command and baseline reporting.
2. `internal/changerequest` and `internal/services` unit tests.
3. `internal/auth` and `internal/savedsearches` helper tests.
4. Stronger integration tests for `services`, `resources`, and `saved_searches`.
5. Stronger integration tests for `news_articles`, `folders`, and `bookmarks`.
6. Unit tests for `news_articles`, `eligibilities`, `savedsearches`, and `folders`.
7. Remaining package and endpoint backfill.

## Coverage Recommendation

### Metric
- Use Go line coverage from the default unit-test suite first:
  - `go test -coverprofile=coverage.out -covermode=atomic ./...`

### Where To Enforce It
- Add it locally through the `Makefile`.
- Add it to `.github/workflows/ci.yml` in the existing `build` job or in a dedicated coverage job.
- Keep integration coverage reporting separate at first; do not make merged unit-plus-integration coverage a blocker in the first pass.

### Initial Threshold
- Start with a modest threshold, likely in the 20% to 30% range for the default unit-test path.
- Pick the final floor only after capturing the actual baseline.
- Raise the threshold gradually as the first two or three implementation batches land.

### Why This Threshold Range
- Current unit coverage is near zero, so an aggressive threshold would either fail immediately or force low-value tests.
- A modest initial gate creates accountability without distorting priorities.
- Package-level visibility matters more than a single repo-wide number in the first iteration.

## Definition Of Done For The First Milestone
- Unit coverage is measurable locally and in CI.
- Placeholder unit tests are replaced with real assertions.
- At least three high-value endpoint families have materially stronger integration assertions.
- The project has a documented, reusable pattern for adding both manager unit tests and API integration tests.

## Overall Effort
- Assessment and baseline setup: about 1 to 2 days.
- First meaningful implementation milestone: about 1 week.
- Broader expansion across most target areas: about 2 to 3 weeks total elapsed implementation time.

## Autonomy
- This work should be feasible to complete autonomously within this repository.
- The current GitHub Actions configuration is in-repo, so local and CI coverage wiring should not require a separate config repository based on what is visible here.
- The main unknowns are external policy constraints such as required checks, secret handling, or org-level GitHub settings, but those should not block the core implementation.

## Recommended Next Execution Slice
- Add coverage reporting to the local workflow and CI.
- Implement real unit tests for `internal/changerequest` and `internal/services`.
- Deepen integration tests for `cmd/sheltertech-go/services_integration_test.go` and `cmd/sheltertech-go/resources_integration_test.go`.
- Reassess the new baseline after that slice before scaling to the rest of the endpoint families.
