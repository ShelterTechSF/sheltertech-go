package db

import (
	"database/sql"
	"errors"
	"fmt"
	"log"

	_ "github.com/lib/pq"
)

type Manager struct {
	DB *sql.DB
}

func New(dbHost, dbPort, dbName, dbUser, dbPass string) *Manager {
	var psqlInfo string
	if dbPass == "" {
		psqlInfo = fmt.Sprintf("host=%s port=%s user=%s dbname=%s sslmode=disable",
			dbHost, dbPort, dbUser, dbName)
	} else {
		psqlInfo = fmt.Sprintf("host=%s port=%s user=%s dbname=%s password=%s sslmode=disable",
			dbHost, dbPort, dbUser, dbName, dbPass)
	}
	db, err := sql.Open("postgres", psqlInfo)
	if err != nil {
		panic(err)
	}

	err = db.Ping()
	if err != nil {
		panic(err)
	}

	fmt.Println("Successfully connected!")
	manager := &Manager{
		DB: db,
	}
	return manager
}

func (m *Manager) GetCategories(topLevel *bool) []*Category {
	var rows *sql.Rows
	var err error
	if topLevel != nil {
		rows, err = m.DB.Query(categoriesByTopLevelSql, topLevel)
	} else {
		rows, err = m.DB.Query(categoriesSql)
	}
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanCategories(rows)
}

func (m *Manager) GetCategoryServiceCounts() []*CategoryCount {
	var rows *sql.Rows
	var err error
	rows, err = m.DB.Query(categoryServiceCounts)
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanCategoryCounts(rows)
}

func (m *Manager) GetCategoryResourceCounts() []*CategoryCount {
	var rows *sql.Rows
	var err error
	rows, err = m.DB.Query(categoryResourceCounts)
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanCategoryCounts(rows)
}

func (m *Manager) GetCategoriesByFeatured() []*Category {
	var rows *sql.Rows
	var err error
	rows, err = m.DB.Query(categoriesByFeaturedSql)
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanCategories(rows)
}

func (m *Manager) GetSubCategoriesByID(categoryId int) []*Category {
	var rows *sql.Rows
	var err error
	rows, err = m.DB.Query(subCategoriesByIDSql, categoryId)
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanCategories(rows)
}

func (m *Manager) GetCategoryByID(categoryId int) *Category {
	row := m.DB.QueryRow(categoriesByIDSql, categoryId)
	return scanCategory(row)
}

func (m *Manager) GetCategoriesByServiceID(serviceId int) []*Category {
	var rows *sql.Rows
	var err error
	rows, err = m.DB.Query(categoriesByServiceIDSql, serviceId)
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanCategories(rows)
}

func (m *Manager) GetCategoriesByResourceID(resourceId int) []*Category {
	var rows *sql.Rows
	var err error
	rows, err = m.DB.Query(categoriesByResourceIDSql, resourceId)
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanCategories(rows)
}

func (m *Manager) GetNotesByServiceID(serviceId int) []*Note {
	var rows *sql.Rows
	var err error
	rows, err = m.DB.Query(notesByServiceIDSql, serviceId)
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanNotes(rows)
}

func (m *Manager) GetNotesByResourceID(resourceId int) []*Note {
	var rows *sql.Rows
	var err error
	rows, err = m.DB.Query(notesByResourceIDSql, resourceId)
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanNotes(rows)
}

func scanNotes(rows *sql.Rows) []*Note {
	var notes []*Note
	for rows.Next() {
		var note Note
		err := rows.Scan(&note.Id, &note.Note, &note.CreatedAt, &note.UpdatedAt)
		switch err {
		case sql.ErrNoRows:
			fmt.Println("No rows were returned!")
			return nil
		}
		notes = append(notes, &note)
	}
	return notes
}

func (m *Manager) GetBookmarks() []*Bookmark {
	var rows *sql.Rows
	var err error
	rows, err = m.DB.Query(findBookmarksSql)
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanBookmarks(rows)
}

func (m *Manager) GetBookmarksByUserID(userId int) []*Bookmark {
	var rows *sql.Rows
	var err error
	rows, err = m.DB.Query(findBookmarksByUserIDSql, userId)
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanBookmarks(rows)
}

func (m *Manager) GetBookmarkByID(bookmarkId int) *Bookmark {
	row := m.DB.QueryRow(findBookmarksByIDSql, bookmarkId)
	return scanBookmark(row)
}

func scanBookmarks(rows *sql.Rows) []*Bookmark {
	var bookmarks []*Bookmark
	for rows.Next() {
		var bookmark Bookmark
		err := rows.Scan(&bookmark.Id, &bookmark.Order, &bookmark.UserID, &bookmark.FolderID, &bookmark.ServiceID, &bookmark.ResourceID)
		switch err {
		case sql.ErrNoRows:
			fmt.Println("No rows were returned!")
			return nil
		}
		bookmarks = append(bookmarks, &bookmark)
	}
	return bookmarks
}

func scanBookmark(row *sql.Row) *Bookmark {
	var bookmark Bookmark
	err := row.Scan(&bookmark.Id, &bookmark.Order, &bookmark.UserID, &bookmark.FolderID, &bookmark.ServiceID, &bookmark.ResourceID)
	if err != nil {
		switch err {
		case sql.ErrNoRows:
			fmt.Println("No rows were returned!")
			return nil
		default:
			panic(err)
		}
	}
	return &bookmark
}

func (m *Manager) GetAddressesByServiceID(serviceId int) []*Address {
	var rows *sql.Rows
	var err error
	rows, err = m.DB.Query(addressesByServiceIDSql, serviceId)
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanAddresses(rows)
}

func (m *Manager) GetAddressesByResourceID(resourceId int) []*Address {
	var rows *sql.Rows
	var err error
	rows, err = m.DB.Query(addressesByResourceIDSql, resourceId)
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanAddresses(rows)
}

func scanAddresses(rows *sql.Rows) []*Address {
	var addresses []*Address
	for rows.Next() {
		var address Address
		err := rows.Scan(&address.Id, &address.Attention, &address.Address1, &address.Address2, &address.Address3, &address.Address4, &address.City, &address.StateProvince, &address.PostalCode, &address.ResourceId, &address.Latitude, &address.Longitude, &address.Online, &address.Region, &address.Name, &address.Description, &address.Transportation)
		switch err {
		case sql.ErrNoRows:
			fmt.Println("No rows were returned!")
			return nil
		}
		addresses = append(addresses, &address)
	}
	return addresses
}

func (m *Manager) GetPhonesByResourceID(resourceId int) []*Phone {
	var rows *sql.Rows
	var err error
	rows, err = m.DB.Query(phonesByResourceIDSql, resourceId)
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanPhones(rows)
}

func scanPhones(rows *sql.Rows) []*Phone {
	var phones []*Phone
	for rows.Next() {
		var phone Phone
		err := rows.Scan(&phone.Id, &phone.Number, &phone.ServiceType)
		switch err {
		case sql.ErrNoRows:
			fmt.Println("No rows were returned!")
			return nil
		}
		phones = append(phones, &phone)
	}
	return phones
}

func (m *Manager) GetEligibitiesByServiceID(serviceId int) []*Eligibility {
	var rows *sql.Rows
	var err error
	rows, err = m.DB.Query(eligibilitiesByServiceIDSql, serviceId)
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanEligibilities(rows)
}

func scanEligibilities(rows *sql.Rows) []*Eligibility {
	var eligibilities []*Eligibility
	for rows.Next() {
		var eligibility Eligibility
		err := rows.Scan(&eligibility.Id, &eligibility.Name, &eligibility.FeatureRank)
		switch err {
		case sql.ErrNoRows:
			fmt.Println("No rows were returned!")
			return nil
		}
		eligibilities = append(eligibilities, &eligibility)
	}
	return eligibilities
}
func (m *Manager) GetInstructionsByServiceID(serviceId int) []*Instruction {
	var rows *sql.Rows
	var err error
	rows, err = m.DB.Query(instructionsByServiceIDSql, serviceId)
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanInstructions(rows)
}

func scanInstructions(rows *sql.Rows) []*Instruction {
	var instructions []*Instruction
	for rows.Next() {
		var instruction Instruction
		err := rows.Scan(&instruction.Id, &instruction.Instruction)
		switch err {
		case sql.ErrNoRows:
			fmt.Println("No rows were returned!")
			return nil
		}
		instructions = append(instructions, &instruction)
	}
	return instructions
}
func (m *Manager) GetDocumentsByServiceID(serviceId int) []*Document {
	var rows *sql.Rows
	var err error
	rows, err = m.DB.Query(documentsByServiceIDSql, serviceId)
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanDocuments(rows)
}

func scanDocuments(rows *sql.Rows) []*Document {
	var documents []*Document
	for rows.Next() {
		var document Document
		err := rows.Scan(&document.Id, &document.Name, &document.Url, &document.Description)
		switch err {
		case sql.ErrNoRows:
			fmt.Println("No rows were returned!")
			return nil
		}
		documents = append(documents, &document)
	}
	return documents
}
func scanCategories(rows *sql.Rows) []*Category {
	var categories []*Category
	for rows.Next() {
		var category Category
		err := rows.Scan(&category.Id, &category.Name, &category.TopLevel, &category.Featured)
		switch err {
		case sql.ErrNoRows:
			fmt.Println("No rows were returned!")
			return nil
		}
		categories = append(categories, &category)
	}
	return categories
}

func scanCategoryCounts(rows *sql.Rows) []*CategoryCount {
	var counts []*CategoryCount
	for rows.Next() {
		var count CategoryCount
		err := rows.Scan(&count.CategoryName, &count.Count)
		switch err {
		case sql.ErrNoRows:
			fmt.Println("No rows were returned!")
			return nil
		}
		counts = append(counts, &count)
	}
	return counts
}

func scanCategory(row *sql.Row) *Category {
	var category Category
	err := row.Scan(&category.Id, &category.Name, &category.TopLevel, &category.Featured)
	if err != nil {
		switch err {
		case sql.ErrNoRows:
			fmt.Println("No rows were returned!")
			return nil
		default:
			panic(err)
		}
	}
	return &category
}

func scanService(row *sql.Row) *Service {
	var service Service
	err := row.Scan(&service.Id, &service.CreatedAt, &service.UpdatedAt, &service.Name, &service.LongDescription, &service.Eligibility, &service.RequiredDocuments, &service.Fee, &service.ApplicationProcess, &service.ResourceId, &service.VerifiedAt, &service.Email, &service.Status, &service.Certified, &service.ProgramId, &service.InterpretationServices, &service.Url, &service.WaitTime, &service.ContactId, &service.FundingId, &service.AlternateName, &service.CertifiedAt, &service.Featured, &service.SourceAttribution, &service.InternalNote, &service.ShortDescription)
	if err != nil {
		switch err {
		case sql.ErrNoRows:
			fmt.Println("No rows were returned!")
			return nil
		default:
			panic(err)
		}
	}
	return &service
}

func scanServices(rows *sql.Rows) []*Service {
	var services []*Service
	for rows.Next() {
		var service Service
		err := rows.Scan(&service.Id, &service.CreatedAt, &service.UpdatedAt, &service.Name, &service.LongDescription, &service.Eligibility, &service.RequiredDocuments, &service.Fee, &service.ApplicationProcess, &service.ResourceId, &service.VerifiedAt, &service.Email, &service.Status, &service.Certified, &service.ProgramId, &service.InterpretationServices, &service.Url, &service.WaitTime, &service.ContactId, &service.FundingId, &service.AlternateName, &service.CertifiedAt, &service.Featured, &service.SourceAttribution, &service.InternalNote, &service.ShortDescription)
		switch err {
		case sql.ErrNoRows:
			fmt.Println("No rows were returned!")
			return nil
		}
		services = append(services, &service)
	}
	return services
}

func scanProgram(row *sql.Row) *Program {
	var program Program
	err := row.Scan(&program.Id, &program.Name, &program.AlternateName, &program.Description)
	if err != nil {
		switch err {
		case sql.ErrNoRows:
			fmt.Println("No rows were returned!")
			return nil
		default:
			panic(err)
		}
	}
	return &program
}

func scanResource(row *sql.Row) *Resource {
	var resource Resource
	err := row.Scan(&resource.Id, &resource.Name, &resource.ShortDescription, &resource.LongDescription, &resource.Website, &resource.VerifiedAt, &resource.Email, &resource.Status, &resource.Certified, &resource.AlternateName, &resource.LegalStatus, &resource.ContactId, &resource.FundingId, &resource.CertifiedAt, &resource.Featured, &resource.SourceAttribution, &resource.InternalNote, &resource.UpdatedAt)
	if err != nil {
		switch err {
		case sql.ErrNoRows:
			fmt.Println("No rows were returned!")
			return nil
		default:
			panic(err)
		}
	}
	return &resource
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

func scanUser(row *sql.Row) *User {
	var user User
	err := row.Scan(&user.Id, &user.Name, &user.Organization, &user.UserExternalId, &user.Email)
	if err != nil {
		switch err {
		case sql.ErrNoRows:
			fmt.Println("No rows were returned!")
			return nil
		default:
			panic(err)
		}
	}
	return &user
}

func (m *Manager) SubmitChangeRequest(changeRequest *ChangeRequest) error {
	tx, err := m.DB.Begin()
	if err != nil {
		return err
	}
	res, err := tx.Exec(submitChangeRequest, changeRequest.Type, changeRequest.ObjectId, changeRequest.Status, changeRequest.Action, changeRequest.ResourceId)
	if err != nil {
		return err
	}
	rowCount, err := res.RowsAffected()
	if err != nil {
		return err
	}
	if rowCount != 1 {
		defer tx.Rollback()
		return errors.New(fmt.Sprintf("unexpected rows modified, expected one, saw %v", rowCount))
	}
	return tx.Commit()
}

func (m *Manager) SubmitBookmark(bookmark *Bookmark) error {

	tx, err := m.DB.Begin()
	if err != nil {
		return err
	}
	res, err := tx.Exec(submitBookmark, bookmark.Order, bookmark.UserID, bookmark.FolderID, bookmark.ResourceID, bookmark.ServiceID)
	if err != nil {
		return err
	}

	rowCount, err := res.RowsAffected()
	if err != nil {
		return err
	}
	if rowCount != 1 {
		defer tx.Rollback()
		return errors.New(fmt.Sprintf("unexpected rows modified, expected one, saw %v", rowCount))
	}

	return tx.Commit()
}

func (m *Manager) UpdateBookmark(bookmark *Bookmark) error {
	tx, err := m.DB.Begin()
	if err != nil {
		return err
	}
	res, err := tx.Exec(updateBookmark, bookmark.Id, bookmark.Order, bookmark.UserID, bookmark.FolderID, bookmark.ResourceID, bookmark.ServiceID)
	if err != nil {
		return err
	}

	rowCount, err := res.RowsAffected()
	if err != nil {
		return err
	}
	if rowCount != 1 {
		defer tx.Rollback()
		return errors.New(fmt.Sprintf("unexpected rows modified, expected one, saw %v", rowCount))
	}
	return tx.Commit()
}


func (m *Manager) GetServiceById(serviceId int) *Service {
	row := m.DB.QueryRow(serviceByIDSql, serviceId)
	return scanService(row)
}

func (m *Manager) GetApprovedServicesByResourceId(resourceId int) []*Service {
	var rows *sql.Rows
	var err error
	rows, err = m.DB.Query(approvedServicesByResourceIDSql, resourceId)
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanServices(rows)
}

func (m *Manager) GetProgramById(programId int) *Program {
	row := m.DB.QueryRow(programByIDSql, programId)
	return scanProgram(row)
}
func (m *Manager) GetResourceById(resourceId int) *Resource {
	row := m.DB.QueryRow(resourceByIDSql, resourceId)
	return scanResource(row)
}

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

func (m *Manager) DeleteBookmarkByID(bookmarkId int) error {
	tx, err := m.DB.Begin()
	if err != nil {
		return err
	}

	res, err := tx.Exec(deleteBookmarkByIDSql, bookmarkId)
	if err != nil {
		return err
	}
	rowCount, err := res.RowsAffected()
	if err != nil {
		return err
	}
	if rowCount != 1 {
		defer tx.Rollback()
		return errors.New(fmt.Sprintf("unexpected rows modified, expected one, saw %v", rowCount))
	}

	return tx.Commit()

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

func scanFolder(row *sql.Row) *Folder {
	var folder Folder
	err := row.Scan(&folder.Id, &folder.Name, &folder.Order, &folder.UserId)
	if err != nil {
		switch err {
		case sql.ErrNoRows:
			fmt.Println("No rows were returned!")
			return nil
		default:
			panic(err)
		}
	}
	return &folder
}
func (m *Manager) GetFolderById(folderId int) *Folder {
	row := m.DB.QueryRow(folderByIDSql, folderId)
	return scanFolder(row)
}

func scanFolders(rows *sql.Rows) []*Folder {
	var folders []*Folder
	for rows.Next() {
		var folder Folder
		err := rows.Scan(&folder.Id, &folder.Name, &folder.Order, &folder.UserId)
		switch err {
		case sql.ErrNoRows:
			fmt.Println("No rows were returned!")
			return nil
		}
		folders = append(folders, &folder)
	}
	return folders
}

func (m *Manager) GetFolders(userId int) []*Folder {
	var rows *sql.Rows
	var err error
	rows, err = m.DB.Query(foldersByUserIDSql, userId)
	if err != nil {
		log.Printf("%v\n", err)
	}
	return scanFolders(rows)
}

func (m *Manager) CreateFolder(folder *Folder) (int, error) {
	tx, err := m.DB.Begin()
	if err != nil {
		return -1, err
	}
	row := tx.QueryRow(createFolder, folder.Name, folder.Order, folder.UserId)
	var id int
	err = row.Scan(&id)
	if err != nil {
		return -1, err
	}
	return id, tx.Commit()
}

func (m *Manager) UpdateFolder(folder *Folder) error {
	tx, err := m.DB.Begin()
	if err != nil {
		return err
	}
	res, err := tx.Exec(updateFolder, folder.Id, folder.Name, folder.Order)
	if err != nil {
		return err
	}
	rowCount, err := res.RowsAffected()
	if err != nil {
		return err
	}
	if rowCount != 1 {
		defer tx.Rollback()
		return errors.New(fmt.Sprintf("unexpected rows modified, expected one, saw %v", rowCount))
	}
	return tx.Commit()
}

func (m *Manager) DeleteFolderById(folderId int) error {
	tx, err := m.DB.Begin()
	if err != nil {
		return err
	}

	res, err := tx.Exec(deleteFolder, folderId)
	if err != nil {
		return err
	}
	rowCount, err := res.RowsAffected()
	if err != nil {
		return err
	}
	if rowCount != 1 {
		defer tx.Rollback()
		return errors.New(fmt.Sprintf("unexpected rows modified, expected one, saw %v", rowCount))
	}
	return tx.Commit()
}

func (m *Manager) GetUserByUserExternalID(userExternalId string) *User {
	row := m.DB.QueryRow(userByUserExternalIDSql, userExternalId)
	return scanUser(row)
}
