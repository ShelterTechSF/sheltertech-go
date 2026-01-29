# ShelterTech Go Architecture Rules

## Project Overview

**sheltertech-go** is a Go-based REST API migration from a Ruby on Rails application (askdarcel-api). It provides backend services for AskDarcel, a platform connecting people experiencing homelessness with resources and services in San Francisco.

### Purpose
- Migrate from Rails to Go for better performance and maintainability
- Maintain API compatibility with existing Rails endpoints
- Support resource discovery, user bookmarks, saved searches, and service management
- Integrate with existing PostgreSQL database schema

## Directory Structure

```
sheltertech-go/
├── cmd/sheltertech-go/     # Application entry point and integration tests
├── internal/                # Private application code
│   ├── {domain}/           # Domain-specific packages (categories, services, etc.)
│   │   ├── manager.go      # HTTP handlers and business logic
│   │   └── types.go        # API request/response types
│   ├── db/                 # Database access layer
│   ├── auth/               # Authentication and authorization
│   └── common/             # Shared utilities
├── db/                     # Database schema and seed data
├── docs/                   # Swagger/OpenAPI documentation
└── vendor/                 # Vendored dependencies
```

## Architectural Patterns

### 1. Manager Pattern
- Each domain (categories, services, folders, etc.) has a `Manager` struct
- Managers handle HTTP requests and coordinate with the database layer
- Managers are initialized in `main.go` and passed to route handlers
- Pattern: `internal/{domain}/manager.go` contains HTTP handlers
- Managers receive `*db.Manager` as dependency injection

### 2. Database Layer
- Centralized database access through `internal/db/Manager`
- Database operations are in `internal/db/{domain}.go` files
- Uses `database/sql` with PostgreSQL driver (`lib/pq`)
- Database types use `sql.NullString`, `sql.NullInt32`, etc. for nullable fields
- SQL queries are defined as constants at the top of each file
- Scan functions convert database rows to Go structs

### 3. Type Conversion
- Database types (`db.{Type}`) are separate from API types (`{domain}.{Type}`)
- Conversion functions: `FromDBType()` and `FromDBTypeArray()`
- API types use pointers (`*string`, `*int`) for optional fields
- JSON tags follow snake_case convention (e.g., `json:"user_id"`)
- Database nullable fields are converted to pointer types in API responses

### 4. Routing
- Uses Chi router (`github.com/go-chi/chi/v5`)
- Routes grouped by authentication requirements:
  - **Authenticated routes** (require JWT): folders, bookmarks, saved_searches, phones
  - **Public routes**: categories, services, resources, eligibilities, news_articles
- JWT verification controlled by `ENABLE_JWT_VERIFICATION` env var
- Routes use `/api/{resource}` prefix
- Route handlers are methods on Manager structs

### 5. Error Handling
- Common error responses via `common.WriteErrorJson()`
- Some managers have local `writeJson()` and `writeStatus()` helpers
- **Standard pattern**: Use `common.WriteErrorJson()` for consistency
- Database errors should be logged and returned as HTTP errors, not panicked
- Always check errors from database operations and HTTP operations

### 6. Testing
- Integration tests in `cmd/sheltertech-go/*_integration_test.go`
- Tests use `//go:build integration` build tag
- Tests start server via `go main()` in `init()`
- Tests connect to database via docker-compose setup
- Run with: `go test -tags=integration -v ./cmd/sheltertech-go/`
- Tests should handle cases where services may not be configured (e.g., JWT, external APIs)

### 7. Configuration
- Environment variables via Viper (`spf13/viper`)
- Database: `DB_HOST`, `DB_PORT`, `DB_NAME`, `DB_USER`, `DB_PASS`
- Auth: `AUTH0_DOMAIN`, `ENABLE_JWT_VERIFICATION`, `AUTH0_AUDIENCE`
- Defaults set in `setIntegrationTestEnv()` for local development
- Configuration read at startup in `main()`

### 8. Middleware
- Prometheus metrics middleware for request tracking
- Chi logger middleware
- Sentry error tracking middleware
- JWT authentication middleware (conditional based on `ENABLE_JWT_VERIFICATION`)
- Middleware applied globally or per route group

## Key Dependencies

- **Chi** (`github.com/go-chi/chi/v5`): HTTP router
- **lib/pq** (`github.com/lib/pq`): PostgreSQL driver
- **Viper** (`github.com/spf13/viper`): Configuration management
- **Sentry** (`github.com/getsentry/sentry-go`): Error tracking
- **Prometheus** (`github.com/prometheus/client_golang`): Metrics
- **Swagger** (`github.com/swaggo/swag`): API documentation
- **JWT** (`github.com/MicahParks/keyfunc/v3`): Authentication (Auth0)

## Code Style Guidelines

### Naming Conventions
- Package names: lowercase, singular (e.g., `categories`, `services`)
- Manager structs: `Manager`
- HTTP handlers: PascalCase method names (e.g., `Get`, `Post`, `Put`, `Delete`)
- Database functions: `Get{Resource}`, `Create{Resource}`, `Update{Resource}`, `Delete{Resource}`
- Type conversion: `FromDBType()`, `FromDBTypeArray()`

### HTTP Handler Pattern
```go
func (m *Manager) Get(w http.ResponseWriter, r *http.Request) {
    // 1. Parse request parameters
    // 2. Call database layer
    // 3. Convert DB types to API types
    // 4. Write JSON response
}
```

### Database Query Pattern
```go
const querySQL = `SELECT ... FROM ... WHERE ...`

func (m *Manager) GetResource(id int) *Resource {
    row := m.DB.QueryRow(querySQL, id)
    return scanResource(row)
}
```

### Error Response Pattern
```go
if err != nil {
    log.Printf("Error: %v", err)
    common.WriteErrorJson(w, http.StatusBadRequest, "Error message")
    return
}
```

## API Response Patterns

### Success Responses
- GET: 200 OK with JSON body
- POST: 201 Created with JSON body (created resource)
- PUT: 200 OK with JSON body (updated resource)
- DELETE: 200 OK or 204 No Content (check actual implementation)

### Error Responses
- 400 Bad Request: Invalid input, missing parameters
- 401 Unauthorized: Missing or invalid JWT
- 404 Not Found: Resource not found
- 500 Internal Server Error: Server-side errors

### Response Wrappers
- Some endpoints wrap arrays in objects: `{"folders": [...]}` instead of `[...]`
- Check `types.go` for each domain to see response structure
- Examples: `folders.Folders`, `newsarticles.NewsArticles`, `eligibilities.Eligibilities`

## Database Patterns

### Nullable Fields
- Database uses `sql.NullString`, `sql.NullInt32`, `sql.NullTime`
- API types use pointers: `*string`, `*int`, `*time.Time`
- Conversion checks `.Valid` before assigning

### Transactions
- Use transactions for multi-step operations
- Pattern: `tx.Begin()`, `tx.Exec()`, check `RowsAffected()`, `tx.Commit()` or `tx.Rollback()`
- Always check `RowsAffected()` matches expected count

### Query Patterns
- Use parameterized queries (prevent SQL injection)
- Use `QueryRow()` for single row, `Query()` for multiple rows
- Always handle `sql.ErrNoRows` appropriately
- Close rows after iteration

## Authentication

### JWT Authentication
- Uses Auth0 for JWT validation
- Middleware: `auth.EnsureValidToken()`
- User extraction: `auth.GetUserFromRequest()`
- JWT subject maps to `user_external_id` in database

### Route Protection
- Routes in authenticated group use `r.Use(auth.EnsureValidToken())`
- Public routes don't require authentication
- Some endpoints accept `user_id` query parameter instead of JWT

## Important Notes

1. **Database Connection**: Single `*sql.DB` instance shared across all managers
2. **No ORM**: Uses raw SQL queries for full control
3. **Vendor Directory**: Dependencies are vendored (not using Go modules directly)
4. **Integration Tests**: Require database running (via docker-compose)
5. **Swagger Docs**: Generated from code comments, available at `/api/swagger`
6. **Metrics**: Prometheus metrics at `/metrics` endpoint
7. **Port**: Application runs on port 3001 (configurable)
