package algolia

import (
	"fmt"

	"github.com/sheltertechsf/sheltertech-go/internal/db"
)

func buildResourceRecord(dbClient *db.Manager, resourceId int) (*ResourceRecord, error) {
	resource := dbClient.GetResourceById(resourceId)
	if resource == nil {
		return nil, fmt.Errorf("resource %d not found", resourceId)
	}

	addresses := dbClient.GetAddressesByResourceID(resourceId)
	schedule := dbClient.GetScheduleByResourceId(resourceId)
	categories := dbClient.GetCategoriesByResourceID(resourceId)
	notes := dbClient.GetNotesByResourceID(resourceId)
	phones := dbClient.GetPhonesByResourceID(resourceId)
	services := dbClient.GetApprovedServicesByResourceId(resourceId)

	record := &ResourceRecord{
		ObjectID:      fmt.Sprintf("resource_%d", resourceId),
		Type:          "resource",
		ID:            resourceId,
		Name:          resource.Name,
		IsMohcdFunded: resource.FundingId.Valid,
		Addresses:     convertAddresses(addresses),
		Categories:    convertCategories(categories),
		Notes:         convertNotes(notes),
		Phones:        convertPhones(phones),
		OpenTimes:     []IndexOpenTime{},
		ServiceNames:  []string{},
	}

	if resource.Status.Valid {
		record.Status = resource.Status.String
	}
	if resource.Certified.Valid {
		record.Certified = resource.Certified.Bool
	}
	if resource.Featured.Valid {
		record.Featured = resource.Featured.Bool
	}

	if resource.AlternateName.Valid {
		record.AlternateName = resource.AlternateName.String
	}
	if resource.LongDescription.Valid {
		record.LongDescription = resource.LongDescription.String
	}
	if resource.ShortDescription.Valid {
		record.ShortDescription = resource.ShortDescription.String
	}
	if resource.Website.Valid {
		record.Website = resource.Website.String
	}
	if resource.Email.Valid {
		record.Email = resource.Email.String
	}
	if resource.VerifiedAt != nil {
		record.VerifiedAt = resource.VerifiedAt.Format("2006-01-02T15:04:05.000Z")
	}

	record.GeoLoc = geoLocFromAddresses(addresses)
	record.Schedule = convertSchedule(schedule)

	if schedule != nil {
		record.OpenTimes = openTimesFromSchedule(schedule)
	}

	for _, svc := range services {
		if svc.Name.Valid {
			record.ServiceNames = append(record.ServiceNames, svc.Name.String)
		}
	}

	return record, nil
}

func buildServiceRecord(dbClient *db.Manager, svc *db.Service, resourceId int, resourceName string, resourceSchedule *db.Schedule) *ServiceRecord {
	addresses := dbClient.GetAddressesByServiceID(svc.Id)
	if len(addresses) == 0 {
		addresses = dbClient.GetAddressesByResourceID(resourceId)
	}
	schedule := dbClient.GetScheduleByServiceId(svc.Id)
	categories := dbClient.GetCategoriesByServiceID(svc.Id)
	eligibilities := dbClient.GetEligibilitiesByServiceID(svc.Id)
	notes := dbClient.GetNotesByServiceID(svc.Id)
	documents := dbClient.GetDocumentsByServiceID(svc.Id)
	instructions := dbClient.GetInstructionsByServiceID(svc.Id)
	phones := dbClient.GetPhonesByResourceID(resourceId)

	record := &ServiceRecord{
		ObjectID:    fmt.Sprintf("service_%d", svc.Id),
		Type:        "service",
		ID:          svc.Id,
		Certified:   svc.Certified,
		IsMohcdFunded: svc.FundingId.Valid,
		Addresses:   convertAddresses(addresses),
		Categories:  convertCategories(categories),
		Eligibilities: convertEligibilities(eligibilities),
		Phones:      convertPhones(phones),
		Documents:   convertDocuments(documents),
		Instructions: convertInstructions(instructions),
		Notes:       convertNotes(notes),
		OpenTimes:   []IndexOpenTime{},
		ServiceOf: &IndexServiceOf{
			ID:   resourceId,
			Name: resourceName,
		},
	}

	if svc.Name.Valid {
		record.Name = svc.Name.String
	}
	if svc.AlternateName.Valid {
		record.AlternateName = svc.AlternateName.String
	}
	if svc.LongDescription.Valid {
		record.LongDescription = svc.LongDescription.String
	}
	if svc.ShortDescription.Valid {
		record.ShortDescription = svc.ShortDescription.String
	}
	if svc.Url.Valid {
		record.Website = svc.Url.String
	}
	if svc.Email.Valid {
		record.Email = svc.Email.String
	}
	if svc.Status.Valid {
		record.Status = fmt.Sprintf("%d", svc.Status.Int32)
	}
	if svc.Featured.Valid {
		record.Featured = svc.Featured.Bool
	}
	if svc.VerifiedAt != nil {
		record.VerifiedAt = svc.VerifiedAt.Format("2006-01-02T15:04:05.000Z")
	}
	if svc.Fee.Valid {
		record.Fee = svc.Fee.String
	}
	if svc.ApplicationProcess.Valid {
		record.ApplicationProcess = svc.ApplicationProcess.String
	}
	if svc.WaitTime.Valid {
		record.WaitTime = svc.WaitTime.String
	}

	record.GeoLoc = geoLocFromAddresses(addresses)
	record.Schedule = convertSchedule(schedule)
	record.ResourceSchedule = convertSchedule(resourceSchedule)

	if schedule != nil {
		record.OpenTimes = openTimesFromSchedule(schedule)
	}

	return record
}

// Helper converters

func convertAddresses(dbAddrs []*db.Address) []IndexAddress {
	result := make([]IndexAddress, 0, len(dbAddrs))
	for _, a := range dbAddrs {
		addr := IndexAddress{
			ID:            a.Id,
			City:          a.City,
			StateProvince: a.StateProvince,
			Address1:      a.Address1,
			PostalCode:    a.PostalCode,
		}
		if a.Latitude.Valid {
			addr.Latitude = a.Latitude.Float64
		}
		if a.Longitude.Valid {
			addr.Longitude = a.Longitude.Float64
		}
		result = append(result, addr)
	}
	return result
}

func convertSchedule(sched *db.Schedule) *IndexSchedule {
	if sched == nil {
		return nil
	}
	indexSched := &IndexSchedule{
		ID:         sched.Id,
		HoursKnown: sched.HoursKnown,
		Days:       make([]IndexScheduleDay, 0, len(sched.ScheduleDays)),
	}
	for _, d := range sched.ScheduleDays {
		day := IndexScheduleDay{
			ID:  d.Id,
			Day: d.Day,
		}
		if d.OpensAt.Valid {
			v := d.OpensAt.Int32
			day.OpensAt = &v
		}
		if d.ClosesAt.Valid {
			v := d.ClosesAt.Int32
			day.ClosesAt = &v
		}
		if d.OpenTime.Valid {
			day.OpenTime = d.OpenTime.Time.Format("15:04")
		}
		if d.OpenDay.Valid {
			day.OpenDay = d.OpenDay.String
		}
		if d.CloseTime.Valid {
			day.CloseTime = d.CloseTime.Time.Format("15:04")
		}
		if d.CloseDay.Valid {
			day.CloseDay = d.CloseDay.String
		}
		indexSched.Days = append(indexSched.Days, day)
	}
	return indexSched
}

func openTimesFromSchedule(sched *db.Schedule) []IndexOpenTime {
	result := make([]IndexOpenTime, 0, len(sched.ScheduleDays))
	for _, d := range sched.ScheduleDays {
		ot := IndexOpenTime{
			Day: d.Day,
		}
		if d.OpensAt.Valid {
			v := d.OpensAt.Int32
			ot.OpensAt = &v
		}
		if d.ClosesAt.Valid {
			v := d.ClosesAt.Int32
			ot.ClosesAt = &v
		}
		result = append(result, ot)
	}
	return result
}

func convertCategories(dbCats []*db.Category) []IndexCategory {
	result := make([]IndexCategory, 0, len(dbCats))
	for _, c := range dbCats {
		result = append(result, IndexCategory{
			ID:       c.Id,
			Name:     c.Name,
			TopLevel: c.TopLevel,
		})
	}
	return result
}

func convertNotes(dbNotes []*db.Note) []IndexNote {
	result := make([]IndexNote, 0, len(dbNotes))
	for _, n := range dbNotes {
		if n.Note.Valid {
			result = append(result, IndexNote{
				ID:   n.Id,
				Note: n.Note.String,
			})
		}
	}
	return result
}

func convertPhones(dbPhones []*db.Phone) []IndexPhone {
	result := make([]IndexPhone, 0, len(dbPhones))
	for _, p := range dbPhones {
		result = append(result, IndexPhone{
			ID:          p.Id,
			Number:      p.Number,
			ServiceType: p.ServiceType,
		})
	}
	return result
}

func convertEligibilities(dbEligibilities []*db.Eligibility) []IndexEligibility {
	result := make([]IndexEligibility, 0, len(dbEligibilities))
	for _, e := range dbEligibilities {
		ie := IndexEligibility{
			ID: e.Id,
		}
		if e.Name.Valid {
			ie.Name = e.Name.String
		}
		if e.FeatureRank.Valid {
			v := e.FeatureRank.Int32
			ie.FeatureRank = &v
		}
		result = append(result, ie)
	}
	return result
}

func convertDocuments(dbDocs []*db.Document) []IndexDocument {
	result := make([]IndexDocument, 0, len(dbDocs))
	for _, d := range dbDocs {
		doc := IndexDocument{
			ID: d.Id,
		}
		if d.Name.Valid {
			doc.Name = d.Name.String
		}
		if d.Url.Valid {
			doc.URL = d.Url.String
		}
		result = append(result, doc)
	}
	return result
}

func convertInstructions(dbInstructions []*db.Instruction) []IndexInstruction {
	result := make([]IndexInstruction, 0, len(dbInstructions))
	for _, i := range dbInstructions {
		if i.Instruction.Valid {
			result = append(result, IndexInstruction{
				ID:          i.Id,
				Instruction: i.Instruction.String,
			})
		}
	}
	return result
}

func geoLocFromAddresses(addrs []*db.Address) *GeoLoc {
	for _, a := range addrs {
		if a.Latitude.Valid && a.Longitude.Valid {
			return &GeoLoc{
				Lat: a.Latitude.Float64,
				Lng: a.Longitude.Float64,
			}
		}
	}
	return nil
}
