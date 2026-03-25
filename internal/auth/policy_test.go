package auth

import (
	"testing"

	"github.com/sheltertechsf/sheltertech-go/internal/db"
)

func TestCanModify(t *testing.T) {
	tests := []struct {
		name        string
		user        *db.User
		ownerUserId int
		want        bool
	}{
		{
			name:        "user owns the resource",
			user:        &db.User{Id: 1},
			ownerUserId: 1,
			want:        true,
		},
		{
			name:        "user does not own the resource",
			user:        &db.User{Id: 1},
			ownerUserId: 2,
			want:        false,
		},
		{
			name:        "zero value user id does not match non-zero owner",
			user:        &db.User{Id: 0},
			ownerUserId: 1,
			want:        false,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			got := CanModify(tt.user, tt.ownerUserId)
			if got != tt.want {
				t.Errorf("CanModify() = %v, want %v", got, tt.want)
			}
		})
	}
}
