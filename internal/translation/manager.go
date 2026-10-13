package translation

import (
	"context"
	"encoding/json"
	"log"
	"net/http"

	"github.com/sheltertechsf/sheltertech-go/internal/common"
	"golang.org/x/text/language"
)

type TranslateService interface {
	Translate(ctx context.Context, texts []string, targetLang language.Tag) ([]string, error)
}

type SourceTranslateService interface {
	TranslateWithSource(ctx context.Context, texts []string, targetLang, sourceLang language.Tag) ([]string, error)
}

type Manager struct {
	TranslateService    TranslateService
	TranslateCredential string
}

func New(translateService TranslateService, translateCredential string) *Manager {
	return &Manager{
		TranslateService:    translateService,
		TranslateCredential: translateCredential,
	}
}

type translateTextRequest struct {
	Text           string `json:"text"`
	SourceLanguage string `json:"source_language"`
}

type translateTextResponse struct {
	Result string `json:"result"`
}

func (m *Manager) TranslateText(w http.ResponseWriter, r *http.Request) {
	var req translateTextRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusBadRequest, "Invalid request body")
		return
	}
	if req.Text == "" {
		common.WriteErrorJson(w, http.StatusBadRequest, "Text is required")
		return
	}
	if m.TranslateCredential == "" {
		common.WriteErrorJson(w, http.StatusInternalServerError, "Translation service is not enabled")
		return
	}
	if m.TranslateService == nil {
		common.WriteErrorJson(w, http.StatusInternalServerError, common.InternalServerErrorMessage)
		return
	}

	translations, err := m.translateToEnglish(r.Context(), req)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusInternalServerError, "Failed to translate text")
		return
	}
	if len(translations) == 0 {
		common.WriteErrorJson(w, http.StatusInternalServerError, "Failed to translate text")
		return
	}

	writeJSON(w, translateTextResponse{Result: translations[0]}, http.StatusOK)
}

func (m *Manager) translateToEnglish(ctx context.Context, req translateTextRequest) ([]string, error) {
	if req.SourceLanguage == "" {
		return m.TranslateService.Translate(ctx, []string{req.Text}, language.English)
	}

	sourceLang, err := language.Parse(req.SourceLanguage)
	if err != nil {
		return nil, err
	}

	sourceTranslator, ok := m.TranslateService.(SourceTranslateService)
	if !ok {
		return m.TranslateService.Translate(ctx, []string{req.Text}, language.English)
	}

	return sourceTranslator.TranslateWithSource(ctx, []string{req.Text}, language.English, sourceLang)
}

func writeJSON(w http.ResponseWriter, object interface{}, status int) {
	output, err := json.Marshal(object)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusInternalServerError, common.InternalServerErrorMessage)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(status)
	_, err = w.Write(output)
	if err != nil {
		log.Printf("%v", err)
	}
}
