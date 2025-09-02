// manager_test.go
package services

import (
	"errors"
	"net/http"
	"net/http/httptest"
	"net/url"
	"strings"
	"testing"

	"github.com/sheltertechsf/sheltertech-go/internal/db"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/mock"
	"github.com/stretchr/testify/require"
	"golang.org/x/text/language"
)

// Helper function to create URL-encoded form data
func createFormData(fields map[string]string) *strings.Reader {
	form := url.Values{}
	for key, value := range fields {
		form.Set(key, value)
	}
	return strings.NewReader(form.Encode())
}

// Test the main HTTP handler with various scenarios
func TestManager_ConvertHtmlToPdf_WithMocks(t *testing.T) {
	tests := []struct {
		name               string
		formData           map[string]string
		setupTranslateMock func(*MockTranslateService)
		setupPDFMock       func(*MockPDFService)
		expectedStatus     int
		expectPDF          bool
		expectedError      string
	}{
		{
			name: "successful conversion without translation",
			formData: map[string]string{
				"html": "<html><body><h1>Test</h1></body></html>",
			},
			setupTranslateMock: func(m *MockTranslateService) {
				// No translation expected for empty target_language
			},
			setupPDFMock: func(m *MockPDFService) {
				m.On("ConvertToPDF", "<html><body><h1>Test</h1></body></html>").
					Return([]byte("fake-pdf-content"), nil)
			},
			expectedStatus: http.StatusOK,
			expectPDF:      true,
		},
		{
			name: "successful conversion with spanish translation",
			formData: map[string]string{
				"html":            "<html><body><h1>Hello</h1></body></html>",
				"target_language": "es",
			},
			setupTranslateMock: func(m *MockTranslateService) {
				m.On("Translate",
					mock.Anything, // context - we don't care about the exact context
					[]string{"<html><body><h1>Hello</h1></body></html>"},
					language.Spanish,
				).Return([]string{"<html><body><h1>Hola</h1></body></html>"}, nil)
			},
			setupPDFMock: func(m *MockPDFService) {
				m.On("ConvertToPDF", "<html><body><h1>Hola</h1></body></html>").
					Return([]byte("fake-spanish-pdf"), nil)
			},
			expectedStatus: http.StatusOK,
			expectPDF:      true,
		},
		{
			name: "translation fails with quota error",
			formData: map[string]string{
				"html":            "<html><body><h1>Hello</h1></body></html>",
				"target_language": "es",
			},
			setupTranslateMock: func(m *MockTranslateService) {
				m.On("Translate",
					mock.Anything,
					[]string{"<html><body><h1>Hello</h1></body></html>"},
					language.Spanish,
				).Return([]string{}, errors.New("translation quota exceeded"))
			},
			setupPDFMock: func(m *MockPDFService) {
				// PDF conversion should not be called when translation fails
			},
			expectedStatus: http.StatusInternalServerError,
			expectPDF:      false,
		},
		{
			name: "PDF generation fails",
			formData: map[string]string{
				"html": "<html><body><h1>Test</h1></body></html>",
			},
			setupTranslateMock: func(m *MockTranslateService) {
				// No translation needed
			},
			setupPDFMock: func(m *MockPDFService) {
				m.On("ConvertToPDF", "<html><body><h1>Test</h1></body></html>").
					Return([]byte{}, errors.New("PDF conversion failed: invalid HTML"))
			},
			expectedStatus: http.StatusInternalServerError,
			expectPDF:      false,
		},
		{
			name: "missing HTML content",
			formData: map[string]string{
				"target_language": "es",
				// html is missing
			},
			setupTranslateMock: func(m *MockTranslateService) {
				// Should not be called
			},
			setupPDFMock: func(m *MockPDFService) {
				// Should not be called
			},
			expectedStatus: http.StatusBadRequest,
			expectPDF:      false,
		},
		{
			name: "chinese traditional translation",
			formData: map[string]string{
				"html":            "<html><body>Hello World</body></html>",
				"target_language": "zh-TW",
			},
			setupTranslateMock: func(m *MockTranslateService) {
				m.On("Translate",
					mock.Anything,
					[]string{"<html><body>Hello World</body></html>"},
					language.TraditionalChinese,
				).Return([]string{"<html><body>你好世界</body></html>"}, nil)
			},
			setupPDFMock: func(m *MockPDFService) {
				m.On("ConvertToPDF", "<html><body>你好世界</body></html>").
					Return([]byte("chinese-pdf-content"), nil)
			},
			expectedStatus: http.StatusOK,
			expectPDF:      true,
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

			// Create manager with injected mocks
			manager := NewWithDependencies(
				&db.Manager{},
				mockTranslate, // ← Mock injected here
				mockPDF,       // ← Mock injected here
				GoogleConfig{TranslateCredential: "fake-credentials"},
				PDFCrowdConfig{Enabled: true, User: "test", Key: "test"},
			)

			// Create HTTP request
			formData := createFormData(tt.formData)
			req := httptest.NewRequest("POST", "/convert-html-to-pdf", formData)
			req.Header.Set("Content-Type", "application/x-www-form-urlencoded")
			w := httptest.NewRecorder()

			// Execute the handler
			manager.ConvertHtmlToPdf(w, req)

			// Verify HTTP response
			require.Equal(t, tt.expectedStatus, w.Code, "HTTP status mismatch")

			if tt.expectPDF {
				assert.Equal(t, "application/pdf", w.Header().Get("Content-Type"))
				assert.Equal(t, "attachment; filename=translation.pdf", w.Header().Get("Content-Disposition"))
				assert.Greater(t, len(w.Body.Bytes()), 0, "Expected PDF content in response")
			}

			// Verify all mock expectations were met
			mockTranslate.AssertExpectations(t)
			mockPDF.AssertExpectations(t)
		})
	}
}

// Test individual functions with mocks
func TestManager_translateHTML_WithMocks(t *testing.T) {
	tests := []struct {
		name           string
		html           string
		targetLang     string
		setupMock      func(*MockTranslateService)
		expectedResult string
		expectError    bool
		expectedError  string
	}{
		{
			name:       "successful spanish translation",
			html:       "<html><body>Hello World</body></html>",
			targetLang: "es",
			setupMock: func(m *MockTranslateService) {
				m.On("Translate",
					mock.Anything,
					[]string{"<html><body>Hello World</body></html>"},
					language.Spanish,
				).Return([]string{"<html><body>Hola Mundo</body></html>"}, nil)
			},
			expectedResult: "<html><body>Hola Mundo</body></html>",
			expectError:    false,
		},
		{
			name:       "successful filipino translation",
			html:       "<html><body>Good morning</body></html>",
			targetLang: "tl",
			setupMock: func(m *MockTranslateService) {
				m.On("Translate",
					mock.Anything,
					[]string{"<html><body>Good morning</body></html>"},
					language.Filipino,
				).Return([]string{"<html><body>Magandang umaga</body></html>"}, nil)
			},
			expectedResult: "<html><body>Magandang umaga</body></html>",
			expectError:    false,
		},
		{
			name:       "translation service returns error",
			html:       "<html><body>Hello</body></html>",
			targetLang: "es",
			setupMock: func(m *MockTranslateService) {
				m.On("Translate", mock.Anything, mock.Anything, mock.Anything).
					Return([]string{}, errors.New("translation quota exceeded"))
			},
			expectError:   true,
			expectedError: "translation quota exceeded",
		},
		{
			name:       "empty translation result",
			html:       "<html><body>Hello</body></html>",
			targetLang: "es",
			setupMock: func(m *MockTranslateService) {
				m.On("Translate", mock.Anything, mock.Anything, mock.Anything).
					Return([]string{}, nil) // Empty result array
			},
			expectError:   true,
			expectedError: "no translation returned",
		},
		{
			name:       "unsupported language",
			html:       "<html><body>Hello</body></html>",
			targetLang: "unsupported",
			setupMock: func(m *MockTranslateService) {
				// No mock calls expected for unsupported language
			},
			expectError:   true,
			expectedError: "unsupported language",
		},
		{
			name:       "invalid language code",
			html:       "<html><body>Hello</body></html>",
			targetLang: "invalid-lang-123",
			setupMock: func(m *MockTranslateService) {
				// No mock calls expected - should fail at language parsing
			},
			expectError:   true,
			expectedError: "unsupported language", // Will fail at validation before parsing
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			// Create mock
			mockTranslate := new(MockTranslateService)
			tt.setupMock(mockTranslate)

			// Create manager with mock injected
			manager := NewWithDependencies(
				&db.Manager{},
				mockTranslate, // ← Mock injected
				nil,           // PDF service not needed for this test
				GoogleConfig{TranslateCredential: "fake-creds"},
				PDFCrowdConfig{},
			)

			// Test the method
			result, err := manager.translateHTML(tt.html, tt.targetLang)

			// Verify results
			if tt.expectError {
				require.Error(t, err, "Expected an error but got none")
				if tt.expectedError != "" {
					assert.Contains(t, err.Error(), tt.expectedError, "Error message doesn't contain expected text")
				}
			} else {
				require.NoError(t, err, "Expected no error but got: %v", err)
				assert.Equal(t, tt.expectedResult, result, "Translation result doesn't match expected")
			}

			// Verify mock expectations
			mockTranslate.AssertExpectations(t)
		})
	}
}

func TestManager_htmlToPDF_WithMocks(t *testing.T) {
	tests := []struct {
		name          string
		html          string
		setupMock     func(*MockPDFService)
		expectedBytes []byte
		expectError   bool
		expectedError string
	}{
		{
			name: "successful PDF generation",
			html: "<html><body><h1>Test Content</h1></body></html>",
			setupMock: func(m *MockPDFService) {
				m.On("ConvertToPDF", "<html><body><h1>Test Content</h1></body></html>").
					Return([]byte("fake-pdf-data-here"), nil)
			},
			expectedBytes: []byte("fake-pdf-data-here"),
			expectError:   false,
		},
		{
			name: "PDF service returns error",
			html: "<html><body>Test</body></html>",
			setupMock: func(m *MockPDFService) {
				m.On("ConvertToPDF", "<html><body>Test</body></html>").
					Return([]byte{}, errors.New("PDF conversion failed: invalid HTML"))
			},
			expectError:   true,
			expectedError: "PDF conversion failed",
		},
		{
			name: "empty HTML",
			html: "",
			setupMock: func(m *MockPDFService) {
				m.On("ConvertToPDF", "").
					Return([]byte("empty-html-pdf"), nil)
			},
			expectedBytes: []byte("empty-html-pdf"),
			expectError:   false,
		},
		{
			name: "large HTML content",
			html: strings.Repeat("<p>Large content block</p>", 100),
			setupMock: func(m *MockPDFService) {
				largeHTML := strings.Repeat("<p>Large content block</p>", 100)
				m.On("ConvertToPDF", largeHTML).
					Return([]byte("large-pdf-content"), nil)
			},
			expectedBytes: []byte("large-pdf-content"),
			expectError:   false,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			// Create mock
			mockPDF := new(MockPDFService)
			tt.setupMock(mockPDF)

			// Create manager with mock injected
			manager := NewWithDependencies(
				&db.Manager{},
				nil,     // Translate service not needed
				mockPDF, // ← Mock injected
				GoogleConfig{},
				PDFCrowdConfig{Enabled: true},
			)

			// Test the method
			result, err := manager.htmlToPDF(tt.html)

			// Verify results
			if tt.expectError {
				require.Error(t, err, "Expected an error but got none")
				if tt.expectedError != "" {
					assert.Contains(t, err.Error(), tt.expectedError, "Error message doesn't match")
				}
			} else {
				require.NoError(t, err, "Expected no error but got: %v", err)
				assert.Equal(t, tt.expectedBytes, result, "PDF bytes don't match expected")
			}

			// Verify mock expectations
			mockPDF.AssertExpectations(t)
		})
	}
}

func TestManager_processHTML(t *testing.T) {
	tests := []struct {
		name           string
		html           string
		targetLanguage string
		translateCreds string
		setupMock      func(*MockTranslateService)
		expectedResult string
		expectError    bool
		expectedError  string
	}{
		{
			name:           "no translation needed - english",
			html:           "<html><body><h1>Hello</h1></body></html>",
			targetLanguage: "en",
			translateCreds: "fake-creds",
			setupMock:      func(m *MockTranslateService) {}, // No calls expected
			expectedResult: "<html><body><h1>Hello</h1></body></html>",
			expectError:    false,
		},
		{
			name:           "no translation needed - empty target",
			html:           "<html><body><h1>Hello</h1></body></html>",
			targetLanguage: "",
			translateCreds: "fake-creds",
			setupMock:      func(m *MockTranslateService) {}, // No calls expected
			expectedResult: "<html><body><h1>Hello</h1></body></html>",
			expectError:    false,
		},
		{
			name:           "no translation needed - unsupported language",
			html:           "<html><body><h1>Hello</h1></body></html>",
			targetLanguage: "fr",
			translateCreds: "fake-creds",
			setupMock:      func(m *MockTranslateService) {}, // No calls expected
			expectedResult: "<html><body><h1>Hello</h1></body></html>",
			expectError:    false,
		},
		{
			name:           "translation needed but no credentials",
			html:           "<html><body><h1>Hello</h1></body></html>",
			targetLanguage: "es",
			translateCreds: "",                               // Empty credentials
			setupMock:      func(m *MockTranslateService) {}, // No calls expected
			expectError:    true,
			expectedError:  "PDF translation service is not enabled",
		},
		{
			name:           "successful translation to vietnamese",
			html:           "<html><body><h1>Hello</h1></body></html>",
			targetLanguage: "vi",
			translateCreds: "fake-creds",
			setupMock: func(m *MockTranslateService) {
				m.On("Translate",
					mock.Anything,
					[]string{"<html><body><h1>Hello</h1></body></html>"},
					language.Vietnamese,
				).Return([]string{"<html><body><h1>Xin chào</h1></body></html>"}, nil)
			},
			expectedResult: "<html><body><h1>Xin chào</h1></body></html>",
			expectError:    false,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			// Create mock
			mockTranslate := new(MockTranslateService)
			tt.setupMock(mockTranslate)

			// Create manager
			manager := NewWithDependencies(
				&db.Manager{},
				mockTranslate,
				nil,
				GoogleConfig{TranslateCredential: tt.translateCreds},
				PDFCrowdConfig{},
			)

			// Test the method
			result, err := manager.processHTML(tt.html, tt.targetLanguage)

			// Verify results
			if tt.expectError {
				require.Error(t, err, "Expected an error but got none")
				if tt.expectedError != "" {
					assert.Contains(t, err.Error(), tt.expectedError, "Error message doesn't match")
				}
			} else {
				require.NoError(t, err, "Expected no error but got: %v", err)
				assert.Equal(t, tt.expectedResult, result, "Processed HTML doesn't match expected")
			}

			// Verify mock expectations
			mockTranslate.AssertExpectations(t)
		})
	}
}

// Integration test showing both services working together
func TestManager_CompleteFlow_WithMocks(t *testing.T) {
	mockTranslate := new(MockTranslateService)
	mockPDF := new(MockPDFService)

	// Set up the complete flow expectations
	mockTranslate.On("Translate",
		mock.Anything,
		[]string{"<html><body>Hello World</body></html>"},
		language.Spanish,
	).Return([]string{"<html><body>Hola Mundo</body></html>"}, nil)

	mockPDF.On("ConvertToPDF", "<html><body>Hola Mundo</body></html>").
		Return([]byte("translated-pdf-content"), nil)

	// Create manager with both mocks
	manager := NewWithDependencies(
		&db.Manager{},
		mockTranslate,
		mockPDF,
		GoogleConfig{TranslateCredential: "fake-creds"},
		PDFCrowdConfig{Enabled: true, User: "test", Key: "test"},
	)

	// Create request with translation
	formData := createFormData(map[string]string{
		"html":            "<html><body>Hello World</body></html>",
		"target_language": "es",
	})

	req := httptest.NewRequest("POST", "/convert-html-to-pdf", formData)
	req.Header.Set("Content-Type", "application/x-www-form-urlencoded")
	w := httptest.NewRecorder()

	// Execute complete flow
	manager.ConvertHtmlToPdf(w, req)

	// Verify response
	assert.Equal(t, http.StatusOK, w.Code)
	assert.Equal(t, "application/pdf", w.Header().Get("Content-Type"))
	assert.Equal(t, []byte("translated-pdf-content"), w.Body.Bytes())

	// Verify both services were called as expected
	mockTranslate.AssertExpectations(t)
	mockPDF.AssertExpectations(t)
}

// Test with nil services to verify error handling
func TestManager_WithNilServices(t *testing.T) {
	manager := NewWithDependencies(
		&db.Manager{},
		nil, // ← No translate service
		nil, // ← No PDF service
		GoogleConfig{TranslateCredential: "creds"},
		PDFCrowdConfig{Enabled: true},
	)

	// Test translation with nil service
	_, err := manager.translateHTML("<html>test</html>", "es")
	assert.Error(t, err)
	assert.Contains(t, err.Error(), "translation service not available")

	// Test PDF with nil service
	_, err = manager.htmlToPDF("<html>test</html>")
	assert.Error(t, err)
	assert.Contains(t, err.Error(), "PDF service not available")
}

// Test constructors
func TestNew_CreatesRealServices(t *testing.T) {
	manager := New(
		&db.Manager{},
		"fake-google-creds",
		"fake-user",
		"fake-key",
	)

	// Verify that real services were created (not nil)
	assert.NotNil(t, manager.TranslateService)
	assert.NotNil(t, manager.PDFService)
	assert.NotNil(t, manager.DbClient)

	// Verify config is set up correctly
	assert.Equal(t, "fake-google-creds", manager.GoogleConfig.TranslateCredential)
	assert.True(t, manager.PDFCrowdConfig.Enabled)
	assert.Equal(t, "fake-user", manager.PDFCrowdConfig.User)
	assert.Equal(t, "fake-key", manager.PDFCrowdConfig.Key)
}

func TestNewWithDependencies_InjectsMocks(t *testing.T) {
	mockTranslate := new(MockTranslateService)
	mockPDF := new(MockPDFService)

	manager := NewWithDependencies(
		&db.Manager{},
		mockTranslate,
		mockPDF,
		GoogleConfig{TranslateCredential: "test"},
		PDFCrowdConfig{Enabled: true},
	)

	// Verify that the mocks were injected
	assert.Equal(t, mockTranslate, manager.TranslateService)
	assert.Equal(t, mockPDF, manager.PDFService)
}

// Benchmark test for performance
func BenchmarkManager_processHTML_NoTranslation(b *testing.B) {
	mockTranslate := new(MockTranslateService)
	manager := NewWithDependencies(
		&db.Manager{},
		mockTranslate,
		nil,
		GoogleConfig{TranslateCredential: ""},
		PDFCrowdConfig{},
	)

	html := "<html><body><h1>Test Content</h1><p>Lorem ipsum dolor sit amet</p></body></html>"

	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		_, _ = manager.processHTML(html, "en") // English - no translation
	}
}
