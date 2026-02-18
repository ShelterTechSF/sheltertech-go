SHELL := /bin/bash

# go source files, ignore vendor directory
SRC = $(shell find . -type f -name '*.go' -not -path "./vendor/*")
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
integration-test: go-exists
	go test -v -tags=integration ./...

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