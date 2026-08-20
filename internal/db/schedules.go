package db

import (
	"database/sql"
	"fmt"
	"log"
	"strings"
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

type ScheduleDayFieldChangeInput struct {
	FieldName  string
	FieldValue interface{}
}

type ScheduleDayChangeInput struct {
	Day              *string
	OpensAt          *int
	OpensAtProvided  bool
	ClosesAt         *int
	ClosesAtProvided bool
	FieldChanges     []ScheduleDayFieldChangeInput
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

const scheduleDayResourceByIDSql = `
SELECT COALESCE(s.resource_id, sv.resource_id)
FROM public.schedule_days sd
JOIN public.schedules s ON s.id = sd.schedule_id
LEFT JOIN public.services sv ON sv.id = s.service_id
WHERE sd.id = $1
`

const scheduleResourceByIDSql = `
SELECT COALESCE(s.resource_id, sv.resource_id)
FROM public.schedules s
LEFT JOIN public.services sv ON sv.id = s.service_id
WHERE s.id = $1
`

const insertScheduleDaySql = `
INSERT INTO public.schedule_days (schedule_id, day, opens_at, closes_at, created_at, updated_at)
VALUES ($1, $2, $3, $4, now(), now())
RETURNING id
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

func (m *Manager) UpdateScheduleDayChangeRequest(scheduleDayId int, changes ScheduleDayChangeInput) (*int, error) {
	tx, err := m.DB.Begin()
	if err != nil {
		return nil, err
	}
	defer tx.Rollback()

	var resourceId int
	err = tx.QueryRow(scheduleDayResourceByIDSql, scheduleDayId).Scan(&resourceId)
	if err != nil {
		return nil, err
	}

	if changes.deletesExistingScheduleDay() {
		_, err = tx.Exec("DELETE FROM public.schedule_days WHERE id = $1", scheduleDayId)
		if err != nil {
			return nil, err
		}
	} else {
		updateScheduleDaySql, args := buildScheduleDayUpdateSql(scheduleDayId, changes)
		if updateScheduleDaySql != "" {
			_, err = tx.Exec(updateScheduleDaySql, args...)
			if err != nil {
				return nil, err
			}
		}
	}

	var changeRequestId int
	err = tx.QueryRow(
		insertChangeRequestSql,
		"ScheduleDayChangeRequest",
		scheduleDayId,
		StatusPending,
		ActionEdit,
		resourceId,
	).Scan(&changeRequestId)
	if err != nil {
		return nil, err
	}

	err = insertScheduleDayFieldChanges(tx, changeRequestId, changes)
	if err != nil {
		return nil, err
	}

	err = tx.Commit()
	if err != nil {
		return nil, err
	}

	return &changeRequestId, nil
}

func (m *Manager) InsertScheduleDayChangeRequest(scheduleId int, changes ScheduleDayChangeInput) (*int, *int, error) {
	tx, err := m.DB.Begin()
	if err != nil {
		return nil, nil, err
	}
	defer tx.Rollback()

	var resourceId int
	err = tx.QueryRow(scheduleResourceByIDSql, scheduleId).Scan(&resourceId)
	if err != nil {
		return nil, nil, err
	}

	scheduleDayId := 0
	if !changes.deletesExistingScheduleDay() {
		if changes.Day == nil {
			return nil, nil, fmt.Errorf("Missing Required Fields")
		}

		var opensAt interface{}
		if changes.OpensAtProvided && changes.OpensAt != nil {
			opensAt = *changes.OpensAt
		}

		var closesAt interface{}
		if changes.ClosesAtProvided && changes.ClosesAt != nil {
			closesAt = *changes.ClosesAt
		}

		err = tx.QueryRow(
			insertScheduleDaySql,
			scheduleId,
			*changes.Day,
			opensAt,
			closesAt,
		).Scan(&scheduleDayId)
		if err != nil {
			return nil, nil, err
		}
	}

	var changeRequestId int
	err = tx.QueryRow(
		insertChangeRequestSql,
		"ScheduleDayChangeRequest",
		scheduleDayId,
		StatusPending,
		ActionEdit,
		resourceId,
	).Scan(&changeRequestId)
	if err != nil {
		return nil, nil, err
	}

	err = insertScheduleDayFieldChanges(tx, changeRequestId, changes)
	if err != nil {
		return nil, nil, err
	}

	err = tx.Commit()
	if err != nil {
		return nil, nil, err
	}

	return &changeRequestId, &scheduleDayId, nil
}

func (changes ScheduleDayChangeInput) deletesExistingScheduleDay() bool {
	return changes.OpensAtProvided && changes.OpensAt == nil &&
		changes.ClosesAtProvided && changes.ClosesAt == nil
}

func buildScheduleDayUpdateSql(scheduleDayId int, changes ScheduleDayChangeInput) (string, []interface{}) {
	setParts := []string{}
	args := []interface{}{}

	if changes.Day != nil {
		args = append(args, *changes.Day)
		setParts = append(setParts, fmt.Sprintf("day = $%d", len(args)))
	}
	if changes.OpensAtProvided {
		args = append(args, nilableIntValue(changes.OpensAt))
		setParts = append(setParts, fmt.Sprintf("opens_at = $%d", len(args)))
	}
	if changes.ClosesAtProvided {
		args = append(args, nilableIntValue(changes.ClosesAt))
		setParts = append(setParts, fmt.Sprintf("closes_at = $%d", len(args)))
	}
	if len(setParts) == 0 {
		return "", nil
	}

	setParts = append(setParts, "updated_at = now()")
	args = append(args, scheduleDayId)

	query := fmt.Sprintf(
		"UPDATE public.schedule_days SET %s WHERE id = $%d",
		strings.Join(setParts, ", "),
		len(args),
	)
	return query, args
}

func nilableIntValue(value *int) interface{} {
	if value == nil {
		return nil
	}
	return *value
}

func insertScheduleDayFieldChanges(tx *sql.Tx, changeRequestId int, changes ScheduleDayChangeInput) error {
	for _, fieldChange := range changes.FieldChanges {
		_, err := tx.Exec(insertFieldChangeSql, fieldChange.FieldName, fieldChange.FieldValue, changeRequestId)
		if err != nil {
			return err
		}
	}
	return nil
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
