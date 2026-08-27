package auth

import (
	"context"
	"errors"

	"github.com/sheltertechsf/sheltertech-go/internal/db"
)

type contextKey string

const (
	identityContextKey contextKey = "auth.identity"
	userContextKey     contextKey = "auth.user"
)

// ContextWithIdentity returns a new context with the given token identity stored in it, as
// RequireIdentity does at runtime. The context key is unexported, so this is how tests in other
// packages set up a request for a handler that reads IdentityFromContext.
func ContextWithIdentity(ctx context.Context, identity *TokenIdentity) context.Context {
	return context.WithValue(ctx, identityContextKey, identity)
}

// IdentityFromContext retrieves the token identity stored in the request context by RequireIdentity.
func IdentityFromContext(ctx context.Context) (*TokenIdentity, error) {
	identity, ok := ctx.Value(identityContextKey).(*TokenIdentity)
	if !ok || identity == nil {
		return nil, errors.New("No authenticated identity in context")
	}
	return identity, nil
}

// ContextWithUser returns a new context with the given user stored in it, as the auth middleware
// does at runtime. The context key is unexported, so this is how tests in other packages set up a
// request for a handler that reads UserFromContext.
func ContextWithUser(ctx context.Context, user *db.User) context.Context {
	return context.WithValue(ctx, userContextKey, user)
}

// UserFromContext retrieves the DB user stored in the request context by WithOptionalUser. That
// middleware does not enforce authentication, so handlers must fail closed on the error here.
func UserFromContext(ctx context.Context) (*db.User, error) {
	user, ok := ctx.Value(userContextKey).(*db.User)
	if !ok || user == nil {
		return nil, errors.New("No authenticated user in context")
	}
	return user, nil
}
