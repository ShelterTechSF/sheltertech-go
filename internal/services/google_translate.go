package services

import (
	"context"
	"fmt"
	"strings"

	"cloud.google.com/go/translate"
	"golang.org/x/text/language"
	"google.golang.org/api/option"
)

// GoogleTranslateService implements TranslateService interface
type GoogleTranslateService struct {
	credentials string
}

// NewGoogleTranslateService creates a new Google Translate service instance
func NewGoogleTranslateService(credentials string) *GoogleTranslateService {
	return &GoogleTranslateService{
		credentials: credentials,
	}
}

// Translate translates the given texts to the target language
func (g *GoogleTranslateService) Translate(ctx context.Context, texts []string, targetLang language.Tag) ([]string, error) {
	if g.credentials == "" {
		return nil, fmt.Errorf("translation credentials not provided")
	}

	// Create Google Translate client
	client, err := translate.NewClient(ctx, option.WithCredentialsJSON([]byte(g.credentials)))
	if err != nil {
		return nil, fmt.Errorf("failed to create translate client: %v", err)
	}
	defer client.Close()

	// Perform translation
	translations, err := client.Translate(ctx, texts, targetLang, nil)
	if err != nil {
		// Handle quota/rate limit errors specifically
		if strings.Contains(err.Error(), "quota") || strings.Contains(err.Error(), "limit") {
			return nil, fmt.Errorf("translation quota exceeded")
		}
		return nil, fmt.Errorf("translation failed: %v", err)
	}

	// Extract translated text
	var results []string
	for _, t := range translations {
		results = append(results, t.Text)
	}

	return results, nil
}
