package phones

import (
	"fmt"
	"github.com/nyaruka/phonenumbers"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
	"strconv"
)

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
		ServiceType: dbPhone.ServiceType,
	}
	num, err := phonenumbers.Parse(dbPhone.Number, "")
	if err != nil {
		fmt.Println(err.Error())
	}
	if num.NationalNumber != nil {
		phone.Number = strconv.Itoa(int(*num.NationalNumber))
	}
	if num.Extension != nil {
		phone.Extension = *num.Extension
	}
	phone.CountryCode = phonenumbers.GetRegionCodeForNumber(num)
	return phone
}
