SHELL := /bin/bash

# go source files, ignore vendor directory
SRC = $(shell find . -type f -name '*.go' -not -path "./vendor/*")

.PHONY: fmt run

fmt:
	@gofmt -l -w $(SRC)

run:
	docker-compose build && docker-compose up

test:
	go test ./... -v

integration-test:
	go test -tags=integration ./... -v