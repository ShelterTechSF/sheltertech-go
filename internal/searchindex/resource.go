package searchindex

import (
	"context"
	"database/sql"
	"encoding/json"
	"fmt"
	"time"
)

// RebuildResource replaces the complete Rails Resource index record after commit.
func RebuildResource(ctx context.Context, database *sql.DB, index Indexer, id int) error {
	if _, disabled := index.(NoopIndexer); disabled {
		return nil
	}
	var raw []byte
	if err := database.QueryRowContext(ctx, resourceIndexSQL, id).Scan(&raw); err != nil {
		return err
	}
	var source resourceIndexSource
	if err := json.Unmarshal(raw, &source); err != nil {
		return err
	}
	if source.Resource["status"] != float64(1) {
		return index.DeleteObject(ResourceObjectID(id))
	}
	record, err := source.record(id)
	if err != nil {
		return err
	}
	return index.SaveObject(ResourceObjectID(id), record)
}

type resourceIndexSource struct {
	Resource        map[string]interface{} `json:"resource"`
	Addresses       []indexAddress         `json:"addresses"`
	Schedule        *indexSchedule         `json:"schedule"`
	Notes           []*string              `json:"notes"`
	Categories      []*string              `json:"categories"`
	Keywords        []*string              `json:"keywords"`
	Services        []interface{}          `json:"services"`
	Phones          []interface{}          `json:"phones"`
	AssociatedSites []*string              `json:"associated_sites"`
}

func (s resourceIndexSource) record(id int) (map[string]interface{}, error) {
	r := make(map[string]interface{}, len(s.Resource))
	for key, value := range s.Resource {
		r[key] = value
	}
	for _, name := range []string{"created_at", "updated_at", "certified_at", "verified_at"} {
		if value, ok := r[name].(string); ok {
			parsed, err := time.Parse("2006-01-02T15:04:05.999999999", value)
			if err != nil {
				return nil, fmt.Errorf("resource %d %s: %w", id, name, err)
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
	r["objectID"], r["type"], r["resource_id"] = ResourceObjectID(id), "resource", id
	r["notes"], r["categories"], r["keywords"] = s.Notes, s.Categories, s.Keywords
	r["services"], r["phones"], r["associated_sites"] = s.Services, s.Phones, s.AssociatedSites
	r["is_mohcd_funded"] = false
	for _, category := range s.Categories {
		if category != nil && *category == "MOHCD Funded" {
			r["is_mohcd_funded"] = true
		}
	}
	addresses := []map[string]interface{}{}
	for _, a := range s.Addresses {
		addresses = append(addresses, map[string]interface{}{"city": a.City, "state_province": a.StateProvince, "postal_code": a.PostalCode, "country": "USA", "address_1": a.Address1, "latitude": coordinate(a.Latitude), "longitude": coordinate(a.Longitude)})
	}
	r["addresses"] = addresses
	location := map[string]float64{"lat": 0, "lng": 0}
	if len(s.Addresses) > 0 {
		location["lat"], location["lng"] = coordinate(s.Addresses[0].Latitude), coordinate(s.Addresses[0].Longitude)
	}
	r["_geoloc"] = location
	r["schedule"], r["open_times"] = nil, nil
	if s.Schedule != nil {
		r["schedule"] = s.Schedule.Days
		openTimes, err := s.Schedule.openTimes()
		if err != nil {
			return nil, err
		}
		r["open_times"] = openTimes
	}
	return r, nil
}

const resourceIndexSQL = `
SELECT json_build_object(
 'resource', row_to_json(r),
 'addresses', COALESCE((SELECT json_agg(a) FROM public.addresses a WHERE a.resource_id = r.id), '[]'),
 'schedule', (SELECT json_build_object('days', COALESCE((SELECT json_agg(json_build_object(
   'day', d.day, 'opens_at', d.opens_at, 'closes_at', d.closes_at))
   FROM public.schedule_days d WHERE d.schedule_id = sc.id), '[]'))
   FROM public.schedules sc WHERE sc.resource_id = r.id LIMIT 1),
 'notes', COALESCE((SELECT json_agg(n.note) FROM public.notes n WHERE n.resource_id = r.id), '[]'),
 'categories', COALESCE((SELECT json_agg(c.name) FROM public.categories c
   INNER JOIN public.categories_resources j ON c.id = j.category_id WHERE j.resource_id = r.id), '[]'),
 'keywords', COALESCE((SELECT json_agg(k.name) FROM public.keywords k
   INNER JOIN public.keywords_resources j ON k.id = j.keyword_id WHERE j.resource_id = r.id), '[]'),
 'services', COALESCE((SELECT json_agg(json_build_object('name', s.name)) FROM public.services s WHERE s.resource_id = r.id), '[]'),
 'phones', COALESCE((SELECT json_agg(json_build_object('number', p.number, 'service_type', p.service_type)) FROM public.phones p WHERE p.resource_id = r.id), '[]'),
 'associated_sites', COALESCE((SELECT json_agg(st.site_code) FROM public.sites st
   INNER JOIN public.resources_sites j ON st.id = j.site_id WHERE j.resource_id = r.id), '[]')
) FROM public.resources r WHERE r.id = $1
`
