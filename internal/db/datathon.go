package db

import (
	"database/sql"
	"fmt"
	"time"
)

type DatathonData struct {
	ServiceId        int
	ServiceName      sql.NullString
	ResourceId       int
	ResourceName     string
	ResourceWebsite  sql.NullString
	ServiceEmail     sql.NullString
	ServiceUpdatedAt time.Time
}

const contentCurationData = `
SELECT s.id as service_id, s.name as service_name, s.resource_id, r.name, r.website, s.email, s.updated_at
FROM services s
LEFT JOIN resources r
ON s.resource_id = r.id
WHERE (s.id in (select distinct a.service_id from categories_services a
left join services b
on a.service_id = b.id
where a.category_id in (select id from categories where name in ('Food pantries', 'Daily free meals for all', 'Food for children', 'Home-delivered groceries and home-delivered meals','Congregate meals for seniors and people with disabilities', 'Food benefits', 'Emergency Food','Coronavirus (COVID-19) Testing', 'Coronavirus-Related Urgent Care', 'Other Medical Services', 'Mental Health Urgent Care', 'Other Mental Health Services','Showers', 'Laundry', 'Clothing', 'Diaper Bank', 'Hygiene kits', 'Portable Toilets and Hand-Washing Stations', 'I am under 18 years old.', 'I am between 18 and 24 years old.', 'I am over 24 years old without children.', 'We are a family with children under 18 years old.', 'I am experiencing homelessness and I need immediate help finding shelter.', 'I am experiencing homelessness (on the street, couchsurfing, or other) and I need long-term housing assistance.', 'I am not currently experiencing homelessness, but I am looking for a long-term affordable housing unit.', 'My landlord gave me an eviction notice and I need legal help', 'My landlord told me I would get evicted and I need advice', 'I have not been able to pay my rent and I do not know what to do', 'I am not getting along with my neighbor(s) and /or my landlord and I need advice', 'Emergency Financial Assistance', 'Financial assistance for living expenses', 'Unemployment Insurance-based Benefit Payments', 'Job Placement Support', 'Vocational Training Programs', 'Job Board', 'Housing Assistance', 'Legal Assistance', 'Youth Services', 'Counseling Assistance', 'General Help', 'Temporary Shelter for Women', 'Transitional Housing for Women', 'Domestic Violence Counseling', 'Residential Treatment', 'Healthier Habits/Safer Use', 'Pregnancy Wraparound Services', 'Meetings/Support', 'Safe place to sober up', 'Reward Program', 'Medication Treatment', 'Computer or Internet Access', 'Covid-internet', 'Smartphones', 'Help Pay for Internet or Phone', 'Technology'))
and b.status = 1))
AND s.status = 1;
`

const datathonData = `
SELECT s.id as service_id, s.name as service_name, s.resource_id, r.name, r.website, s.email, s.updated_at
FROM services s
LEFT JOIN resources r
ON s.resource_id = r.id
WHERE (s.id NOT in (select distinct a.service_id from categories_services a
left join services b
on a.service_id = b.id
where a.category_id in (select id from categories where name in ('Food pantries', 'Daily free meals for all', 'Food for children', 'Home-delivered groceries and home-delivered meals','Congregate meals for seniors and people with disabilities', 'Food benefits', 'Emergency Food','Coronavirus (COVID-19) Testing', 'Coronavirus-Related Urgent Care', 'Other Medical Services', 'Mental Health Urgent Care', 'Other Mental Health Services','Showers', 'Laundry', 'Clothing', 'Diaper Bank', 'Hygiene kits', 'Portable Toilets and Hand-Washing Stations', 'I am under 18 years old.', 'I am between 18 and 24 years old.', 'I am over 24 years old without children.', 'We are a family with children under 18 years old.', 'I am experiencing homelessness and I need immediate help finding shelter.', 'I am experiencing homelessness (on the street, couchsurfing, or other) and I need long-term housing assistance.', 'I am not currently experiencing homelessness, but I am looking for a long-term affordable housing unit.', 'My landlord gave me an eviction notice and I need legal help', 'My landlord told me I would get evicted and I need advice', 'I have not been able to pay my rent and I do not know what to do', 'I am not getting along with my neighbor(s) and /or my landlord and I need advice', 'Emergency Financial Assistance', 'Financial assistance for living expenses', 'Unemployment Insurance-based Benefit Payments', 'Job Placement Support', 'Vocational Training Programs', 'Job Board', 'Housing Assistance', 'Legal Assistance', 'Youth Services', 'Counseling Assistance', 'General Help', 'Temporary Shelter for Women', 'Transitional Housing for Women', 'Domestic Violence Counseling', 'Residential Treatment', 'Healthier Habits/Safer Use', 'Pregnancy Wraparound Services', 'Meetings/Support', 'Safe place to sober up', 'Reward Program', 'Medication Treatment', 'Computer or Internet Access', 'Covid-internet', 'Smartphones', 'Help Pay for Internet or Phone', 'Technology'))
and b.status = 1))
AND s.status = 1;
`

func (m *Manager) GetContentCurationData() []*DatathonData {
	var rows *sql.Rows
	var err error
	rows, err = m.DB.Query(contentCurationData)
	if err != nil {
	}
	return scanDatathonData(rows)
}

func (m *Manager) GetDatathonData() []*DatathonData {
	var rows *sql.Rows
	var err error
	rows, err = m.DB.Query(datathonData)
	if err != nil {
	}
	return scanDatathonData(rows)
}

func scanDatathonData(rows *sql.Rows) []*DatathonData {
	var records []*DatathonData
	for rows.Next() {
		var record DatathonData
		err := rows.Scan(&record.ServiceId, &record.ServiceName, &record.ResourceId, &record.ResourceId, &record.ResourceWebsite, &record.ServiceEmail, &record.ServiceUpdatedAt)
		switch err {
		case sql.ErrNoRows:
			fmt.Println("No rows were returned!")
			return nil
		}
		records = append(records, &record)
	}
	return records
}
