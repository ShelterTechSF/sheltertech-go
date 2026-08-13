package textings

import (
	"bytes"
	"database/sql"
	"encoding/json"
	"errors"
	"fmt"
	"log"
	"net/http"

	"github.com/nyaruka/phonenumbers"
	"github.com/sheltertechsf/sheltertech-go/internal/common"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
)

var ErrTextellentFailure = errors.New("textellent failure")

type TextSender interface {
	Send(data map[string]interface{}) error
}

type Manager struct {
	DbClient *db.Manager
	Sender   TextSender
}

func New(dbManager *db.Manager, textellentURL, textellentAPIKey string) *Manager {
	return &Manager{
		DbClient: dbManager,
		Sender:   NewTextellentSender(textellentURL, textellentAPIKey, http.DefaultClient),
	}
}

func NewWithDependencies(dbManager *db.Manager, sender TextSender) *Manager {
	return &Manager{
		DbClient: dbManager,
		Sender:   sender,
	}
}

type createTextingRequest struct {
	Data createTextingData `json:"data"`
}

type createTextingData struct {
	RecipientName string `json:"recipient_name"`
	PhoneNumber   string `json:"phone_number"`
	ServiceID     *int   `json:"service_id"`
	ResourceID    *int   `json:"resource_id"`
}

func (m *Manager) Create(w http.ResponseWriter, r *http.Request) {
	var req createTextingRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusBadRequest, "Invalid request body")
		return
	}

	if (req.Data.ServiceID == nil && req.Data.ResourceID == nil) || (req.Data.ServiceID != nil && req.Data.ResourceID != nil) {
		common.WriteErrorJson(w, http.StatusBadRequest, "Exactly one of service_id or resource_id is required")
		return
	}

	phoneNumber, err := parsePhoneNumber(req.Data.PhoneNumber)
	if err != nil {
		common.WriteErrorJson(w, http.StatusBadRequest, "Invalid phone number")
		return
	}

	textData, err := m.aggregateTextData(req.Data.RecipientName, phoneNumber, req.Data.ServiceID, req.Data.ResourceID)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusBadRequest, "Listing not found")
		return
	}

	err = m.Sender.Send(textData)
	if errors.Is(err, ErrTextellentFailure) {
		common.WriteErrorJson(w, http.StatusBadRequest, "failure")
		return
	}
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusInternalServerError, common.InternalServerErrorMessage)
		return
	}

	err = m.DbClient.SaveTexting(req.Data.RecipientName, phoneNumber, req.Data.ServiceID, req.Data.ResourceID)
	if err != nil {
		log.Printf("%v", err)
		common.WriteErrorJson(w, http.StatusInternalServerError, common.InternalServerErrorMessage)
		return
	}

	writeJSON(w, map[string]string{"message": "success"}, http.StatusOK)
}

func (m *Manager) aggregateTextData(recipientName, phoneNumber string, serviceID, resourceID *int) (map[string]interface{}, error) {
	if serviceID != nil {
		service, err := m.DbClient.GetServiceById(*serviceID)
		if err != nil || service == nil || !service.ResourceId.Valid {
			return nil, fmt.Errorf("service not found")
		}

		resource := m.DbClient.GetResourceById(int(service.ResourceId.Int32))
		if resource == nil {
			return nil, fmt.Errorf("resource not found")
		}

		categories := categoryNames(m.DbClient.GetCategoriesByServiceID(*serviceID))
		phone := firstResourcePhone(m.DbClient.GetPhonesByResourceID(resource.Id))
		addresses := m.DbClient.GetAddressesByServiceID(*serviceID)
		if len(addresses) == 0 {
			addresses = m.DbClient.GetAddressesByResourceID(resource.Id)
		}

		return generateTextellentData(recipientName, phoneNumber, categories, nullStringValue(service.Name), firstAddress(addresses, phone)), nil
	}

	resource := m.DbClient.GetResourceById(*resourceID)
	if resource == nil {
		return nil, fmt.Errorf("resource not found")
	}

	categories := categoryNames(m.DbClient.GetCategoriesByResourceID(*resourceID))
	phone := firstResourcePhone(m.DbClient.GetPhonesByResourceID(*resourceID))
	addresses := m.DbClient.GetAddressesByResourceID(*resourceID)
	return generateTextellentData(recipientName, phoneNumber, categories, resource.Name, firstAddress(addresses, phone)), nil
}

func parsePhoneNumber(phoneNumber string) (string, error) {
	parsed, err := phonenumbers.Parse(phoneNumber, "US")
	if err != nil {
		return "", err
	}
	if parsed.NationalNumber == nil {
		return "", fmt.Errorf("invalid phone number")
	}

	return fmt.Sprintf("%d", *parsed.NationalNumber), nil
}

func categoryNames(categories []*db.Category) []string {
	names := []string{}
	for _, category := range categories {
		names = append(names, category.Name)
	}
	return names
}

func firstResourcePhone(phones []*db.Phone) string {
	if len(phones) == 0 {
		return ""
	}
	return phones[0].Number
}

func firstAddress(addresses []*db.Address, phone string) map[string]string {
	if len(addresses) == 0 {
		return map[string]string{
			"address1":       "",
			"address2":       "",
			"city":           "",
			"state_province": "",
			"postal_code":    "",
			"phone":          phone,
		}
	}

	address := addresses[0]
	return map[string]string{
		"address1":       address.Address1,
		"address2":       nullStringValue(address.Address2),
		"city":           address.City,
		"state_province": address.StateProvince,
		"postal_code":    address.PostalCode,
		"phone":          phone,
	}
}

func generateTextellentData(recipientName, phoneNumber string, categories []string, listingName string, address map[string]string) map[string]interface{} {
	return map[string]interface{}{
		"firstName":      recipientName,
		"lastName":       "",
		"mobilePhone":    phoneNumber,
		"phoneAlternate": "",
		"phoneHome":      "",
		"phoneWork":      "",
		"tags":           categories,
		"engagementType": "Resource Info",
		"engagementInfo": map[string]string{
			"Org_Name":     listingName,
			"Org_Address1": address["address1"],
			"Org_Address2": address["address2"],
			"City":         address["city"],
			"State":        address["state_province"],
			"Zip":          address["postal_code"],
			"Org_Phone":    address["phone"],
		},
	}
}

func nullStringValue(value sql.NullString) string {
	if !value.Valid {
		return ""
	}
	return value.String
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

type HTTPDoer interface {
	Do(req *http.Request) (*http.Response, error)
}

type TextellentSender struct {
	URL        string
	APIKey     string
	HTTPClient HTTPDoer
}

func NewTextellentSender(url, apiKey string, httpClient HTTPDoer) *TextellentSender {
	return &TextellentSender{
		URL:        url,
		APIKey:     apiKey,
		HTTPClient: httpClient,
	}
}

func (s *TextellentSender) Send(data map[string]interface{}) error {
	if s.URL == "" || s.APIKey == "" {
		return fmt.Errorf("textellent credentials not provided")
	}
	if s.HTTPClient == nil {
		return fmt.Errorf("http client not provided")
	}

	body, err := json.Marshal(data)
	if err != nil {
		return err
	}

	req, err := http.NewRequest(http.MethodPost, s.URL, bytes.NewReader(body))
	if err != nil {
		return err
	}
	req.Header.Set("Content-Type", "application/json")
	req.Header.Set("authCode", s.APIKey)

	resp, err := s.HTTPClient.Do(req)
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	var response struct {
		Status string `json:"status"`
	}
	if err := json.NewDecoder(resp.Body).Decode(&response); err != nil {
		return err
	}
	if response.Status != "success" {
		return ErrTextellentFailure
	}

	return nil
}
