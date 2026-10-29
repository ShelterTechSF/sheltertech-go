package searchindex

import (
	"context"
	"database/sql"
	"encoding/json"
	"fmt"
	"time"
)

// RebuildService mirrors the attributes in askdarcel-api/app/models/service.rb.
// Read all associations in one statement so the record comes from one Postgres
// snapshot. It deliberately does not reuse the public API's abbreviated DTOs.
func RebuildService(ctx context.Context, database *sql.DB, index Indexer, id int) error {
	if _, disabled := index.(NoopIndexer); disabled {
		return nil
	}
	var raw []byte
	if err := database.QueryRowContext(ctx, serviceIndexSQL, id).Scan(&raw); err != nil {
		return err
	}
	var source serviceIndexSource
	if err := json.Unmarshal(raw, &source); err != nil {
		return err
	}
	if source.Service["status"] != float64(1) {
		return index.DeleteObject(ServiceObjectID(id))
	}
	record, err := source.record(id)
	if err != nil {
		return err
	}
	return index.SaveObject(ServiceObjectID(id), record)
}

type indexAddress struct {
	City          *string  `json:"city"`
	StateProvince *string  `json:"state_province"`
	PostalCode    *string  `json:"postal_code"`
	Address1      *string  `json:"address_1"`
	Latitude      *float64 `json:"latitude"`
	Longitude     *float64 `json:"longitude"`
}

type indexScheduleDay struct {
	Day      string `json:"day"`
	OpensAt  *int   `json:"opens_at"`
	ClosesAt *int   `json:"closes_at"`
}

type indexSchedule struct {
	Days []indexScheduleDay `json:"days"`
}

type serviceIndexSource struct {
	Service           map[string]interface{} `json:"service"`
	ResourceName      *string                `json:"resource_name"`
	Addresses         []indexAddress         `json:"addresses"`
	ResourceAddresses []indexAddress         `json:"resource_addresses"`
	Schedule          *indexSchedule         `json:"schedule"`
	ResourceSchedule  *indexSchedule         `json:"resource_schedule"`
	Notes             []*string              `json:"notes"`
	Categories        []*string              `json:"categories"`
	BoostedCategory   *string                `json:"boosted_category"`
	Eligibilities     []*string              `json:"eligibilities"`
	Phones            []interface{}          `json:"phones"`
	AssociatedSites   []*string              `json:"associated_sites"`
	Documents         []interface{}          `json:"documents"`
	Instructions      []*string              `json:"instructions"`
}

func (s serviceIndexSource) record(id int) (map[string]interface{}, error) {
	// Rails starts with every Service column, including nulls.
	r := make(map[string]interface{}, len(s.Service))
	for key, value := range s.Service {
		r[key] = value
	}
	for _, name := range []string{"created_at", "updated_at", "certified_at", "verified_at"} {
		if value, ok := r[name].(string); ok {
			parsed, err := time.Parse("2006-01-02T15:04:05.999999999", value)
			if err != nil {
				return nil, fmt.Errorf("service %d %s: %w", id, name, err)
			}
			r[name] = parsed.UTC().Format("2006-01-02T15:04:05.000Z")
		}
	}
	r["status"] = "approved"
	switch r["source_attribution"] {
	case float64(0):
		r["source_attribution"] = "ask_darcel"
	case float64(1):
		r["source_attribution"] = "service_net"
	}
	r["objectID"], r["type"], r["service_id"] = ServiceObjectID(id), "service", id
	r["service_of"] = s.ResourceName
	r["notes"], r["categories"], r["eligibilities"] = s.Notes, s.Categories, s.Eligibilities
	r["boosted_category"] = s.BoostedCategory
	r["phones"], r["associated_sites"] = s.Phones, s.AssociatedSites
	r["documents"], r["instructions"] = s.Documents, s.Instructions
	r["is_mohcd_funded"] = false
	for _, category := range s.Categories {
		if category != nil && *category == "MOHCD Funded" {
			r["is_mohcd_funded"] = true
		}
	}

	addresses := s.Addresses
	if len(addresses) == 0 {
		addresses = s.ResourceAddresses
	}
	// Rails returns null when neither the service nor its resource has addresses.
	var addressRecords []map[string]interface{}
	for _, a := range addresses {
		addressRecords = append(addressRecords, map[string]interface{}{
			"city": a.City, "state_province": a.StateProvince, "postal_code": a.PostalCode,
			"country": "USA", "address_1": a.Address1,
			"latitude": coordinate(a.Latitude), "longitude": coordinate(a.Longitude),
		})
	}
	r["addresses"] = addressRecords
	r["_geoloc"] = map[string]float64{"lat": 0, "lng": 0}
	if len(s.Addresses) > 0 {
		geolocations := make([]interface{}, 0, len(s.Addresses))
		for _, a := range s.Addresses {
			var location interface{}
			if a.Latitude != nil && a.Longitude != nil {
				location = map[string]float64{"lat": *a.Latitude, "lng": *a.Longitude}
			}
			geolocations = append(geolocations, location)
		}
		r["_geoloc"] = geolocations
	} else if len(s.ResourceAddresses) > 0 {
		a := s.ResourceAddresses[0]
		if a.Latitude != nil && a.Longitude != nil {
			r["_geoloc"] = map[string]float64{"lat": *a.Latitude, "lng": *a.Longitude}
		}
	}

	r["schedule"], r["resource_schedule"] = nil, nil
	if s.ResourceSchedule != nil {
		r["schedule"], r["resource_schedule"] = s.ResourceSchedule.Days, s.ResourceSchedule.Days
	}
	if s.Schedule != nil {
		r["schedule"] = s.Schedule.Days
	}
	useResource := s.Schedule == nil || len(s.Schedule.Days) == 0
	r["use_resource_schedule"] = useResource
	openSchedule := s.Schedule
	if useResource {
		openSchedule = s.ResourceSchedule
	}
	r["open_times"] = nil
	if openSchedule != nil {
		openTimes, err := openSchedule.openTimes()
		if err != nil {
			return nil, err
		}
		r["open_times"] = openTimes
	}
	return r, nil
}

func coordinate(value *float64) float64 {
	if value == nil {
		return 0 // Rails nil.to_f
	}
	return *value
}

func (s indexSchedule) openTimes() ([]string, error) {
	abbreviations := map[string]string{"Monday": "M", "Tuesday": "Tu", "Wednesday": "W", "Thursday": "Th", "Friday": "F", "Saturday": "Sa", "Sunday": "Su"}
	result := []string{}
	for _, day := range s.Days {
		if day.OpensAt == nil || day.ClosesAt == nil {
			continue
		}
		start := (*day.OpensAt/100*60 + *day.OpensAt%100) / 30 * 30
		end := ((*day.ClosesAt/100*60 + *day.ClosesAt%100 + 29) / 30) * 30
		for minute := start; minute < end; minute += 30 {
			abbreviation, ok := abbreviations[day.Day]
			if !ok {
				return nil, fmt.Errorf("invalid schedule day %q", day.Day)
			}
			result = append(result, fmt.Sprintf("%s-%d:%02d", abbreviation, (minute/60)%24, minute%60))
		}
	}
	return result, nil
}

// Association queries follow Rails' scopes (no additional sorting or filtering).
// Returning the complete row matches algoliasearch-rails' default attributes.
const serviceIndexSQL = `
SELECT json_build_object(
  'service', row_to_json(s), 'resource_name', r.name,
  'addresses', COALESCE((SELECT json_agg(a) FROM public.addresses a
    INNER JOIN public.addresses_services j ON a.id = j.address_id WHERE j.service_id = s.id), '[]'),
  'resource_addresses', COALESCE((SELECT json_agg(a) FROM public.addresses a WHERE a.resource_id = r.id), '[]'),
  'schedule', (SELECT json_build_object('days', COALESCE((SELECT json_agg(json_build_object(
    'day', d.day, 'opens_at', d.opens_at, 'closes_at', d.closes_at))
    FROM public.schedule_days d WHERE d.schedule_id = sc.id), '[]'))
    FROM public.schedules sc WHERE sc.service_id = s.id LIMIT 1),
  'resource_schedule', (SELECT json_build_object('days', COALESCE((SELECT json_agg(json_build_object(
    'day', d.day, 'opens_at', d.opens_at, 'closes_at', d.closes_at))
    FROM public.schedule_days d WHERE d.schedule_id = sc.id), '[]'))
    FROM public.schedules sc WHERE sc.resource_id = r.id LIMIT 1),
  'notes', COALESCE((SELECT json_agg(n.note) FROM public.notes n WHERE n.service_id = s.id), '[]'),
  'categories', COALESCE((SELECT json_agg(c.name) FROM public.categories c
    INNER JOIN public.categories_services j ON c.id = j.category_id WHERE j.service_id = s.id), '[]'),
  'boosted_category', (SELECT name FROM public.categories WHERE id = s.boosted_category_id),
  'eligibilities', COALESCE((SELECT json_agg(e.name) FROM public.eligibilities e
    INNER JOIN public.eligibilities_services j ON e.id = j.eligibility_id WHERE j.service_id = s.id), '[]'),
  'phones', COALESCE((SELECT json_agg(json_build_object('number', p.number, 'service_type', p.service_type))
    FROM public.phones p WHERE p.resource_id = r.id), '[]'),
  'associated_sites', COALESCE((SELECT json_agg(st.site_code) FROM public.sites st
    INNER JOIN public.resources_sites j ON st.id = j.site_id WHERE j.resource_id = r.id), '[]'),
  'documents', COALESCE((SELECT json_agg(json_build_object('id', d.id, 'url', d.url, 'description', d.description))
    FROM public.documents d INNER JOIN public.documents_services j ON d.id = j.document_id WHERE j.service_id = s.id), '[]'),
  'instructions', COALESCE((SELECT json_agg(i.instruction) FROM public.instructions i WHERE i.service_id = s.id), '[]')
)
FROM public.services s INNER JOIN public.resources r ON r.id = s.resource_id
WHERE s.id = $1
`
