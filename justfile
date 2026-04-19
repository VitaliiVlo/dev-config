# List available recipes
default:
    @just --list

# Full setup: symlink configs and install packages
install: link brew-install

# Symlink configs to home directory
link:
    ./bootstrap.sh

# Configure macOS defaults (interactive): folders, Finder, Dock, screenshots, system
defaults:
    ./bootstrap-defaults.sh

# Show installed language versions
versions:
    @go version
    @fnm list
    @uv python list --only-installed

# Install all packages from Brewfiles
brew-install: brew-install-core brew-install-extra

# Install core packages (shell, fonts, daily-driver apps)
brew-install-core:
    brew bundle install --file=.Brewfile.core

# Install extra packages (languages, tooling, IDEs, infra)
brew-install-extra:
    brew bundle install --file=.Brewfile.extra

# Check for missing Brewfile packages
brew-check:
    brew bundle check --file=.Brewfile.core
    brew bundle check --file=.Brewfile.extra

# Show outdated Homebrew packages
brew-outdated:
    brew outdated

# Update and upgrade all Homebrew packages
brew-update:
    brew update && brew upgrade

# Clean up old versions and cache
brew-cleanup:
    brew cleanup --prune=all

# Export installed core packages to .Brewfile.core; keep .Brewfile.extra curated manually
brew-export:
    brew bundle dump --file=.Brewfile.core --force --no-vscode
