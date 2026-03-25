package auth

import (
	"context"
	"errors"

	"github.com/sheltertechsf/sheltertech-go/internal/db"
)

// UserFromContext retrieves the authenticated user stored in the request context by EnsureValidToken.
func UserFromContext(ctx context.Context) (*db.User, error) {
	user, ok := ctx.Value(userContextKey).(*db.User)
	if !ok || user == nil {
		return nil, errors.New("no authenticated user in context")
	}
	return user, nil
}

// ContextWithUser returns a new context with the given user stored under the auth context key.
// Intended for use in tests to simulate what EnsureValidToken does at runtime.
func ContextWithUser(ctx context.Context, user *db.User) context.Context {
	return context.WithValue(ctx, userContextKey, user)
}
