// middleware/jwt.go

package auth

import (
	"context"
	"encoding/json"
	"errors"
	"log"
	"net/http"
	"net/url"
	"os"
	"time"

	"github.com/MicahParks/keyfunc/v3"
	jwtmiddleware "github.com/auth0/go-jwt-middleware/v2"
	"github.com/auth0/go-jwt-middleware/v2/jwks"
	"github.com/auth0/go-jwt-middleware/v2/validator"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
)

// CustomClaims contains custom data we want from the token.
type CustomClaims struct {
	Scope string `json:"scope"`
}

// Validate does nothing for this example, but we need
// it to satisfy validator.CustomClaims interface.
func (c CustomClaims) Validate(ctx context.Context) error {
	return nil
}

// EnsureValidToken is a middleware that will check the validity of our JWT.
func EnsureValidToken() func(next http.Handler) http.Handler {
	issuerURL, err := url.Parse("https://" + os.Getenv("AUTH0_DOMAIN") + "/")
	if err != nil {
		log.Fatalf("Failed to parse the issuer url: %v", err)
	}

	provider := jwks.NewCachingProvider(issuerURL, 5*time.Minute)

	jwtValidator, err := validator.New(
		provider.KeyFunc,
		validator.RS256,
		issuerURL.String(),
		[]string{os.Getenv("AUTH0_AUDIENCE")},
		validator.WithCustomClaims(
			func() validator.CustomClaims {
				return &CustomClaims{}
			},
		),
		validator.WithAllowedClockSkew(time.Minute),
	)
	if err != nil {
		log.Fatalf("Failed to set up the jwt validator")
	}

	errorHandler := func(w http.ResponseWriter, r *http.Request, err error) {
		log.Printf("Encountered error while validating JWT: %v", err)

		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusUnauthorized)
		w.Write([]byte(`{"message":"Failed to validate JWT."}`))
	}

	middleware := jwtmiddleware.New(
		jwtValidator.ValidateToken,
		jwtmiddleware.WithErrorHandler(errorHandler),
	)

	return func(next http.Handler) http.Handler {
		return middleware.CheckJWT(next)
	}
}

// RequireIdentity is a middleware that validates the request's JWT and stores the resulting token
// identity in the request context, where handlers can read it with IdentityFromContext. Use it for
// flows that have JWT credentials but may not have a DB user yet, such as account creation.
func RequireIdentity(jwtKeyfunc keyfunc.Keyfunc) func(next http.Handler) http.Handler {
	return func(next http.Handler) http.Handler {
		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			identity, err := getTokenIdentity(r, jwtKeyfunc)
			if err != nil {
				writeAuthError(w, err.Error())
				return
			}
			next.ServeHTTP(w, r.WithContext(context.WithValue(r.Context(), identityContextKey, identity)))
		})
	}
}

// WithOptionalUser is a middleware that resolves the request's JWT to a DB user and stores it in the
// request context when it can, but never rejects a request. Requests with no credentials, bad
// credentials, or no matching DB user simply reach the handler with no user in the context.
//
// This is for endpoints that must stay reachable while logged out, so callers can check whether
// there is a session without treating the answer as an error. It does NOT enforce authentication:
// handlers behind it are responsible for failing closed when UserFromContext returns an error.
// Endpoints that need enforcement want a rejecting middleware instead.
func WithOptionalUser(jwtKeyfunc keyfunc.Keyfunc, dbManager *db.Manager) func(next http.Handler) http.Handler {
	return func(next http.Handler) http.Handler {
		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			identity, err := getTokenIdentity(r, jwtKeyfunc)
			if err != nil {
				next.ServeHTTP(w, r)
				return
			}

			ctx := context.WithValue(r.Context(), identityContextKey, identity)
			if user := dbManager.GetUserByUserExternalID(identity.Subject); user != nil {
				ctx = ContextWithUser(ctx, user)
			}

			next.ServeHTTP(w, r.WithContext(ctx))
		})
	}
}

// getTokenIdentity validates the request JWT, guarding against an unconfigured keyfunc.
func getTokenIdentity(r *http.Request, jwtKeyfunc keyfunc.Keyfunc) (*TokenIdentity, error) {
	if jwtKeyfunc == nil {
		return nil, errors.New("JWT verification is not configured")
	}
	return GetTokenIdentityFromRequest(r, jwtKeyfunc)
}

// writeAuthError writes the same error response shape the users handlers use.
func writeAuthError(w http.ResponseWriter, message string) {
	output, err := json.Marshal(struct {
		Error string `json:"error"`
	}{Error: message})
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusBadRequest)
	_, _ = w.Write(output)
}
