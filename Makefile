SHELL := /bin/bash

# go source files, ignore vendor directory
SRC = $(shell find . -type f -name '*.go' -not -path "./vendor/*")
INTEGRATION_DB_HOST ?= auto
INTEGRATION_DB_PORT ?= 5432
INTEGRATION_DB_NAME ?= askdarcel_development
INTEGRATION_DB_USER ?= postgres
INTEGRATION_DB_PASS ?=
.PHONY: run test integration-test build ci-run fmt

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

## Expects a server running on localhost:3001 from the dev flow
integration-test: go-exists docker-exists integration-db-up integration-db-wait
	@DB_HOST=$$(if [ "$(INTEGRATION_DB_HOST)" = "auto" ]; then \
		if grep -qi microsoft /proc/version 2>/dev/null; then echo host.docker.internal; else echo localhost; fi; \
	else \
		echo "$(INTEGRATION_DB_HOST)"; \
	fi); \
	DB_HOST="$$DB_HOST" DB_PORT=$(INTEGRATION_DB_PORT) DB_NAME=$(INTEGRATION_DB_NAME) DB_USER=$(INTEGRATION_DB_USER) DB_PASS=$(INTEGRATION_DB_PASS) go test -v -tags=integration ./...

integration-db-up: docker-exists
	docker compose -f docker-compose.ci.yml up -d db

integration-db-wait: docker-exists
	@echo "Waiting for CI Postgres to be ready on localhost:5432..."
	@for i in {1..30}; do \
		docker compose -f docker-compose.ci.yml exec -T db pg_isready -U postgres -d askdarcel_development >/dev/null 2>&1 && exit 0; \
		echo "  attempt $$i/30: not ready yet"; \
		sleep 1; \
	done; \
	echo "Postgres did not become ready in time"; \
	exit 1

integration-debug: docker-exists
	@DB_HOST=$$(if [ "$(INTEGRATION_DB_HOST)" = "auto" ]; then \
		if grep -qi microsoft /proc/version 2>/dev/null; then echo host.docker.internal; else echo localhost; fi; \
	else \
		echo "$(INTEGRATION_DB_HOST)"; \
	fi); \
	echo "=== docker compose status (ci) ==="; \
	docker compose -f docker-compose.ci.yml ps; \
	echo "=== effective integration DB env ==="; \
	echo "DB_HOST=$$DB_HOST"; \
	echo "DB_PORT=$(INTEGRATION_DB_PORT)"; \
	echo "DB_NAME=$(INTEGRATION_DB_NAME)"; \
	echo "DB_USER=$(INTEGRATION_DB_USER)"

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