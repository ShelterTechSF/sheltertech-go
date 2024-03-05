package phones

import "github.com/sheltertechsf/sheltertech-go/internal/db"

type Phone struct {
	Id          int    `json:"id"`
	Number      string `json:"number"`
	ServiceType string `json:"service_type"`
	Extension   string `json:"extension"`
	CountryCode string `json:"country_code"`
}

func FromDBTypeArray(dbPhones []*db.Phone) []*Phone {
	phones := []*Phone{}
	for _, dbPhone := range dbPhones {
		phones = append(phones, FromDBType(dbPhone))
	}
	return phones
}

func FromDBType(dbPhone *db.Phone) *Phone {
	phone := &Phone{
		Id:          dbPhone.Id,
		Number:      dbPhone.Number,
		ServiceType: dbPhone.ServiceType,
		Extension:   "test",
		CountryCode: "test",
	}
	return phone
}
