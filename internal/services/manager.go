package services

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"strconv"

	"github.com/go-chi/chi/v5"
	"github.com/sheltertechsf/sheltertech-go/internal/addresses"
	"github.com/sheltertechsf/sheltertech-go/internal/categories"
	"github.com/sheltertechsf/sheltertech-go/internal/common"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
	"github.com/sheltertechsf/sheltertech-go/internal/documents"
	"github.com/sheltertechsf/sheltertech-go/internal/eligibilities"
	"github.com/sheltertechsf/sheltertech-go/internal/instructions"
	"github.com/sheltertechsf/sheltertech-go/internal/notes"
	"github.com/sheltertechsf/sheltertech-go/internal/phones"
	"github.com/sheltertechsf/sheltertech-go/internal/programs"
	"github.com/sheltertechsf/sheltertech-go/internal/resources"
	"github.com/sheltertechsf/sheltertech-go/internal/schedules"
	"golang.org/x/text/language"
)

type Manager struct {
	DbClient         *db.Manager      // ← Same
	TranslateService TranslateService // ← NEW: Injectable service
	PDFService       PDFService       // ← NEW: Injectable service
	GoogleConfig     GoogleConfig     // ← Same
	PDFCrowdConfig   PDFCrowdConfig   // ← Same
}

func New(dbManager *db.Manager, translateCredentials string, pdfCrowdUsername, pdfCrowdApiKey string) *Manager {
	googleConfig := GoogleConfig{
		TranslateCredential: translateCredentials,
	}

	pdfCrowdConfig := PDFCrowdConfig{
		Enabled: pdfCrowdUsername != "" && pdfCrowdApiKey != "",
		User:    pdfCrowdUsername,
		Key:     pdfCrowdApiKey,
	}

	return NewWithDependencies( // ← NEW: Calls other constructor
		dbManager,
		NewGoogleTranslateService(translateCredentials),                              // ← NEW: Creates real service
		NewPDFCrowdService(pdfCrowdConfig.Enabled, pdfCrowdUsername, pdfCrowdApiKey), // ← NEW: Creates real service
		googleConfig,
		pdfCrowdConfig,
	)
}
func NewWithDependencies(
	dbManager *db.Manager,
	translateService TranslateService, // ← NEW: Accepts interface
	pdfService PDFService, // ← NEW: Accepts interface
	googleConfig GoogleConfig,
	pdfCrowdConfig PDFCrowdConfig,
) *Manager {
	return &Manager{
		DbClient:         dbManager,        // ← Same as before
		TranslateService: translateService, // ← NEW: Injected service
		PDFService:       pdfService,       // ← NEW: Injected service
		GoogleConfig:     googleConfig,     // ← Same as before
		PDFCrowdConfig:   pdfCrowdConfig,   // ← Same as before
	}
}

// GetByID Get a service by ID
//
//	@Summary		Get Service
//	@Description	gets a single service by service ID
//	@Tags			services
//	@Accept			json
//	@Produce		json
//	@Success		200	{array}	services.Service
//	@Router			/services/{id} [get]
func (m *Manager) GetByID(w http.ResponseWriter, r *http.Request) {
	// Get the ID from the URL parameters
	serviceId, err := strconv.Atoi(chi.URLParam(r, "id"))
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusBadRequest, "Invalid service ID format")
		return
	}

	// Retrieve the service from the database
	dbService, err := m.DbClient.GetServiceById(serviceId)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusBadRequest, "Failed to retrieve service")
		return
	}

	// Populate the response with service details
	response := FromDBType(dbService)
	response.Categories = categories.FromDBTypeArray(m.DbClient.GetCategoriesByServiceID(serviceId))
	response.Notes = notes.FromNoteDBTypeArray(m.DbClient.GetNotesByServiceID(serviceId))
	response.Addresses = addresses.FromAddressesDBTypeArray(m.DbClient.GetAddressesByServiceID(serviceId))
	response.Eligibilities = eligibilities.FromEligibilitiesDBTypeArray(m.DbClient.GetEligibilitiesByServiceID(serviceId))
	response.Instructions = instructions.FromInstructionDBTypeArray(m.DbClient.GetInstructionsByServiceID(serviceId))
	response.Documents = documents.FromDocumentDBTypeArray(m.DbClient.GetDocumentsByServiceID(serviceId))
	response.Schedule = schedules.FromDBType(m.DbClient.GetScheduleByServiceId(serviceId))

	// Add program if available
	if dbService.ProgramId.Valid {
		response.Program = programs.FromDBProgramType(m.DbClient.GetProgramById(int(dbService.ProgramId.Int32)))
	}

	// Add resource if available
	if dbService.ResourceId.Valid {
		response.Resource = resources.FromDBType(m.DbClient.GetResourceById(int(dbService.ResourceId.Int32)))
	}

	// Populate resource details
	response.Resource.Schedule = schedules.FromDBType(m.DbClient.GetScheduleByResourceId(response.Resource.Id))
	response.Resource.Categories = categories.FromDBTypeArray(m.DbClient.GetCategoriesByResourceID(response.Resource.Id))
	response.Resource.Notes = notes.FromNoteDBTypeArray(m.DbClient.GetNotesByResourceID(response.Resource.Id))
	response.Resource.Addresses = addresses.FromAddressesDBTypeArray(m.DbClient.GetAddressesByResourceID(response.Resource.Id))
	response.Resource.Phones = phones.FromDBTypeArray(m.DbClient.GetPhonesByResourceID(response.Resource.Id))
	response.Resource.Services = resources.ConvertServicesToResourceServices(m.DbClient.GetApprovedServicesByResourceId(response.Resource.Id), m.DbClient)

	// Create and write the response
	serviceResponse := &ServiceResponse{
		Service: response,
	}
	writeJson(w, serviceResponse)
}

// ConvertHtmlToPdf method to convert HTML to PDF
//
//	@Summary		Convert HTML to PDF
//	@Description	Converts HTML to PDF, with optional translation
//	@Tags			services
//	@Accept			multipart/form-data
//	@Produce		application/pdf
//	@Param			html			formData	string	true	"HTML content to convert"
//	@Param			target_language	formData	string	false	"Target language for translation"
//	@Success		200	{file}	file	"Generated PDF"
//	@Router			/convert-html-to-pdf [post]
func (m *Manager) ConvertHtmlToPdf(w http.ResponseWriter, r *http.Request) {
	// Parse form data
	if err := r.ParseForm(); err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusBadRequest, "Error parsing form data")
		return
	}

	// Extract HTML and target language from form
	html := r.FormValue("html")
	targetLanguage := r.FormValue("target_language")

	// Validate input
	if html == "" {
		common.WriteErrorJson(w, http.StatusBadRequest, "HTML content is required")
		return
	}

	// Process HTML (potentially translate)
	processedHTML, err := m.processHTML(html, targetLanguage)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusInternalServerError, "Failed to process HTML")
		return
	}

	// Convert to PDF using PDFCrowd credentials
	pdfData, err := m.htmlToPDF(processedHTML)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusInternalServerError, "Failed to convert HTML to PDF")
		return
	}

	// Set headers for PDF download
	w.Header().Set("Content-Type", "application/pdf")
	w.Header().Set("Content-Disposition", "attachment; filename=translation.pdf")
	w.Write(pdfData)
}

// processHTML handles potential translation
func (m *Manager) processHTML(html, targetLanguage string) (string, error) {
	// Supported languages
	supportedLanguages := []string{"en", "es", "tl", "zh-TW", "vi", "ar", "ru"}

	// Check if translation is needed
	languageSupported := false
	for _, lang := range supportedLanguages {
		if lang == targetLanguage {
			languageSupported = true
			break
		}
	}

	// Translate if language is supported
	if languageSupported {
		// Check if translation credentials are available
		if m.GoogleConfig.TranslateCredential == "" {
			return "", fmt.Errorf("PDF translation service is not enabled right now. Please contact support or try again later")
		}

		return m.translateHTML(html, targetLanguage)
	}

	return html, nil
}

// translateHTML performs the translation of HTML content
func (m *Manager) translateHTML(html, targetLanguage string) (string, error) {
	// Supported languages map
	supportedLanguages := map[string]bool{
		"en": true, "es": true, "tl": true,
		"zh-TW": true, "vi": true, "ar": true, "ru": true,
	}

	// Validate language
	if !supportedLanguages[targetLanguage] {
		return "", fmt.Errorf("unsupported language: %s", targetLanguage)
	}

	// Check if translation service is available
	if m.TranslateService == nil {
		return "", fmt.Errorf("translation service not available")
	}

	// Parse target language
	target, err := language.Parse(targetLanguage)
	if err != nil {
		return "", fmt.Errorf("invalid language code: %v", err)
	}

	// Use injected translation service
	ctx := context.Background()
	translations, err := m.TranslateService.Translate(ctx, []string{html}, target)
	if err != nil {
		return "", err
	}

	// Return translated text
	if len(translations) > 0 {
		return translations[0], nil
	}

	return "", fmt.Errorf("no translation returned")
}

// htmlToPDF converts HTML to PDF using PDFCrowd credentials
func (m *Manager) htmlToPDF(html string) ([]byte, error) {
	// Check if PDF service is available
	if m.PDFService == nil {
		return nil, fmt.Errorf("PDF service not available")
	}

	// Use injected PDF service
	return m.PDFService.ConvertToPDF(html)
}

func writeJson(w http.ResponseWriter, object interface{}) {
	output, err := json.Marshal(object)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusInternalServerError, common.InternalServerErrorMessage)
		return
	}
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	_, err = w.Write(output)
	if err != nil {
		panic(err)
	}
}
