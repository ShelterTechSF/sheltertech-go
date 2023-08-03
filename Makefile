SHELL := /bin/bash

# go source files, ignore vendor directory
SRC = $(shell find . -type f -name '*.go' -not -path "./vendor/*")

.PHONY: fmt run

fmt:
	@gofmt -l -w $(SRC)

run:
	docker-compose build && docker-compose up

ci-run:
	docker-compose -f docker-compose.ci.yml build && docker-compose -f docker-compose.ci.yml up -d

build:
	go build -v ./...

test:
	go test -v ./...

integration-test:
	go test -v -tags=integration ./...