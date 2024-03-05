package schedules

import "github.com/sheltertechsf/sheltertech-go/internal/db"

type Schedule struct {
	Id         int  `json:"id"`
	HoursKnown bool `json:"hours_known"`

	ScheduleDays []ScheduleDay `json:"schedule_days"`
}

type ScheduleDay struct {
	Id  int    `json:"id"`
	Day string `json:"day"`
}

func FromDBType(dbSchedule *db.Schedule) *Schedule {
	schedule := &Schedule{
		Id:           dbSchedule.Id,
		HoursKnown:   dbSchedule.HoursKnown,
		ScheduleDays: []ScheduleDay{},
	}
	return schedule
}
