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
brew-install: brew-install-base brew-install-dev

# Install base packages (shell, fonts, daily-driver apps)
brew-install-base:
    brew bundle install --file=.Brewfile.base

# Install dev packages (languages, tooling, IDEs, infra)
brew-install-dev:
    brew bundle install --file=.Brewfile.dev

# Check for missing Brewfile packages
brew-check:
    brew bundle check --file=.Brewfile.base
    brew bundle check --file=.Brewfile.dev

# Show outdated Homebrew packages
brew-outdated:
    brew outdated

# Update and upgrade all Homebrew packages
brew-update:
    brew update && brew upgrade

# Clean up old versions and cache
brew-cleanup:
    brew cleanup --prune=all

# Export installed packages to .Brewfile.base (excludes Go deps, VSCode extensions)
brew-export:
    brew bundle dump --file=.Brewfile.base --force --no-go --no-vscode
