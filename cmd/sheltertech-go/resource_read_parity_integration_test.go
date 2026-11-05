//go:build integration

package main

import (
	"encoding/json"
	"fmt"
	"github.com/sheltertechsf/sheltertech-go/internal/resources"
	"github.com/stretchr/testify/require"
	"net/http"
	"testing"
)

func TestResourceReadPreservesRailsCoordinatePrecision(t *testing.T) {
	manager := integrationDBManager()
	defer manager.DB.Close()
	var id int
	require.NoError(t, manager.DB.QueryRow(`INSERT INTO public.addresses (resource_id,address_1,city,state_province,postal_code,latitude,longitude,created_at,updated_at) VALUES (1,'Parity address','San Francisco','CA','94107',37.7820802732529,-122.395060956365,NOW(),NOW()) RETURNING id`).Scan(&id))
	defer manager.DB.Exec("DELETE FROM public.addresses WHERE id=$1", id)
	response, err := http.Get(fmt.Sprintf("%s/1", resourceUrl))
	require.NoError(t, err)
	defer response.Body.Close()
	require.Equal(t, 200, response.StatusCode)
	var body resources.ResourceResponse
	require.NoError(t, json.NewDecoder(response.Body).Decode(&body))
	for _, address := range body.Resource.Addresses {
		if address.Id == id {
			require.NotNil(t, address.Latitude)
			require.NotNil(t, address.Longitude)
			require.Equal(t, "37.7820802732529", *address.Latitude)
			require.Equal(t, "-122.395060956365", *address.Longitude)
			return
		}
	}
	t.Fatal("created resource address missing from response")
}
