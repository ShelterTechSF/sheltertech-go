package auth

import (
	"errors"
	"net/http"
	"strings"

	"github.com/MicahParks/keyfunc/v3"
	"github.com/golang-jwt/jwt/v5"
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
