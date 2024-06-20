package db

import (
	"database/sql"
	"time"
)

type Category struct {
	Id         int
	Name       string
	TopLevel   bool
	Vocabulary string
	Featured   bool
}

type ChangeRequest struct {
	Id         int
	Type       string
	ObjectId   int
	Status     int
	Action     int
	ResourceId int
	CreatedAt  sql.NullTime
	UpdatedAt  sql.NullTime
}

type Bookmark struct {
	Id int
	Order int
	FolderID int
	ServiceID int
	ResourceID int
	UserID int
	CreatedAt  sql.NullTime
	UpdatedAt  sql.NullTime
}

type Service struct {
	Id                     int
	CreatedAt              time.Time
	UpdatedAt              time.Time
	Name                   sql.NullString
	LongDescription        sql.NullString
	Eligibility            sql.NullString
	RequiredDocuments      sql.NullString
	Fee                    sql.NullString
	ApplicationProcess     sql.NullString
	ResourceId             sql.NullInt32
	VerifiedAt             *time.Time
	Email                  sql.NullString
	Status                 sql.NullInt32
	Certified              bool
	ProgramId              sql.NullInt32
	InterpretationServices sql.NullString
	Url                    sql.NullString
	WaitTime               sql.NullString
	ContactId              sql.NullInt32
	FundingId              sql.NullInt32
	AlternateName          sql.NullString
	CertifiedAt            *time.Time
	Featured               sql.NullBool
	SourceAttribution      sql.NullInt32
	InternalNote           sql.NullString
	ShortDescription       sql.NullString
}

type Note struct {
	Id         int
	Note       sql.NullString
	ResourceId sql.NullInt32
	ServiceId  sql.NullInt32
	CreatedAt  sql.NullTime
	UpdatedAt  sql.NullTime
}

type Address struct {
	Id             int
	Attention      sql.NullString
	Address1       string
	Address2       sql.NullString
	Address3       sql.NullString
	Address4       sql.NullString
	City           string
	StateProvince  string
	PostalCode     string
	ResourceId     sql.NullInt32
	Latitude       sql.NullFloat64
	Longitude      sql.NullFloat64
	Online         sql.NullBool
	Region         sql.NullString
	Name           sql.NullString
	Description    sql.NullString
	Transportation sql.NullString
	CreatedAt      time.Time
	UpdatedAt      time.Time
}
type Eligibility struct {
	Id          int
	Name        sql.NullString
	FeatureRank sql.NullInt32
	CreatedAt   time.Time
	UpdatedAt   time.Time
}
type Instruction struct {
	Id          int
	Instruction sql.NullString
	CreatedAt   time.Time
	UpdatedAt   time.Time
}
type Document struct {
	Id          int
	Name        sql.NullString
	Url         sql.NullString
	Description sql.NullString
	CreatedAt   time.Time
	UpdatedAt   time.Time
}
type Resource struct {
	Id                int
	AlternateName     sql.NullString
	Certified         sql.NullBool
	Email             sql.NullString
	LegalStatus       sql.NullString
	LongDescription   sql.NullString
	Name              string
	ShortDescription  sql.NullString
	Status            sql.NullString
	VerifiedAt        *time.Time
	Website           sql.NullString
	CertifiedAt       *time.Time
	Featured          sql.NullBool
	SourceAttribution sql.NullString
	InternalNote      sql.NullString
	CreatedAt         time.Time
	UpdatedAt         time.Time
	ContactId         sql.NullInt32
	FundingId         sql.NullInt32
}
type Program struct {
	Id            int
	Name          sql.NullString
	AlternateName sql.NullString
	Description   sql.NullString
	CreatedAt     sql.NullTime
	UpdatedAt     sql.NullTime
}

type Phone struct {
	Id          int
	Number      string
	ServiceType string
}

type Schedule struct {
	Id         int
	HoursKnown bool

	ScheduleDays []*ScheduleDay
}

type ScheduleDay struct {
	Id        int
	Day       string
	OpensAt   sql.NullInt32
	ClosesAt  sql.NullInt32
	OpenTime  sql.NullTime
	OpenDay   sql.NullString
	CloseTime sql.NullTime
	CloseDay  sql.NullString
}
type CategoryCount struct {
	CategoryName string
	Count        int
}

type Folder struct {
	Id     int
	Name   string
	Order  int
	UserId int
}

type User struct {
	Id             int
	Name           string
	Organization   string
	UserExternalId string
	Email          string
}
