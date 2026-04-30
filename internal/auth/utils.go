package auth

import (
	"errors"
	"fmt"
	"net/http"
	"strings"

	"github.com/MicahParks/keyfunc/v3"
	"github.com/golang-jwt/jwt/v5"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
)

type TokenIdentity struct {
	Subject string
}

// Parse and return authorization token from HTTP headers
func getAuthToken(r *http.Request) (string, error) {
	authorization := r.Header.Get("Authorization")
	if authorization == "" {
		return "", errors.New("Missing Authorization HTTP header")
	}
	fields := strings.Fields(authorization)
	if len(fields) != 2 || strings.ToLower(fields[0]) != "bearer" {
		return "", errors.New("Authorization header value must follow this format: Bearer access-token")
	}
	return fields[1], nil
}

// Get and validate subject identity fields from the request JWT.
func GetTokenIdentityFromRequest(r *http.Request, keyfunc keyfunc.Keyfunc) (*TokenIdentity, error) {
	tokenString, err := getAuthToken(r)
	if err != nil {
		return nil, err
	}

	token, err := jwt.Parse(tokenString, keyfunc.Keyfunc)
	if err != nil {
		return nil, err
	}
	if !token.Valid {
		return nil, errors.New("Invalid JWT token")
	}

	subject, err := token.Claims.GetSubject()
	if err != nil {
		return nil, err
	}

	return &TokenIdentity{Subject: subject}, nil
}

// Get the DB User corresponding to the HTTP request's Authorization headers.
func GetUserFromRequest(r *http.Request, keyfunc keyfunc.Keyfunc, db *db.Manager) (*db.User, error) {
	identity, err := GetTokenIdentityFromRequest(r, keyfunc)
	if err != nil {
		return nil, err
	}
	user := db.GetUserByUserExternalID(identity.Subject)
	if user == nil {
		return nil, fmt.Errorf("No user with external ID: %s", identity.Subject)
	}
	return user, nil
}
