package translation

import (
	"context"
	"errors"
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/mock"
	"golang.org/x/text/language"
)

type mockTranslateService struct {
	mock.Mock
}

func (m *mockTranslateService) Translate(ctx context.Context, texts []string, targetLang language.Tag) ([]string, error) {
	args := m.Called(ctx, texts, targetLang)
	return args.Get(0).([]string), args.Error(1)
}

func (m *mockTranslateService) TranslateWithSource(ctx context.Context, texts []string, targetLang, sourceLang language.Tag) ([]string, error) {
	args := m.Called(ctx, texts, targetLang, sourceLang)
	return args.Get(0).([]string), args.Error(1)
}

func TestManager_TranslateText(t *testing.T) {
	tests := []struct {
		name           string
		body           string
		credential     string
		setupMock      func(*mockTranslateService)
		expectedStatus int
		expectedBody   string
	}{
		{
			name:       "translates text to English",
			body:       `{"text":"hola","source_language":"es"}`,
			credential: "fake-credentials",
			setupMock: func(mockTranslate *mockTranslateService) {
				mockTranslate.On("TranslateWithSource", mock.Anything, []string{"hola"}, language.English, language.Spanish).
					Return([]string{"hello"}, nil)
			},
			expectedStatus: http.StatusOK,
			expectedBody:   `{"result":"hello"}`,
		},
		{
			name:           "returns bad request for malformed json",
			body:           `{"text":`,
			credential:     "fake-credentials",
			setupMock:      func(mockTranslate *mockTranslateService) {},
			expectedStatus: http.StatusBadRequest,
			expectedBody:   `{"error":"Invalid request body","status_code":400}`,
		},
		{
			name:           "returns bad request when text is missing",
			body:           `{"source_language":"es"}`,
			credential:     "fake-credentials",
			setupMock:      func(mockTranslate *mockTranslateService) {},
			expectedStatus: http.StatusBadRequest,
			expectedBody:   `{"error":"Text is required","status_code":400}`,
		},
		{
			name:           "returns internal server error when translation is disabled",
			body:           `{"text":"hola","source_language":"es"}`,
			credential:     "",
			setupMock:      func(mockTranslate *mockTranslateService) {},
			expectedStatus: http.StatusInternalServerError,
			expectedBody:   `{"error":"Translation service is not enabled","status_code":500}`,
		},
		{
			name:       "returns internal server error when translation fails",
			body:       `{"text":"hola","source_language":"es"}`,
			credential: "fake-credentials",
			setupMock: func(mockTranslate *mockTranslateService) {
				mockTranslate.On("TranslateWithSource", mock.Anything, []string{"hola"}, language.English, language.Spanish).
					Return([]string{}, errors.New("quota exceeded"))
			},
			expectedStatus: http.StatusInternalServerError,
			expectedBody:   `{"error":"Failed to translate text","status_code":500}`,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			mockTranslate := new(mockTranslateService)
			tt.setupMock(mockTranslate)

			manager := New(mockTranslate, tt.credential)
			req := httptest.NewRequest(http.MethodPost, "/api/translation/translate_text", strings.NewReader(tt.body))
			w := httptest.NewRecorder()

			manager.TranslateText(w, req)

			assert.Equal(t, tt.expectedStatus, w.Code)
			assert.Equal(t, tt.expectedBody, w.Body.String())
			mockTranslate.AssertExpectations(t)
		})
	}
}
