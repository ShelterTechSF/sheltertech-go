package eligibilities

import "github.com/sheltertechsf/sheltertech-go/internal/db"

type Eligibility struct {
	Id          int     `json:"id"`
	Name        *string `json:"name"`
	FeatureRank *int    `json:"feature_rank"`
}

func FromEligibilityDBType(dbEligibility *db.Eligibility) *Eligibility {
	eligibility := &Eligibility{
		Id: dbEligibility.Id,
	}
	if dbEligibility.Name.Valid {
		eligibility.Name = &dbEligibility.Name.String
	}
	if dbEligibility.FeatureRank.Valid {
		featureRank := int(dbEligibility.FeatureRank.Int32)
		eligibility.FeatureRank = &featureRank
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