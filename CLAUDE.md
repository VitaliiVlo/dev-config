# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

macOS dotfiles repository for setting up a development environment. All configs use **Catppuccin Macchiato** theme, **JetBrains Mono** font (14pt).

## Key Commands

```bash
./bootstrap.sh                                   # Symlink configs to home directory
./bootstrap-defaults.sh                          # Configure macOS Finder/Dock/screenshots (interactive)
brew bundle install --global                     # Install Brewfile packages
brew bundle dump --global --force --no-go --no-vscode  # Update Brewfile from installed
```

## Repository Structure

- `bootstrap.sh` - Creates symlinks (uses `set -euo pipefail`)
- `bootstrap-defaults.sh` - macOS defaults via `defaults write` (interactive prompts)
- `.zshrc` / `.zprofile` - Zsh config (starship prompt, fzf, syntax-highlighting, autosuggestions)
- `.gitconfig` - Git settings (rebase workflow, SSH for GitHub, diff3 conflicts, rerere)
- `.config/ghostty/config` - Terminal emulator
- `.config/bat/config` - Cat replacement with syntax highlighting
- `.config/lsd/config.yaml` - Ls replacement (icons disabled for compatibility)
- `.config/starship.toml` - Shell prompt (no nerd fonts preset)
- `.config/Code/User/settings.json` - VSCode settings (JSONC format with comments)
- `.config/Code/User/defaultSettings.jsonc` - VSCode defaults reference (for comparing settings)
- `.editorconfig` - Project-level editor config template (not symlinked, copy to projects)

## Symlink Destinations

| Source | Destination |
|--------|-------------|
| `.zshrc`, `.zprofile` | `~/` |
| `.gitconfig`, `.gitignore_global` | `~/` |
| `.Brewfile` | `~/` |
| `.config/{bat,lsd,ghostty}/*` | `~/.config/` |
| `.config/starship.toml` | `~/.config/` |
| `.config/Code/User/settings.json` | `~/Library/Application Support/Code/User/` |

## Config Validation

```bash
ghostty +show-config --default --docs  # Validate ghostty config
bat --list-themes                       # Verify bat theme exists
starship config                         # Check starship config
git config --list --show-origin         # Verify git config loaded
```

## VSCode Settings

When modifying `.config/Code/User/settings.json`:
- Compare against `default.jsonc` to check if a setting matches the default (redundant)
- Settings use JSONC format (JSON with comments and trailing commas allowed)
- Configured for Go, Python, and Node.js backend development
- Uses Prettier for JS/TS/JSON/YAML/Markdown, Ruff for Python
