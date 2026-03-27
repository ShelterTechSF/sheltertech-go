package auth

import "github.com/sheltertechsf/sheltertech-go/internal/db"

// CanModify returns true if the user is permitted to modify a resource
// owned by ownerUserId.
//
// To add RBAC later: add a role check here only — no handler changes needed.
// Example:
//
//	if user.Role == "admin" { return true }
func CanModify(user *db.User, ownerUserId int) bool {
	return user.Id == ownerUserId
}
