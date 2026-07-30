package auth

import (
	"crypto/rand"
	"crypto/rsa"
	"encoding/base64"
	"encoding/json"
	"fmt"
	"math/big"
	"net/http"
	"net/http/httptest"
	"testing"
	"time"

	"github.com/MicahParks/keyfunc/v3"
	"github.com/golang-jwt/jwt/v5"
)

const testKeyId = "test-key"

// newTestKeyfunc returns an RSA signing key and a Keyfunc backed by an in-memory JWK Set holding
// the matching public key, so JWT validation can be exercised without a network round trip.
func newTestKeyfunc(t *testing.T) (*rsa.PrivateKey, keyfunc.Keyfunc) {
	t.Helper()

	privateKey, err := rsa.GenerateKey(rand.Reader, 2048)
	if err != nil {
		t.Fatalf("failed to generate RSA key: %v", err)
	}

	jwkSet := fmt.Sprintf(
		`{"keys":[{"kty":"RSA","use":"sig","alg":"RS256","kid":%q,"n":%q,"e":%q}]}`,
		testKeyId,
		base64.RawURLEncoding.EncodeToString(privateKey.N.Bytes()),
		base64.RawURLEncoding.EncodeToString(big.NewInt(int64(privateKey.E)).Bytes()),
	)

	jwtKeyfunc, err := keyfunc.NewJWKSetJSON(json.RawMessage(jwkSet))
	if err != nil {
		t.Fatalf("failed to build keyfunc: %v", err)
	}

	return privateKey, jwtKeyfunc
}

func signTestToken(t *testing.T, privateKey *rsa.PrivateKey, subject string) string {
	t.Helper()

	token := jwt.NewWithClaims(jwt.SigningMethodRS256, jwt.RegisteredClaims{
		Subject:   subject,
		ExpiresAt: jwt.NewNumericDate(time.Now().Add(time.Hour)),
		IssuedAt:  jwt.NewNumericDate(time.Now()),
	})
	token.Header["kid"] = testKeyId

	signed, err := token.SignedString(privateKey)
	if err != nil {
		t.Fatalf("failed to sign token: %v", err)
	}
	return signed
}

func TestRequireIdentityStoresIdentityInContext(t *testing.T) {
	privateKey, jwtKeyfunc := newTestKeyfunc(t)

	var gotSubject string
	handler := RequireIdentity(jwtKeyfunc)(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		identity, err := IdentityFromContext(r.Context())
		if err != nil {
			t.Errorf("IdentityFromContext() error = %v", err)
			return
		}
		gotSubject = identity.Subject
	}))

	req := httptest.NewRequest("POST", "/api/users", nil)
	req.Header.Set("Authorization", "Bearer "+signTestToken(t, privateKey, "auth0|abc"))
	recorder := httptest.NewRecorder()

	handler.ServeHTTP(recorder, req)

	if recorder.Code != http.StatusOK {
		t.Errorf("status = %d, want %d, body: %s", recorder.Code, http.StatusOK, recorder.Body.String())
	}
	if gotSubject != "auth0|abc" {
		t.Errorf("identity subject = %q, want %q", gotSubject, "auth0|abc")
	}
}

func TestRequireIdentityRejectsBadCredentials(t *testing.T) {
	privateKey, jwtKeyfunc := newTestKeyfunc(t)
	otherKey, _ := newTestKeyfunc(t)

	tests := []struct {
		name       string
		jwtKeyfunc keyfunc.Keyfunc
		authHeader string
	}{
		{
			name:       "no Authorization header",
			jwtKeyfunc: jwtKeyfunc,
		},
		{
			name:       "malformed Authorization header",
			jwtKeyfunc: jwtKeyfunc,
			authHeader: signTestToken(t, privateKey, "auth0|abc"),
		},
		{
			name:       "token is not a JWT",
			jwtKeyfunc: jwtKeyfunc,
			authHeader: "Bearer dummy-token",
		},
		{
			name:       "token signed by an unknown key",
			jwtKeyfunc: jwtKeyfunc,
			authHeader: "Bearer " + signTestToken(t, otherKey, "auth0|abc"),
		},
		{
			name:       "JWT verification not configured",
			jwtKeyfunc: nil,
			authHeader: "Bearer " + signTestToken(t, privateKey, "auth0|abc"),
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			handler := RequireIdentity(tt.jwtKeyfunc)(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
				t.Error("next handler should not be reached")
			}))

			req := httptest.NewRequest("POST", "/api/users", nil)
			if tt.authHeader != "" {
				req.Header.Set("Authorization", tt.authHeader)
			}
			recorder := httptest.NewRecorder()

			handler.ServeHTTP(recorder, req)

			if recorder.Code != http.StatusBadRequest {
				t.Errorf("status = %d, want %d", recorder.Code, http.StatusBadRequest)
			}

			apiError := struct {
				Error string `json:"error"`
			}{}
			if err := json.Unmarshal(recorder.Body.Bytes(), &apiError); err != nil {
				t.Fatalf("failed to unmarshal body %q: %v", recorder.Body.String(), err)
			}
			if apiError.Error == "" {
				t.Errorf("response body %q should carry an error message", recorder.Body.String())
			}
		})
	}
}

func TestWithOptionalUserDoesNotRejectRequests(t *testing.T) {
	privateKey, jwtKeyfunc := newTestKeyfunc(t)

	tests := []struct {
		name       string
		jwtKeyfunc keyfunc.Keyfunc
		authHeader string
	}{
		{
			name:       "no Authorization header",
			jwtKeyfunc: jwtKeyfunc,
		},
		{
			name:       "token is not a JWT",
			jwtKeyfunc: jwtKeyfunc,
			authHeader: "Bearer dummy-token",
		},
		{
			name:       "JWT verification not configured",
			jwtKeyfunc: nil,
			authHeader: "Bearer " + signTestToken(t, privateKey, "auth0|abc"),
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			reached := false
			handler := WithOptionalUser(tt.jwtKeyfunc, nil)(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
				reached = true
				if _, err := UserFromContext(r.Context()); err == nil {
					t.Error("UserFromContext() should not resolve a user for an unauthenticated request")
				}
			}))

			req := httptest.NewRequest("GET", "/api/users/current", nil)
			if tt.authHeader != "" {
				req.Header.Set("Authorization", tt.authHeader)
			}
			recorder := httptest.NewRecorder()

			handler.ServeHTTP(recorder, req)

			if !reached {
				t.Error("next handler should have been reached")
			}
			if recorder.Code != http.StatusOK {
				t.Errorf("status = %d, want %d", recorder.Code, http.StatusOK)
			}
		})
	}
}
