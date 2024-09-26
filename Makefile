SHELL := /bin/bash

# go source files, ignore vendor directory
SRC = $(shell find . -type f -name '*.go' -not -path "./vendor/*")

.PHONY: fmt run

# Format go files in repo
fmt:
	@gofmt -l -w $(SRC)

# Runs the api service without the database dependency that should be run from the askdarcel-api project
run:
	docker compose -f docker-compose.dev.yml build && docker compose -f docker-compose.dev.yml up

# Used in CI to start a database in the background along with the api service
# Running this yourself allows you to create what happens in CI
ci-run:
	docker compose -f docker-compose.ci.yml build && docker compose -f docker-compose.ci.yml up -d

# Not strictly used by anything but allows a compile check
build:
	go build -v ./...

# No dependencies
test:
	go test -v ./...

# Assumes you have a database running from either the askdarcel-api project or you use `make ci-run`
integration-test:
	go test -v -tags=integration ./...

# TODO add a unit test build that will run within a container so Go does not need to exist on host
test-docker:
	echo "TODO"
# TODO add a ingregation test build that will run within a container so Go does not need to exist on host
test-integration-test-docker:
	echo "TODO"