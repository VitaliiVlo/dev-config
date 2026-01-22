.PHONY: install link defaults brew-install brew-check brew-export help

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

install: link brew-install ## Full setup: symlink configs and install packages

link: ## Symlink configs to home directory
	./bootstrap.sh

defaults: ## Configure macOS Finder/Dock/screenshots (interactive)
	./bootstrap-defaults.sh

brew-install: ## Install packages from Brewfile
	brew bundle install --global

brew-check: ## Check for missing Brewfile packages
	brew bundle check --global

brew-export: ## Export installed packages to Brewfile
	brew bundle dump --global --force --no-go --no-vscode
