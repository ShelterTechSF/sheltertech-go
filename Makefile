SHELL := /bin/bash

# go source files, ignore vendor directory
SRC = $(shell find . -type f -name '*.go' -not -path "./vendor/*")

.PHONY: fmt run

fmt:
	@gofmt -l -w $(SRC)

run:
	env CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o ./tmp/sheltertech-go ./cmd/sheltertech-go && DOCKER_DEFAULT_PLATFORM="linux/amd64" docker-compose -f docker-compose.dev.yml build && docker-compose -f docker-compose.dev.yml up

hot-run:
	env CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o ./tmp/sheltertech-go-hot ./cmd/sheltertech-go && DOCKER_DEFAULT_PLATFORM="linux/amd64" docker-compose -f docker-compose.hot.dev.yml build && docker-compose -f docker-compose.hot.dev.yml up

ci-run:
	docker-compose -f docker-compose.ci.yml build && docker-compose -f docker-compose.ci.yml up -d

build:
	go build -v ./...

test:
	go test -v ./...

integration-test:
	go test -v -tags=integration ./...