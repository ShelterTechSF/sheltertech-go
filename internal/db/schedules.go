package db

import (
	"database/sql"
	"fmt"
	"log"
)

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

const scheduleByServiceIDSql = `
SELECT s.id, s.hours_known
FROM public.schedules s
WHERE s.service_id = $1 LIMIT 1
`

const scheduleByResourceIDSql = `
SELECT s.id, s.hours_known
FROM public.schedules s
WHERE s.resource_id = $1 LIMIT 1
`

const scheduleDaysByScheduleIDSql = `
SELECT sd.id, sd.day, sd.opens_at, sd.closes_at, sd.open_time, sd.open_day, sd.close_time, sd.close_day
FROM public.schedule_days sd
WHERE sd.schedule_id = $1
`

func (m *Manager) GetScheduleByServiceId(serviceId int) *Schedule {
	row := m.DB.QueryRow(scheduleByServiceIDSql, serviceId)
	schedule := scanSchedule(row)
	schedule.ScheduleDays = m.GetScheduleDaysByScheduleID(schedule.Id)
	return schedule
}

func (m *Manager) GetScheduleByResourceId(resourceId int) *Schedule {
	row := m.DB.QueryRow(scheduleByResourceIDSql, resourceId)
	schedule := scanSchedule(row)
	schedule.ScheduleDays = m.GetScheduleDaysByScheduleID(schedule.Id)
	return schedule
}

func (m *Manager) GetScheduleDaysByScheduleID(scheduleId int) []*ScheduleDay {
	var rows *sql.Rows
	var err error
	rows, err = m.DB.Query(scheduleDaysByScheduleIDSql, scheduleId)
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanScheduleDays(rows)
}

func scanScheduleDays(rows *sql.Rows) []*ScheduleDay {
	var scheduleDays []*ScheduleDay
	for rows.Next() {
		var scheduleDay ScheduleDay
		err := rows.Scan(&scheduleDay.Id, &scheduleDay.Day, &scheduleDay.OpensAt, &scheduleDay.ClosesAt, &scheduleDay.OpenTime, &scheduleDay.OpenDay, &scheduleDay.CloseTime, &scheduleDay.CloseDay)
		switch err {
		case sql.ErrNoRows:
			fmt.Println("No rows were returned!")
			return nil
		}
		scheduleDays = append(scheduleDays, &scheduleDay)
	}
	return scheduleDays
}

func scanSchedule(row *sql.Row) *Schedule {
	var schedule Schedule
	err := row.Scan(&schedule.Id, &schedule.HoursKnown)
	if err != nil {
		switch err {
		case sql.ErrNoRows:
			fmt.Println("No rows were returned!")
			return nil
		default:
			panic(err)
		}
	}
	return &schedule
}
