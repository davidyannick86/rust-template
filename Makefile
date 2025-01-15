# Rust project Makefile

# Configuration
CARGO := cargo
TARGET_DIR := target
RELEASE_DIR := $(TARGET_DIR)/release
DEBUG_DIR := $(TARGET_DIR)/debug

# Default target
.PHONY: all
all: build

# Build the project in debug mode
.PHONY: build
build:
	$(CARGO) build

# Build the project in release mode
.PHONY: release
release:
	$(CARGO) build --release

# Run the project in debug mode
.PHONY: run
run:
	$(CARGO) run

# Run the project in release mode
.PHONY: run-release
run-release:
	$(CARGO) run --release

# Run tests
.PHONY: test
test:
	$(CARGO) test

# Check code formatting
.PHONY: fmt-check
fmt-check:
	$(CARGO) fmt -- --check

# Format code
.PHONY: fmt
fmt:
	$(CARGO) fmt

# Run clippy for linting
.PHONY: lint
lint:
	$(CARGO) clippy -- -D warnings

# Clean build artifacts
.PHONY: clean
clean:
	$(CARGO) clean

# Show help
.PHONY: help
help:
	@echo "Available targets:"
	@echo "  build        - Build the project in debug mode"
	@echo "  release      - Build the project in release mode"
	@echo "  run         - Run the project in debug mode"
	@echo "  run-release - Run the project in release mode"
	@echo "  test        - Run tests"
	@echo "  fmt-check   - Check code formatting"
	@echo "  fmt         - Format code"
	@echo "  lint        - Run clippy linter"
	@echo "  clean       - Clean build artifacts"
	@echo "  help        - Show this help message"