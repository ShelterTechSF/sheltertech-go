# ShelterTech Go Tech Debt Plan

## Priority: CRITICAL

### 1. Error Handling Inconsistencies
**Files**: `internal/db/manager.go`, `internal/folders/manager.go`, `internal/users/manager.go`, `internal/db/users.go`, multiple manager files

**Issues**:
- `panic()` used for database connection failures (`internal/db/manager.go:23,28`)
- Missing error handling: `ioutil.ReadAll()` errors ignored in 6+ places
- Missing `return` statements after error handling (`internal/folders/manager.go:140,152`)
- Inconsistent error response formats (some use `common.WriteErrorJson`, others use local helpers)
- Database scan errors use `panic()` instead of proper error returns (`internal/db/users.go:35`)

**Impact**: Application crashes, silent failures, poor error messages to clients

**Action Items**:
1. Replace `panic()` in `internal/db/manager.go` with proper error returns
2. Add error handling for all `ioutil.ReadAll()` calls
3. Add missing `return` statements after error handling
4. Standardize on `common.WriteErrorJson()` for all error responses
5. Replace `panic()` in database scan functions with error returns

**Estimated Effort**: 4-6 hours

---

## Priority: HIGH

### 2. Deprecated `ioutil` Package Usage
**Files**: `internal/folders/manager.go`, `internal/savedsearches/manager.go`, `internal/changerequest/manager.go`, `internal/bookmarks/manager.go`

**Issues**:
- `ioutil.ReadAll()` deprecated since Go 1.16, should use `io.ReadAll()`
- 6 occurrences across 4 files

**Impact**: Deprecated API usage, potential future compatibility issues

**Action Items**:
1. Replace `ioutil.ReadAll()` with `io.ReadAll()` in all files
2. Update imports from `io/ioutil` to `io`

**Estimated Effort**: 30 minutes

### 3. Missing Database Connection Pooling Configuration
**File**: `internal/db/manager.go`

**Issues**:
- No `SetMaxOpenConns()`, `SetMaxIdleConns()`, or `SetConnMaxLifetime()` configured
- Default connection pool may be insufficient for production

**Impact**: Potential connection exhaustion, poor performance under load

**Action Items**:
1. Add connection pool configuration:
   ```go
   db.SetMaxOpenConns(25)
   db.SetMaxIdleConns(5)
   db.SetConnMaxLifetime(5 * time.Minute)
   ```
2. Make values configurable via environment variables
3. Add comments explaining the chosen values

**Estimated Effort**: 1 hour

---

## Priority: MEDIUM

### 4. Swagger Documentation Placeholder Values
**File**: `cmd/sheltertech-go/main.go:99-104`

**Issues**:
- Swagger metadata still contains example values:
  - Title: "Swagger Example API"
  - Description: "sample server Petstore server"
  - Host: "petstore.swagger.io"
  - BasePath: "/v2" (actual is "/api")

**Impact**: Incorrect API documentation, confusing for API consumers

**Action Items**:
1. Update `docs.SwaggerInfo` with correct project information:
   - Title: "AskDarcel API"
   - Description: "REST API for AskDarcel resource discovery platform"
   - Host: Configure based on environment
   - BasePath: "/api"

**Estimated Effort**: 30 minutes

### 5. Hardcoded Sentry DSN
**File**: `cmd/sheltertech-go/main.go:88`

**Issues**:
- Sentry DSN hardcoded in source code
- Should be environment variable for different environments

**Impact**: Security risk, cannot use different Sentry projects per environment

**Action Items**:
1. Move Sentry DSN to `SENTRY_DSN` environment variable
2. Make Sentry initialization conditional (skip if DSN not provided)
3. Update docker-compose files with environment variable

**Estimated Effort**: 1 hour

### 6. Missing Graceful Shutdown
**File**: `cmd/sheltertech-go/main.go:165`

**Issues**:
- `http.ListenAndServe()` blocks without signal handling
- No graceful shutdown for in-flight requests
- Database connections not closed on shutdown

**Impact**: Abrupt shutdowns, potential data loss, poor deployment experience

**Action Items**:
1. Implement signal handling for SIGTERM/SIGINT
2. Add graceful shutdown with timeout (e.g., 30 seconds)
3. Close database connections on shutdown
4. Use `http.Server.Shutdown()` instead of blocking `ListenAndServe()`

**Estimated Effort**: 2-3 hours

### 7. Inconsistent JSON Response Helpers
**Files**: Multiple manager files (`internal/folders/manager.go`, `internal/users/manager.go`, etc.)

**Issues**:
- Some managers use `common.WriteErrorJson()`
- Others define local `writeJson()` and `writeStatus()` helpers
- Inconsistent response formats and status code handling

**Impact**: Code duplication, maintenance burden, inconsistent API responses

**Action Items**:
1. Audit all managers for response helper usage
2. Standardize on `common.WriteErrorJson()` for errors
3. Create unified `common.WriteJson()` helper for success responses
4. Remove duplicate helper functions from managers
5. Update all managers to use common helpers

**Estimated Effort**: 3-4 hours

### 8. Missing Input Validation
**Files**: Various manager files

**Issues**:
- Limited validation of request parameters
- No validation library usage
- SQL injection protection relies solely on parameterized queries (good) but no input sanitization

**Impact**: Potential invalid data in database, poor error messages

**Action Items**:
1. Add input validation for required fields
2. Validate ID parameters are positive integers
3. Validate string lengths and formats where appropriate
4. Consider adding validation library (e.g., `go-playground/validator`)

**Estimated Effort**: 4-6 hours

---

## Priority: LOW

### 9. Missing Context Propagation
**Files**: Database layer, managers

**Issues**:
- Database operations don't use `context.Context`
- Cannot implement request timeouts or cancellation
- No request tracing support

**Impact**: Cannot cancel long-running queries, harder to debug

**Action Items**:
1. Add `context.Context` parameter to all database methods
2. Pass request context from HTTP handlers to database layer
3. Add context timeouts for database operations
4. Consider adding request ID middleware for tracing

**Estimated Effort**: 6-8 hours

### 10. Inconsistent Logging
**Files**: Throughout codebase

**Issues**:
- Mix of `log.Print()`, `log.Printf()`, `fmt.Println()`
- No structured logging
- No log levels

**Impact**: Hard to filter and analyze logs in production

**Action Items**:
1. Standardize on structured logging library (e.g., `zap` or `logrus`)
2. Replace all `log.Print()` and `fmt.Println()` calls
3. Add log levels (DEBUG, INFO, WARN, ERROR)
4. Include request context in logs

**Estimated Effort**: 4-6 hours

---

## Implementation Order Recommendation

1. **Week 1**: Critical error handling fixes (#1)
2. **Week 1**: Quick wins - deprecated ioutil (#2) and Swagger metadata (#4)
3. **Week 2**: Database pooling (#3) and Sentry config (#5)
4. **Week 2-3**: Graceful shutdown (#6) and JSON helpers standardization (#7)
5. **Week 3-4**: Input validation (#8)
6. **Future**: Context propagation (#9) and logging improvements (#10)

## Notes

- All changes should maintain backward compatibility with existing API
- Test coverage should be maintained or improved with each change
- Consider creating GitHub issues for tracking each item
- Prioritize items that affect production stability and reliability
