package auth

import (
	"context"
	"testing"

	"github.com/sheltertechsf/sheltertech-go/internal/db"
)

func TestUserFromContext(t *testing.T) {
	tests := []struct {
		name    string
		ctx     context.Context
		wantId  int
		wantErr bool
	}{
		{
			name:   "user in context",
			ctx:    ContextWithUser(context.Background(), &db.User{Id: 7}),
			wantId: 7,
		},
		{
			name:    "nothing in context",
			ctx:     context.Background(),
			wantErr: true,
		},
		{
			name:    "wrong type in context",
			ctx:     context.WithValue(context.Background(), userContextKey, "not a user"),
			wantErr: true,
		},
		{
			name:    "nil user in context",
			ctx:     ContextWithUser(context.Background(), nil),
			wantErr: true,
		},
		{
			name:    "identity in context but no user",
			ctx:     context.WithValue(context.Background(), identityContextKey, &TokenIdentity{Subject: "auth0|abc"}),
			wantErr: true,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			user, err := UserFromContext(tt.ctx)
			if (err != nil) != tt.wantErr {
				t.Fatalf("UserFromContext() error = %v, wantErr %v", err, tt.wantErr)
			}
			if tt.wantErr {
				if user != nil {
					t.Errorf("UserFromContext() = %v, want nil on error", user)
				}
				return
			}
			if user.Id != tt.wantId {
				t.Errorf("UserFromContext() Id = %d, want %d", user.Id, tt.wantId)
			}
		})
	}
}

func TestIdentityFromContext(t *testing.T) {
	tests := []struct {
		name        string
		ctx         context.Context
		wantSubject string
		wantErr     bool
	}{
		{
			name:        "identity in context",
			ctx:         context.WithValue(context.Background(), identityContextKey, &TokenIdentity{Subject: "auth0|abc"}),
			wantSubject: "auth0|abc",
		},
		{
			name:    "nothing in context",
			ctx:     context.Background(),
			wantErr: true,
		},
		{
			name:    "wrong type in context",
			ctx:     context.WithValue(context.Background(), identityContextKey, "not an identity"),
			wantErr: true,
		},
		{
			name:    "nil identity in context",
			ctx:     context.WithValue(context.Background(), identityContextKey, (*TokenIdentity)(nil)),
			wantErr: true,
		},
		{
			name:    "user in context but no identity",
			ctx:     ContextWithUser(context.Background(), &db.User{Id: 7}),
			wantErr: true,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			identity, err := IdentityFromContext(tt.ctx)
			if (err != nil) != tt.wantErr {
				t.Fatalf("IdentityFromContext() error = %v, wantErr %v", err, tt.wantErr)
			}
			if tt.wantErr {
				if identity != nil {
					t.Errorf("IdentityFromContext() = %v, want nil on error", identity)
				}
				return
			}
			if identity.Subject != tt.wantSubject {
				t.Errorf("IdentityFromContext() Subject = %q, want %q", identity.Subject, tt.wantSubject)
			}
		})
	}
}
