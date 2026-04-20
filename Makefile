.DEFAULT_GOAL := help

.PHONY: help setup link defaults versions brew-install brew-install-core brew-install-extra brew-check brew-cleanup brew-export

help: ## List available targets
	@awk 'BEGIN {FS = ":.*## "}; /^[a-zA-Z0-9_-]+:.*## / {printf "  %-18s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

setup: defaults link brew-install versions ## Full setup: configure macOS, symlink configs, install packages, show versions

defaults: ## Configure macOS defaults (interactive): folders, Finder, Dock, screenshots, system
	./bootstrap-defaults.sh

link: ## Symlink configs to home directory
	./bootstrap.sh

versions: ## Show installed Go, Node, Python versions
	@echo "--- Go ---"
	@go version
	@echo "\n--- Node ---"
	@fnm list
	@echo "\n--- Python ---"
	@uv python list --only-installed

brew-install: brew-install-core brew-install-extra ## Install all packages from Brewfiles

brew-install-core: ## Install core packages (shell, fonts, daily-driver apps)
	brew bundle install --file=.Brewfile.core

brew-install-extra: ## Install extra packages (languages, tooling, IDEs, infra)
	brew bundle install --file=.Brewfile.extra

brew-check: ## Check for missing Brewfile packages
	brew bundle check --file=.Brewfile.core
	brew bundle check --file=.Brewfile.extra

brew-cleanup: ## Clean up old versions and cache
	brew cleanup --prune=all

brew-export: ## Export installed core packages to .Brewfile.core; keep .Brewfile.extra curated manually
	brew bundle dump --file=.Brewfile.core --force
