SHELL := /bin/zsh

.PHONY: help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}{printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'
	@echo "\nAvailable platforms:"
	@rustup target list --installed

show-platforms: ## Show platforms that can be added
	@rustup target list

clean: ## Clean the project using cargo
	@cargo clean

lint: ## Lint the project using cargo
	@rustup component add clippy 2> /dev/null
	cargo clippy

fmt: ## Format the project using cargo
	@rustup component add rustfmt 2> /dev/null
	@cargo fmt

test: ## Test the project using cargo
	@cargo test

build: ## Build the project using cargo
	@cargo build

release: ## Build the project using cargo
	@cargo build --release

run: ## Run the project using cargo
	@cargo run

doc: ## Generate the documentation using cargo
	@cargo doc --no-deps --open

all: ## Format, lint, clean, and build the project using cargo
	$(MAKE) fmt; \
	$(MAKE) lint; \
	$(MAKE) clean; \
	$(MAKE) build; \
	$(MAKE) run

bump: ## Bump the version in Cargo.toml
	@echo "Enter the new version (e.g., 0.2.1): "; \
	read version; \
	echo "New version: $$version"; \
	sed -i '' "s/^version = \".*\"/version = \"$$version\"/" Cargo.toml; \
	echo "Version bumped to $$version in Cargo.toml"

final: ## Format, lint, clean, and build the project in release mode for a specified platform
	@echo "Enter the target platform (default: aarch64-apple-darwin):"; \
	read platform; \
	if [ -z "$$platform" ]; then \
		platform="aarch64-apple-darwin"; \
	fi; \
	if ! rustup target list --installed | grep -q "$$platform"; then \
		echo "Invalid platform: $$platform"; \
		exit 1; \
	fi; \
	echo "Using platform: $$platform"; \
	$(MAKE) fmt; \
	$(MAKE) lint; \
	$(MAKE) clean; \
	cargo clean; \
	cargo build --release --target="$$platform"


