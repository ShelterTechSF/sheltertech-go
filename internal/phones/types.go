package phones

import (
	"fmt"
	"github.com/nyaruka/phonenumbers"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
)

type Phone struct {
	Id          int     `json:"id"`
	Number      *string `json:"number"`
	Extension   *string `json:"extension"`
	ServiceType string  `json:"service_type"`
	CountryCode *string `json:"country_code"`
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
		ServiceType: dbPhone.ServiceType,
	}
	num, err := phonenumbers.Parse(dbPhone.Number, "US")
	if err != nil {
		fmt.Println(err.Error())
	}
	if num.NationalNumber != nil {
		number := phonenumbers.Format(num, phonenumbers.NATIONAL)
		if number == "" {
			phone.Number = nil
		} else {
			phone.Number = &number
		}
	}
	phone.Extension = num.Extension
	countryCode := phonenumbers.GetRegionCodeForNumber(num)
	if countryCode == "" {
		if phone.Number != nil && (*phone.Number == "311" || *phone.Number == "911" || *phone.Number == "741741" || *phone.Number == "711") {
			usCountry := "US"
			phone.CountryCode = &usCountry
		} else {
			phone.CountryCode = nil
		}
	} else {
		phone.CountryCode = &countryCode
	}
	return phone
}
