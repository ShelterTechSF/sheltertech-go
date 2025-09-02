// mocks.go
package services

import (
	"context"

	"github.com/stretchr/testify/mock"
	"golang.org/x/text/language"
)

// MockTranslateService implements TranslateService interface for testing
type MockTranslateService struct {
	mock.Mock
}

// Translate mocks the translation functionality
func (m *MockTranslateService) Translate(ctx context.Context, texts []string, targetLang language.Tag) ([]string, error) {
	args := m.Called(ctx, texts, targetLang)
	return args.Get(0).([]string), args.Error(1)
}

// Close mocks the close functionality
func (m *MockTranslateService) Close() error {
	args := m.Called()
	return args.Error(0)
}

// MockPDFService implements PDFService interface for testing
type MockPDFService struct {
	mock.Mock
}

// ConvertToPDF mocks the PDF conversion functionality
func (m *MockPDFService) ConvertToPDF(html string) ([]byte, error) {
	args := m.Called(html)
	return args.Get(0).([]byte), args.Error(1)
}
