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
		want    *db.User
		wantErr bool
	}{
		{
			name:    "user exists in context",
			ctx:     context.WithValue(context.Background(), userContextKey, &db.User{Id: 1}),
			want:    &db.User{Id: 1},
			wantErr: false,
		},
		{
			name:    "nothing in context",
			ctx:     context.Background(),
			want:    nil,
			wantErr: true,
		},
		{
			name:    "wrong type in context",
			ctx:     context.WithValue(context.Background(), userContextKey, "not a user"),
			want:    nil,
			wantErr: true,
		},
		{
			name:    "nil user in context",
			ctx:     context.WithValue(context.Background(), userContextKey, (*db.User)(nil)),
			want:    nil,
			wantErr: true,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			got, err := UserFromContext(tt.ctx)
			if (err != nil) != tt.wantErr {
				t.Errorf("UserFromContext() error = %v, wantErr %v", err, tt.wantErr)
				return
			}
			if tt.want != nil && got.Id != tt.want.Id {
				t.Errorf("UserFromContext() = %v, want %v", got, tt.want)
			}
		})
	}
}
