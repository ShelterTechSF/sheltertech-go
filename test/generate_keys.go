//go:build ignore

// Run with: go run test/generate_keys.go
// Generates test RSA key pair and jwks.json for the local JWKS server.
// Re-run this if you need to rotate test keys.
// All output files are gitignored — never commit them.

package main

import (
	"crypto/rand"
	"crypto/rsa"
	"crypto/x509"
	"encoding/base64"
	"encoding/json"
	"encoding/pem"
	"math/big"
	"os"
)

func main() {
	if err := os.MkdirAll("test", 0755); err != nil {
		panic(err)
	}

	jwtKey, err := rsa.GenerateKey(rand.Reader, 2048)
	if err != nil {
		panic(err)
	}

	privFile, err := os.Create("test/private_key.pem")
	if err != nil {
		panic(err)
	}
	if err := pem.Encode(privFile, &pem.Block{
		Type:  "RSA PRIVATE KEY",
		Bytes: x509.MarshalPKCS1PrivateKey(jwtKey),
	}); err != nil {
		panic(err)
	}
	privFile.Close()

	n := base64.RawURLEncoding.EncodeToString(jwtKey.PublicKey.N.Bytes())
	e := base64.RawURLEncoding.EncodeToString(big.NewInt(int64(jwtKey.PublicKey.E)).Bytes())

	jwks := map[string]interface{}{
		"keys": []map[string]interface{}{
			{
				"kty": "RSA",
				"use": "sig",
				"alg": "RS256",
				"kid": "test-key-1",
				"n":   n,
				"e":   e,
			},
		},
	}

	jwksBytes, err := json.MarshalIndent(jwks, "", "  ")
	if err != nil {
		panic(err)
	}
	if err := os.WriteFile("test/jwks.json", jwksBytes, 0644); err != nil {
		panic(err)
	}

	println("Generated:")
	println("  test/private_key.pem")
	println("  test/jwks.json")
}
