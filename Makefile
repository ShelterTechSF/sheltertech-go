SHELL := /bin/bash

# go source files, ignore vendor directory
SRC = $(shell find . -type f -name '*.go' -not -path "./vendor/*")
.PHONY: run test integration-test build ci-run generate-test-keys fmt

# Dev Commands

## Runs the api service in a way that depends on the database from the askdarcel-api project
run: docker-exists
	docker compose -f docker-compose.dev.yml build && docker compose -f docker-compose.dev.yml up

## Runs the api service in a way that brings up its own database and does not require anything from askdarcel-api running
run-standalone: docker-exists
	docker compose -f docker-compose.ci.yml build && docker compose -f docker-compose.ci.yml up

# Test Commands

## Unit tests which require no other dependencies
test: go-exists
	go test -v ./...

## Brings up the CI stack, runs integration tests, then tears down.
integration-test: docker-exists go-exists generate-test-keys
	docker compose -f docker-compose.dev.yml down
	docker compose -f docker-compose.ci.yml build && docker compose -f docker-compose.ci.yml up -d
	ISSUER_URL=http://jwks-server/ AUTH0_AUDIENCE=https://test.sheltertech.org go test -v -tags=integration ./... ; docker compose -f docker-compose.ci.yml down

## Generates test RSA key pair and jwks.json. Used by CI before starting the stack.
## Safe to run multiple times — skips generation if keys already exist.
generate-test-keys: go-exists
	@if [ ! -f test/private_key.pem ] || [ ! -f test/jwks.json ]; then \
		echo "Generating test keys..."; \
		go run test/generate_keys.go; \
	else \
		echo "Test keys already exist, skipping generation."; \
	fi

# CI Commands

## Used in CI to do a quick compile check
build: go-exists
	go build -v ./...

## Used in CI to start a database in the background along with the api service
## Running this yourself allows you to create what happens in CI
ci-run: docker-exists
	docker compose -f docker-compose.ci.yml build && docker compose -f docker-compose.ci.yml up -d

# Utility

## Format go files in repo
fmt: go-exists
	@gofmt -l -w $(SRC)

go-exists:
ifeq (, $(shell which go))
    $(error golang is not installed on this machine, you may use `brew install go` to install it.)
endif

docker-exists:
ifeq (, $(shell which docker))
    $(error docker is not installed on this machine, you will need to install docker.)
endif