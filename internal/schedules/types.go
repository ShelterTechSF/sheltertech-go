package schedules

import (
	"github.com/sheltertechsf/sheltertech-go/internal/db"
)

type Schedule struct {
	Id           int            `json:"id"`
	ScheduleDays []*ScheduleDay `json:"schedule_days"`
	HoursKnown   bool           `json:"hours_known"`
}

type ScheduleDay struct {
	Id        int     `json:"id"`
	Day       string  `json:"day"`
	OpensAt   *int    `json:"opens_at"`
	ClosesAt  *int    `json:"closes_at"`
	OpenTime  *string `json:"open_time"`
	OpenDay   *string `json:"open_day"`
	CloseTime *string `json:"close_time"`
	CloseDay  *string `json:"close_day"`
}

func FromDBType(dbSchedule *db.Schedule) *Schedule {
	schedule := &Schedule{
		Id:           dbSchedule.Id,
		HoursKnown:   dbSchedule.HoursKnown,
		ScheduleDays: FromDBTypeArray(dbSchedule.ScheduleDays),
	}
	return schedule
}

func FromDBTypeArray(dbScheduleDays []*db.ScheduleDay) []*ScheduleDay {
	scheduleDays := []*ScheduleDay{}
	for _, scheduleDay := range dbScheduleDays {
		scheduleDays = append(scheduleDays, FromScheduleDayDBType(scheduleDay))
	}
	return scheduleDays
}

func FromScheduleDayDBType(dbScheduleDay *db.ScheduleDay) *ScheduleDay {
	scheduleDay := &ScheduleDay{
		Id:  dbScheduleDay.Id,
		Day: dbScheduleDay.Day,
	}
	if dbScheduleDay.OpensAt.Valid {
		opensAt := int(dbScheduleDay.OpensAt.Int32)
		scheduleDay.OpensAt = &opensAt
	}
	if dbScheduleDay.ClosesAt.Valid {
		closesAt := int(dbScheduleDay.ClosesAt.Int32)
		scheduleDay.ClosesAt = &closesAt
	}
	if dbScheduleDay.OpenTime.Valid {
		openTime := dbScheduleDay.OpenTime.Time.String()
		scheduleDay.OpenTime = &openTime
	}
	if dbScheduleDay.OpenDay.Valid {
		scheduleDay.OpenDay = &dbScheduleDay.OpenDay.String
	}
	if dbScheduleDay.CloseTime.Valid {
		closeTime := dbScheduleDay.CloseTime.Time.String()
		scheduleDay.CloseTime = &closeTime
	}
	if dbScheduleDay.CloseDay.Valid {
		scheduleDay.CloseDay = &dbScheduleDay.CloseDay.String
	}
	return scheduleDay
}
