//go:build integration
// +build integration

package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
	"os"
	"sync"
)

var (
	cachedToken string
	tokenOnce   sync.Once
)

type tokenResponse struct {
	AccessToken string `json:"access_token"`
}

// getTestToken fetches a client credentials token from Auth0 and caches it for the test run.
func getTestToken() string {
	tokenOnce.Do(func() {
		domain := os.Getenv("AUTH0_DOMAIN")
		clientID := os.Getenv("AUTH0_CLIENT_ID")
		clientSecret := os.Getenv("AUTH0_CLIENT_SECRET")
		audience := os.Getenv("AUTH0_AUDIENCE")

		payload := map[string]string{
			"client_id":     clientID,
			"client_secret": clientSecret,
			"audience":      audience,
			"grant_type":    "client_credentials",
		}

		body, err := json.Marshal(payload)
		if err != nil {
			panic(fmt.Sprintf("failed to marshal token request: %v", err))
		}

		url := fmt.Sprintf("https://%s/oauth/token", domain)
		resp, err := http.Post(url, "application/json", bytes.NewBuffer(body))
		if err != nil {
			panic(fmt.Sprintf("failed to fetch token from Auth0: %v", err))
		}
		defer resp.Body.Close()

		respBody, err := ioutil.ReadAll(resp.Body)
		if err != nil {
			panic(fmt.Sprintf("failed to read token response: %v", err))
		}

		var tokenResp tokenResponse
		if err := json.Unmarshal(respBody, &tokenResp); err != nil {
			panic(fmt.Sprintf("failed to unmarshal token response: %v", err))
		}

		if tokenResp.AccessToken == "" {
			panic(fmt.Sprintf("got empty access token from Auth0, response: %s", string(respBody)))
		}

		cachedToken = tokenResp.AccessToken
	})

	return cachedToken
}

// newAuthRequest creates an HTTP request with the Bearer token attached.
func newAuthRequest(method, url string, body *bytes.Buffer) (*http.Request, error) {
	var req *http.Request
	var err error

	if body != nil {
		req, err = http.NewRequest(method, url, body)
	} else {
		req, err = http.NewRequest(method, url, nil)
	}
	if err != nil {
		return nil, err
	}

	req.Header.Set("Authorization", "Bearer "+getTestToken())
	req.Header.Set("Content-Type", "application/json")
	return req, nil
}
