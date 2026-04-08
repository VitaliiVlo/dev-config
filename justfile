# List available recipes
default:
    @just --list

# Full setup: symlink configs and install packages
install: link brew-install

# Symlink configs to home directory
link:
    ./bootstrap.sh

# Configure macOS Finder/Dock/screenshots (interactive)
defaults:
    ./bootstrap-defaults.sh

# Show installed language versions
versions:
    @go version
    @fnm list
    @uv python list --only-installed

# Install packages from Brewfile
brew-install:
    brew bundle install --global

# Check for missing Brewfile packages
brew-check:
    brew bundle check --global

# Show outdated Homebrew packages
brew-outdated:
    brew outdated

# Update and upgrade all Homebrew packages
brew-update:
    brew update && brew upgrade

# Clean up old versions and cache
brew-cleanup:
    brew cleanup --prune=all

# Export installed packages to Brewfile (excludes Go deps, VSCode extensions)
brew-export:
    brew bundle dump --global --force --no-go --no-vscode
