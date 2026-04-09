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
	DbClient         *db.Manager
	TranslateService TranslateService
	PDFService       PDFService
	GoogleConfig     GoogleConfig
	PDFCrowdConfig   PDFCrowdConfig
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

	return NewWithDependencies(
		dbManager,
		NewGoogleTranslateService(translateCredentials),
		NewPDFCrowdService(pdfCrowdConfig.Enabled, pdfCrowdUsername, pdfCrowdApiKey),
		googleConfig,
		pdfCrowdConfig,
	)
}

func NewWithDependencies(
	dbManager *db.Manager,
	translateService TranslateService,
	pdfService PDFService,
	googleConfig GoogleConfig,
	pdfCrowdConfig PDFCrowdConfig,
) *Manager {
	return &Manager{
		DbClient:         dbManager,
		TranslateService: translateService,
		PDFService:       pdfService,
		GoogleConfig:     googleConfig,
		PDFCrowdConfig:   pdfCrowdConfig,
	}
}

func (m *Manager) GetByID(w http.ResponseWriter, r *http.Request) {
	serviceId, err := strconv.Atoi(chi.URLParam(r, "id"))
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusBadRequest, "Invalid service ID format")
		return
	}

	dbService, err := m.DbClient.GetServiceById(serviceId)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusBadRequest, "Failed to retrieve service")
		return
	}

	response := FromDBType(dbService)
	response.Categories = categories.FromDBTypeArray(m.DbClient.GetCategoriesByServiceID(serviceId))
	response.Notes = notes.FromNoteDBTypeArray(m.DbClient.GetNotesByServiceID(serviceId))
	response.Addresses = addresses.FromAddressesDBTypeArray(m.DbClient.GetAddressesByServiceID(serviceId))
	response.Eligibilities = eligibilities.FromEligibilitiesDBTypeArray(m.DbClient.GetEligibilitiesByServiceID(serviceId))
	response.Instructions = instructions.FromInstructionDBTypeArray(m.DbClient.GetInstructionsByServiceID(serviceId))
	response.Documents = documents.FromDocumentDBTypeArray(m.DbClient.GetDocumentsByServiceID(serviceId))
	response.Schedule = schedules.FromDBType(m.DbClient.GetScheduleByServiceId(serviceId))

	if dbService.ProgramId.Valid {
		response.Program = programs.FromDBProgramType(m.DbClient.GetProgramById(int(dbService.ProgramId.Int32)))
	}

	if dbService.ResourceId.Valid {
		response.Resource = resources.FromDBType(m.DbClient.GetResourceById(int(dbService.ResourceId.Int32)))
	}

	response.Resource.Schedule = schedules.FromDBType(m.DbClient.GetScheduleByResourceId(response.Resource.Id))
	response.Resource.Categories = categories.FromDBTypeArray(m.DbClient.GetCategoriesByResourceID(response.Resource.Id))
	response.Resource.Notes = notes.FromNoteDBTypeArray(m.DbClient.GetNotesByResourceID(response.Resource.Id))
	response.Resource.Addresses = addresses.FromAddressesDBTypeArray(m.DbClient.GetAddressesByResourceID(response.Resource.Id))
	response.Resource.Phones = phones.FromDBTypeArray(m.DbClient.GetPhonesByResourceID(response.Resource.Id))
	response.Resource.Services = resources.ConvertServicesToResourceServices(m.DbClient.GetApprovedServicesByResourceId(response.Resource.Id), m.DbClient)

	serviceResponse := &ServiceResponse{
		Service: response,
	}
	writeJson(w, serviceResponse)
}

func (m *Manager) ConvertHtmlToPdf(w http.ResponseWriter, r *http.Request) {
	if err := r.ParseForm(); err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusBadRequest, "Error parsing form data")
		return
	}

	html := r.FormValue("html")
	targetLanguage := r.FormValue("target_language")

	if html == "" {
		common.WriteErrorJson(w, http.StatusBadRequest, "HTML content is required")
		return
	}

	processedHTML, err := m.processHTML(html, targetLanguage)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusInternalServerError, "Failed to process HTML")
		return
	}

	pdfData, err := m.htmlToPDF(processedHTML)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusInternalServerError, "Failed to convert HTML to PDF")
		return
	}

	w.Header().Set("Content-Type", "application/pdf")
	w.Header().Set("Content-Disposition", "attachment; filename=translation.pdf")
	if _, err = w.Write(pdfData); err != nil {
		log.Printf("error writing PDF response: %v", err)
	}
}

func (m *Manager) processHTML(html, targetLanguage string) (string, error) {
	supportedLanguages := []string{"es", "tl", "zh-TW", "vi", "ar", "ru"}

	languageSupported := false
	for _, lang := range supportedLanguages {
		if lang == targetLanguage {
			languageSupported = true
			break
		}
	}

	if languageSupported {
		if m.GoogleConfig.TranslateCredential == "" {
			return "", fmt.Errorf("PDF translation service is not enabled right now. Please contact support or try again later")
		}
		return m.translateHTML(html, targetLanguage)
	}

	return html, nil
}

func (m *Manager) translateHTML(html, targetLanguage string) (string, error) {
	supportedLanguages := map[string]bool{
		"en": true, "es": true, "tl": true,
		"zh-TW": true, "vi": true, "ar": true, "ru": true,
	}

	if !supportedLanguages[targetLanguage] {
		return "", fmt.Errorf("unsupported language: %s", targetLanguage)
	}

	if m.TranslateService == nil {
		return "", fmt.Errorf("translation service not available")
	}

	target, err := language.Parse(targetLanguage)
	if err != nil {
		return "", fmt.Errorf("invalid language code: %v", err)
	}

	ctx := context.Background()
	translations, err := m.TranslateService.Translate(ctx, []string{html}, target)
	if err != nil {
		return "", err
	}

	if len(translations) > 0 {
		return translations[0], nil
	}

	return "", fmt.Errorf("no translation returned")
}

func (m *Manager) htmlToPDF(html string) ([]byte, error) {
	if m.PDFService == nil {
		return nil, fmt.Errorf("PDF service not available")
	}
	return m.PDFService.ConvertToPDF(html)
}

func writeJson(w http.ResponseWriter, object interface{}) {
	output, err := json.Marshal(object)
	if err != nil {
		log.Printf("error marshaling response: %v", err)
		http.Error(w, "internal server error", http.StatusInternalServerError)
		return
	}
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	if _, err = w.Write(output); err != nil {
		log.Printf("error writing response: %v", err)
	}
}
