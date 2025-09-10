package services

import (
	"fmt"

	"github.com/pdfcrowd/pdfcrowd-go"
)

// PDFCrowdService implements PDFService interface
type PDFCrowdService struct {
	enabled bool
	user    string
	key     string
}

// NewPDFCrowdService creates a new PDFCrowd service instance
func NewPDFCrowdService(enabled bool, user, key string) *PDFCrowdService {
	return &PDFCrowdService{
		enabled: enabled,
		user:    user,
		key:     key,
	}
}

// ConvertToPDF converts HTML content to PDF using PDFCrowd service
func (p *PDFCrowdService) ConvertToPDF(html string) ([]byte, error) {
	if !p.enabled {
		return nil, fmt.Errorf("dynamic PDF generation is not enabled")
	}

	if p.user == "" || p.key == "" {
		return nil, fmt.Errorf("PDFCrowd credentials not provided")
	}

	// Create PDFCrowd client
	client := pdfcrowd.NewHtmlToPdfClient(p.user, p.key)

	// Set page margins
	client.SetPageMargins("0.2in", "0.2in", "0.2in", "0.2in")

	// Convert HTML to PDF
	pdfBytes, err := client.ConvertString(html)
	if err != nil {
		return nil, fmt.Errorf("PDF conversion failed: %v", err)
	}

	return pdfBytes, nil
}
