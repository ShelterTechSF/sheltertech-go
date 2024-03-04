package eligibilities

import "github.com/sheltertechsf/sheltertech-go/internal/db"

type Eligibility struct {
	Id int `json:"id"`
}

func FromEligibilityDBType(dbEligibility *db.Eligibility) *Eligibility {
	eligibility := &Eligibility{
		Id: dbEligibility.Id,
	}
	return eligibility
}

func FromEligibilitiesDBTypeArray(dbEligibilities []*db.Eligibility) []*Eligibility {
	eligibilities := []*Eligibility{}
	for _, dbEligibility := range dbEligibilities {
		eligibilities = append(eligibilities, FromEligibilityDBType(dbEligibility))
	}
	return eligibilities
}
