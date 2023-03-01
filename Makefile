ROOT_DIR_RELATIVE := .

include $(ROOT_DIR_RELATIVE)/common.mk
include $(ROOT_DIR_RELATIVE)/plugin-tooling.mk

BUILD_VERSION ?= $(shell cat BUILD_VERSION)
BUILD_SHA ?= $(shell git rev-parse --short HEAD)
BUILD_DATE ?= $(shell date -u +"%Y-%m-%d")

GOOS ?= $(shell go env GOOS)
GOARCH ?= $(shell go env GOARCH)
GOHOSTOS ?= $(shell go env GOHOSTOS)
GOHOSTARCH ?= $(shell go env GOHOSTARCH)

TOOLS_DIR := tools
TOOLS_BIN_DIR := $(TOOLS_DIR)/bin
GOLANGCI_LINT := $(TOOLS_BIN_DIR)/golangci-lint
GOLANGCI_LINT_VERSION := 1.49.0

GO_SRCS := $(call rwildcard,.,*.go)

go.mod go.sum: $(GO_SRCS)
	go mod download
	go mod tidy

.PHONY: lint
lint: $(GOLANGCI_LINT) ## Lint the plugin
	$(GOLANGCI_LINT) run -v

.PHONY: init
init:go.mod go.sum  ## Initialise the plugin

.PHONY: test
test: $(GO_SRCS) go.sum
	go test ./...

$(TOOLS_BIN_DIR):
	-mkdir -p $@

$(GOLANGCI_LINT): $(TOOLS_BIN_DIR) ## Install golangci-lint
	curl -L https://github.com/golangci/golangci-lint/releases/download/v$(GOLANGCI_LINT_VERSION)/golangci-lint-$(GOLANGCI_LINT_VERSION)-$(GOHOSTOS)-$(GOHOSTARCH).tar.gz | tar -xz -C /tmp/
	mv /tmp/golangci-lint-$(GOLANGCI_LINT_VERSION)-$(GOHOSTOS)-$(GOHOSTARCH)/golangci-lint $(@)
