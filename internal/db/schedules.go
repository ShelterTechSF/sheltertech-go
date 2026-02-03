package db

import (
	"database/sql"
	"fmt"
	"log"
)

type Schedule struct {
	Id          int
	HoursKnown  bool
	ResourceId  sql.NullInt32
	ServiceId   sql.NullInt32
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

const scheduleByIDSql = `
SELECT s.id, s.hours_known, s.resource_id, s.service_id
FROM public.schedules s
WHERE s.id = $1
`

const scheduleDayByIDSql = `
SELECT sd.id, sd.day, sd.opens_at, sd.closes_at, sd.open_time, sd.open_day, sd.close_time, sd.close_day, sd.schedule_id
FROM public.schedule_days sd
WHERE sd.id = $1
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
	if schedule != nil {
		schedule.ScheduleDays = m.GetScheduleDaysByScheduleID(schedule.Id)
	}
	return schedule
}

func (m *Manager) GetScheduleByID(scheduleId int) (*Schedule, error) {
	row := m.DB.QueryRow(scheduleByIDSql, scheduleId)
	var s Schedule
	err := row.Scan(&s.Id, &s.HoursKnown, &s.ResourceId, &s.ServiceId)
	if err == sql.ErrNoRows {
		return nil, nil
	}
	if err != nil {
		return nil, err
	}
	s.ScheduleDays = m.GetScheduleDaysByScheduleID(s.Id)
	return &s, nil
}

func (m *Manager) GetScheduleDayByID(id int) (*ScheduleDay, int, error) {
	row := m.DB.QueryRow(scheduleDayByIDSql, id)
	var sd ScheduleDay
	var scheduleID int
	err := row.Scan(&sd.Id, &sd.Day, &sd.OpensAt, &sd.ClosesAt, &sd.OpenTime, &sd.OpenDay, &sd.CloseTime, &sd.CloseDay, &scheduleID)
	if err == sql.ErrNoRows {
		return nil, 0, nil
	}
	if err != nil {
		return nil, 0, err
	}
	return &sd, scheduleID, nil
}

var scheduleDayUpdateAllowed = []string{"day", "opens_at", "closes_at", "open_time", "open_day", "close_time", "close_day"}

func (m *Manager) UpdateScheduleDay(id int, updates map[string]interface{}) error {
	q, args := buildUpdateQuery("schedule_days", "id", id, updates, scheduleDayUpdateAllowed, true)
	if q == "" {
		return nil
	}
	_, err := m.DB.Exec(q, args...)
	return err
}

func (m *Manager) DeleteScheduleDay(id int) error {
	_, err := m.DB.Exec("DELETE FROM public.schedule_days WHERE id = $1", id)
	return err
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
