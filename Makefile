ROOT_DIR_RELATIVE := .

include $(ROOT_DIR_RELATIVE)/common.mk

BUILD_VERSION ?= $(shell cat BUILD_VERSION)
BUILD_SHA ?= $(shell git rev-parse --short HEAD)
BUILD_DATE ?= $(shell date -u +"%Y-%m-%d")

GOOS ?= $(shell go env GOOS)
GOARCH ?= $(shell go env GOARCH)
GOHOSTOS ?= $(shell go env GOHOSTOS)
GOHOSTARCH ?= $(shell go env GOHOSTARCH)

LD_FLAGS = -X 'github.com/vmware-tanzu/tanzu-plugin-runtime/plugin/buildinfo.Date=$(BUILD_DATE)'
LD_FLAGS += -X 'github.com/vmware-tanzu/tanzu-plugin-runtime/plugin/buildinfo.SHA=$(BUILD_SHA)'
LD_FLAGS += -X 'github.com/vmware-tanzu/tanzu-plugin-runtime/plugin/buildinfo.Version=$(BUILD_VERSION)'
LD_FLAGS += -X 'github.com/vmware-tanzu/tanzu-framework/cli/runtime/buildinfo.Version=$(BUILD_VERSION)'
LD_FLAGS += -X 'github.com/vmware-tanzu/tanzu-framework/pkg/v1/buildinfo.Version=$(BUILD_VERSION)'

TOOLS_DIR := tools
TOOLS_BIN_DIR := $(TOOLS_DIR)/bin
GOLANGCI_LINT := $(TOOLS_BIN_DIR)/golangci-lint
GOLANGCI_LINT_VERSION := 1.49.0

GO_SRCS := $(call rwildcard,.,*.go)

ARTIFACTS_DIR ?= ./artifacts
TANZU_PLUGIN_PUBLISH_PATH ?= $(ARTIFACTS_DIR)/published

# Name of Tanzu CLI binary
TZBIN ?= tanzu

# Add list of plugins separated by space
PLUGINS ?= ""

# Add supported OS-ARCHITECTURE combinations here
ENVS ?= linux-amd64 windows-amd64 darwin-amd64

BUILD_JOBS := $(addprefix build-,${ENVS})

go.mod go.sum: $(GO_SRCS)
	go mod download
	go mod tidy

.PHONY: build-local
build-local: ## Build the plugin
	 $(TZBIN) builder plugin build --version $(BUILD_VERSION) --ldflags "$(LD_FLAGS)" --path ./cmd/plugin --artifacts artifacts --os-arch ${GOHOSTOS}_${GOHOSTARCH}
## $(TZBIN) builder cli compile --version $(BUILD_VERSION) --ldflags "$(LD_FLAGS)" --path ./cmd/plugin --target local --artifacts artifacts/${GOHOSTOS}/${GOHOSTARCH}/cli

.PHONY: build
build: $(BUILD_JOBS)  ## Build the plugin

.PHONY: build-%
build-%:
	$(eval ARCH = $(word 2,$(subst -, ,$*)))
	$(eval OS = $(word 1,$(subst -, ,$*)))
	$(TZBIN) builder plugin build --version $(BUILD_VERSION) --ldflags "$(LD_FLAGS)" --path ./cmd/plugin --artifacts artifacts --os-arch ${OS}_${ARCH}


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
