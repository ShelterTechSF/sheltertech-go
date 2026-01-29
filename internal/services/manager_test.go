// manager_test.go
package services

import (
	"encoding/json"
	"errors"
	"net/http"
	"net/http/httptest"
	"net/url"
	"strings"
	"testing"

	"github.com/sheltertechsf/sheltertech-go/internal/db"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/mock"
	"golang.org/x/text/language"
)

func TestManager_ConvertHtmlToPdf(t *testing.T) {
	tests := []struct {
		name               string
		requestSetup       func() (*http.Request, *httptest.ResponseRecorder)
		setupTranslateMock func(*MockTranslateService)
		setupPDFMock       func(*MockPDFService)
		expectedStatus     int
		expectedErrorMsg   string
	}{
		{
			name: "HTML content required validation",
			requestSetup: func() (*http.Request, *httptest.ResponseRecorder) {
				formData := url.Values{}
				formData.Set("target_language", "es")
				// HTML field is completely missing
				req := httptest.NewRequest("POST", "/api/convert-html-to-pdf", strings.NewReader(formData.Encode()))
				req.Header.Set("Content-Type", "application/x-www-form-urlencoded")
				return req, httptest.NewRecorder()
			},
			setupTranslateMock: func(m *MockTranslateService) {
				// Should not be called - fails validation first
			},
			setupPDFMock: func(m *MockPDFService) {
				// Should not be called - fails validation first
			},
			expectedStatus:   http.StatusBadRequest,
			expectedErrorMsg: "HTML content is required",
		},
		{
			name: "form parsing fails - invalid URL encoding",
			requestSetup: func() (*http.Request, *httptest.ResponseRecorder) {
				// Invalid percent encoding that will cause ParseForm() to fail
				malformedData := "html=%ZZ&target_language=es"
				req := httptest.NewRequest("POST", "/convert-html-to-pdf", strings.NewReader(malformedData))
				req.Header.Set("Content-Type", "application/x-www-form-urlencoded")
				return req, httptest.NewRecorder()
			},
			setupTranslateMock: func(m *MockTranslateService) {
				// Should not be called - form parsing fails first
			},
			setupPDFMock: func(m *MockPDFService) {
				// Should not be called - form parsing fails first
			},
			expectedStatus:   http.StatusBadRequest,
			expectedErrorMsg: "Error parsing form data",
		},
		{
			name: "PDF service fails",
			requestSetup: func() (*http.Request, *httptest.ResponseRecorder) {
				formData := url.Values{}
				formData.Set("html", "<html><body>Test</body></html>")
				// No target_language - skip translation, go straight to PDF
				req := httptest.NewRequest("POST", "/convert-html-to-pdf", strings.NewReader(formData.Encode()))
				req.Header.Set("Content-Type", "application/x-www-form-urlencoded")
				return req, httptest.NewRecorder()
			},
			setupTranslateMock: func(m *MockTranslateService) {
				// No translation needed - no target language
			},
			setupPDFMock: func(m *MockPDFService) {
				m.On("ConvertToPDF", "<html><body>Test</body></html>").
					Return([]byte{}, errors.New("PDFCrowd service unavailable"))
			},
			expectedStatus:   http.StatusInternalServerError,
			expectedErrorMsg: "Failed to convert HTML to PDF",
		},
		{
			name: "Google Translate service fails",
			requestSetup: func() (*http.Request, *httptest.ResponseRecorder) {
				formData := url.Values{}
				formData.Set("html", "<html><body>Hello World</body></html>")
				formData.Set("target_language", "es")
				req := httptest.NewRequest("POST", "/convert-html-to-pdf", strings.NewReader(formData.Encode()))
				req.Header.Set("Content-Type", "application/x-www-form-urlencoded")
				return req, httptest.NewRecorder()
			},
			setupTranslateMock: func(m *MockTranslateService) {
				m.On("Translate",
					mock.Anything, // Context Object
					[]string{"<html><body>Hello World</body></html>"},
					language.Spanish,
				).Return([]string{}, errors.New("translation quota exceeded"))
			},
			setupPDFMock: func(m *MockPDFService) {
				// Should not be called - translation fails first
			},
			expectedStatus:   http.StatusInternalServerError,
			expectedErrorMsg: "Failed to process HTML",
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			// Create fresh mocks for each test
			mockTranslate := new(MockTranslateService)
			mockPDF := new(MockPDFService)

			// Set up mock expectations
			tt.setupTranslateMock(mockTranslate)
			tt.setupPDFMock(mockPDF)

			// Create manager with mocks
			manager := NewWithDependencies(
				&db.Manager{},
				mockTranslate,
				mockPDF,
				GoogleConfig{TranslateCredential: "fake-credentials"},
				PDFCrowdConfig{Enabled: true, User: "test", Key: "test"},
			)

			// Create request using test-specific setup
			req, w := tt.requestSetup()

			// Execute the handler
			manager.ConvertHtmlToPdf(w, req)

			// Verify HTTP status
			assert.Equal(t, tt.expectedStatus, w.Code, "HTTP status mismatch")

			// Verify error response structure for error cases
			if tt.expectedStatus >= 400 {
				assert.Equal(t, "application/json", w.Header().Get("Content-Type"))

				// Parse JSON error response
				var errorResponse map[string]interface{}
				err := json.Unmarshal(w.Body.Bytes(), &errorResponse)
				assert.NoError(t, err, "Error response should be valid JSON")

				// Verify specific error message
				message, exists := errorResponse["error"]
				assert.True(t, exists, "Error response should have 'message' field")
				assert.Contains(t, message, tt.expectedErrorMsg, "Error message should contain expected text")
			}

			// Verify mock expectations were met
			mockTranslate.AssertExpectations(t)
			mockPDF.AssertExpectations(t)
		})
	}
}
func TestManager_processHTML_ErrorHandling(t *testing.T) {
	tests := []struct {
		name                string
		html                string
		targetLanguage      string
		translateCredential string
		setupTranslateMock  func(*MockTranslateService)
		expectedError       string
		expectError         bool
	}{
		{
			name:                "supported language but no credentials",
			html:                "<html><body>Hello</body></html>",
			targetLanguage:      "es", // Spanish is supported
			translateCredential: "",   // Empty credentials
			setupTranslateMock: func(m *MockTranslateService) {
				// Should not be called - credential check happens first
			},
			expectedError: "PDF translation service is not enabled right now. Please contact support or try again later",
			expectError:   true,
		},
		{
			name:                "vietnamese language but no credentials",
			html:                "<html><body>Good morning</body></html>",
			targetLanguage:      "vi", // Vietnamese is supported
			translateCredential: "",
			setupTranslateMock: func(m *MockTranslateService) {
				// Should not be called
			},
			expectedError: "PDF translation service is not enabled right now. Please contact support or try again later",
			expectError:   true,
		},
		{
			name:                "chinese traditional but no credentials",
			html:                "<html><body>Hello World</body></html>",
			targetLanguage:      "zh-TW", // Chinese Traditional is supported
			translateCredential: "",
			setupTranslateMock: func(m *MockTranslateService) {
				// Should not be called
			},
			expectedError: "PDF translation service is not enabled right now. Please contact support or try again later",
			expectError:   true,
		},
		{
			name:                "russian language but no credentials",
			html:                "<html><body>Test content</body></html>",
			targetLanguage:      "ru", // Russian is supported
			translateCredential: "",
			setupTranslateMock: func(m *MockTranslateService) {
				// Should not be called
			},
			expectedError: "PDF translation service is not enabled right now. Please contact support or try again later",
			expectError:   true,
		},
		{
			name:                "arabic language but no credentials",
			html:                "<html><body>Welcome</body></html>",
			targetLanguage:      "ar", // Arabic is supported
			translateCredential: "",
			setupTranslateMock: func(m *MockTranslateService) {
				// Should not be called
			},
			expectedError: "PDF translation service is not enabled right now. Please contact support or try again later",
			expectError:   true,
		},
		{
			name:                "filipino/tagalog language but no credentials",
			html:                "<html><body>Hello</body></html>",
			targetLanguage:      "tl", // Filipino/Tagalog is supported
			translateCredential: "",
			setupTranslateMock: func(m *MockTranslateService) {
				// Should not be called
			},
			expectedError: "PDF translation service is not enabled right now. Please contact support or try again later",
			expectError:   true,
		},
		{
			name:                "supported language with credentials but translateHTML fails",
			html:                "<html><body>Hello</body></html>",
			targetLanguage:      "es",
			translateCredential: "fake-valid-credentials",
			setupTranslateMock: func(m *MockTranslateService) {
				// Mock translateHTML to fail
				m.On("Translate", mock.Anything, mock.Anything, language.Spanish).
					Return([]string{}, errors.New("translation API error"))
			},
			expectedError: "translation API error", // Error from translateHTML
			expectError:   true,
		},
		{
			name:                "unsupported language - should not error",
			html:                "<html><body>Hello</body></html>",
			targetLanguage:      "fr", // French is NOT supported
			translateCredential: "fake-credentials",
			setupTranslateMock: func(m *MockTranslateService) {
				// Should not be called - unsupported language
			},
			expectError: false, // Should return original HTML without error
		},
		{
			name:                "empty target language - should not error",
			html:                "<html><body>Hello</body></html>",
			targetLanguage:      "", // Empty target language
			translateCredential: "fake-credentials",
			setupTranslateMock: func(m *MockTranslateService) {
				// Should not be called - empty target language
			},
			expectError: false, // Should return original HTML without error
		},
		{
			name:                "english target language - should not error",
			html:                "<html><body>Hello</body></html>",
			targetLanguage:      "en", // English - no translation needed
			translateCredential: "fake-credentials",
			setupTranslateMock: func(m *MockTranslateService) {
				// Should not be called - English doesn't need translation
			},
			expectError: false, // Should return original HTML without error
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			// Create mock
			mockTranslate := new(MockTranslateService)
			tt.setupTranslateMock(mockTranslate)

			// Create manager with specific credential configuration
			manager := NewWithDependencies(
				&db.Manager{},
				mockTranslate,
				nil, // PDF service not needed for this test
				GoogleConfig{TranslateCredential: tt.translateCredential},
				PDFCrowdConfig{},
			)

			// Call the processHTML method
			result, err := manager.processHTML(tt.html, tt.targetLanguage)

			// Verify error expectations
			if tt.expectError {
				assert.Error(t, err, "Expected an error but got none")
				assert.Contains(t, err.Error(), tt.expectedError, "Error message should contain expected text")
				assert.Empty(t, result, "Result should be empty on error")
			} else {
				assert.NoError(t, err, "Expected no error but got: %v", err)
				assert.Equal(t, tt.html, result, "Should return original HTML unchanged")
			}

			// Verify mock expectations
			mockTranslate.AssertExpectations(t)
		})
	}
}
func TestManager_translateHTML_ErrorHandling(t *testing.T) {
	tests := []struct {
		name             string
		html             string
		targetLanguage   string
		translateService TranslateService
		setupMock        func(*MockTranslateService)
		expectedError    string
		expectError      bool
	}{
		{
			name:             "unsupported language - french",
			html:             "<html><body>Hello</body></html>",
			targetLanguage:   "fr", // French not in supported list
			translateService: new(MockTranslateService),
			setupMock: func(m *MockTranslateService) {
				// Should not be called - fails language validation first
			},
			expectedError: "unsupported language: fr",
			expectError:   true,
		},
		{
			name:             "unsupported language - german",
			html:             "<html><body>Hello</body></html>",
			targetLanguage:   "de", // German not in supported list
			translateService: new(MockTranslateService),
			setupMock: func(m *MockTranslateService) {
				// Should not be called
			},
			expectedError: "unsupported language: de",
			expectError:   true,
		},
		{
			name:             "unsupported language - empty string",
			html:             "<html><body>Hello</body></html>",
			targetLanguage:   "", // Empty string not in supported list
			translateService: new(MockTranslateService),
			setupMock: func(m *MockTranslateService) {
				// Should not be called
			},
			expectedError: "unsupported language: ",
			expectError:   true,
		},
		{
			name:             "translation service is nil",
			html:             "<html><body>Hello</body></html>",
			targetLanguage:   "es", // Spanish is supported
			translateService: nil,  // Nil service
			setupMock: func(m *MockTranslateService) {
				// Not used - service is nil
			},
			expectedError: "translation service not available",
			expectError:   true,
		},
		{
			name:             "invalid language code format",
			html:             "<html><body>Hello</body></html>",
			targetLanguage:   "invalid-lang-code-123", // Invalid format
			translateService: new(MockTranslateService),
			setupMock: func(m *MockTranslateService) {
				// Should not be called - fails language parsing
			},
			expectedError: "unsupported language: invalid-lang-code-123", // Fails at validation step
			expectError:   true,
		},
		{
			name:             "translation service returns error",
			html:             "<html><body>Hello</body></html>",
			targetLanguage:   "es",
			translateService: new(MockTranslateService),
			setupMock: func(m *MockTranslateService) {
				m.On("Translate", mock.Anything, []string{"<html><body>Hello</body></html>"}, language.Spanish).
					Return([]string{}, errors.New("API quota exceeded"))
			},
			expectedError: "API quota exceeded",
			expectError:   true,
		},
		{
			name:             "translation service returns empty result",
			html:             "<html><body>Hello</body></html>",
			targetLanguage:   "es",
			translateService: new(MockTranslateService),
			setupMock: func(m *MockTranslateService) {
				m.On("Translate", mock.Anything, []string{"<html><body>Hello</body></html>"}, language.Spanish).
					Return([]string{}, nil) // Empty slice, no error
			},
			expectedError: "no translation returned",
			expectError:   true,
		},
		{
			name:             "translation service returns nil result",
			html:             "<html><body>Hello</body></html>",
			targetLanguage:   "vi",
			translateService: new(MockTranslateService),
			setupMock: func(m *MockTranslateService) {
				m.On("Translate", mock.Anything, []string{"<html><body>Hello</body></html>"}, language.Vietnamese).
					Return([]string(nil), nil) // Explicitly nil slice
			},
			expectedError: "no translation returned",
			expectError:   true,
		},
		{
			name:             "chinese traditional - translation service error",
			html:             "<html><body>Hello World</body></html>",
			targetLanguage:   "zh-TW",
			translateService: new(MockTranslateService),
			setupMock: func(m *MockTranslateService) {
				// Parse zh-TW to get the actual language tag that the code will use
				expectedLang, _ := language.Parse("zh-TW")
				m.On("Translate", mock.Anything, []string{"<html><body>Hello World</body></html>"}, expectedLang).
					Return([]string{}, errors.New("translation timeout"))
			},
			expectedError: "translation timeout",
			expectError:   true,
		},
		{
			name:             "russian - empty translation result",
			html:             "<html><body>Good morning</body></html>",
			targetLanguage:   "ru",
			translateService: new(MockTranslateService),
			setupMock: func(m *MockTranslateService) {
				m.On("Translate", mock.Anything, []string{"<html><body>Good morning</body></html>"}, language.Russian).
					Return([]string{}, nil)
			},
			expectedError: "no translation returned",
			expectError:   true,
		},
		{
			name:             "arabic - translation service network error",
			html:             "<html><body>Welcome</body></html>",
			targetLanguage:   "ar",
			translateService: new(MockTranslateService),
			setupMock: func(m *MockTranslateService) {
				m.On("Translate", mock.Anything, []string{"<html><body>Welcome</body></html>"}, language.Arabic).
					Return([]string{}, errors.New("network connection failed"))
			},
			expectedError: "network connection failed",
			expectError:   true,
		},
		{
			name:             "tagalog - empty translation response",
			html:             "<html><body>Hello friend</body></html>",
			targetLanguage:   "tl",
			translateService: new(MockTranslateService),
			setupMock: func(m *MockTranslateService) {
				m.On("Translate", mock.Anything, []string{"<html><body>Hello friend</body></html>"}, language.Filipino).
					Return([]string{}, nil)
			},
			expectedError: "no translation returned",
			expectError:   true,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			var mockTranslate *MockTranslateService

			// Set up mock if service is not nil
			if tt.translateService != nil {
				mockTranslate = tt.translateService.(*MockTranslateService)
				tt.setupMock(mockTranslate)
			}

			// Create manager with the configured service (might be nil)
			manager := NewWithDependencies(
				&db.Manager{},
				tt.translateService, // This might be nil for some tests
				nil,                 // PDF service not needed
				GoogleConfig{TranslateCredential: "fake-credentials"},
				PDFCrowdConfig{},
			)

			// Call translateHTML
			result, err := manager.translateHTML(tt.html, tt.targetLanguage)

			// Verify error expectations
			if tt.expectError {
				assert.Error(t, err, "Expected an error but got none")
				assert.Contains(t, err.Error(), tt.expectedError, "Error message should contain expected text")
				assert.Empty(t, result, "Result should be empty on error")
			} else {
				assert.NoError(t, err, "Expected no error but got: %v", err)
				assert.NotEmpty(t, result, "Result should not be empty on success")
			}

			// Verify mock expectations if mock was used
			if mockTranslate != nil {
				mockTranslate.AssertExpectations(t)
			}
		})
	}
}
