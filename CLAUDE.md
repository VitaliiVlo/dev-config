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
- `.zshrc` / `.zprofile` - Zsh config (starship prompt, fzf with bat preview, syntax-highlighting, autosuggestions)
- `.gitconfig` - Git settings (rebase workflow, SSH for GitHub, diff3 conflicts, rerere)
- `.config/ghostty/config` - Terminal emulator
- `.config/bat/config` - Cat replacement with syntax highlighting
- `.config/lsd/config.yaml` - Ls replacement (icons disabled for compatibility)
- `.config/starship.toml` - Shell prompt (no nerd fonts preset)
- `.config/Code/User/settings.json` - VSCode settings (JSONC format with comments)
- `.config/Code/User/defaultSettings.jsonc` - VSCode defaults reference (for comparing settings)
- `.claude/settings.json` - Claude Code permissions (web, git, docker, build tools, sensitive file protection)
- `.claude/commands/` - Custom Claude Code slash commands
- `.editorconfig` - Project-level editor config template (not symlinked, copy to projects)

## Symlink Destinations

| Source                            | Destination                                |
| --------------------------------- | ------------------------------------------ |
| `.zshrc`, `.zprofile`             | `~/`                                       |
| `.gitconfig`, `.gitignore_global` | `~/`                                       |
| `.Brewfile`                       | `~/`                                       |
| `.config/{bat,lsd,ghostty}/*`     | `~/.config/`                               |
| `.config/starship.toml`           | `~/.config/`                               |
| `.config/Code/User/settings.json` | `~/Library/Application Support/Code/User/` |
| `.claude/settings.json`           | `~/.claude/`                               |
| `.claude/commands/*`              | `~/.claude/commands/`                      |

## Config Validation

```bash
ghostty +show-config --default --docs  # Validate ghostty config
bat --list-themes                       # Verify bat theme exists
starship config                         # Check starship config
git config --list --show-origin         # Verify git config loaded
```

## VSCode Settings

When modifying `.config/Code/User/settings.json`:
- Compare against `defaultSettings.jsonc` to check if a setting matches the default (redundant)
- Settings use JSONC format (JSON with comments and trailing commas allowed)
- Configured for Go, Python, and Node.js backend development
- Uses Ruff for Python formatting/linting

**Layout (settings.json):**
- `window.commandCenter`: false (no project name in title bar)
- `workbench.navigationControl.enabled`: false (no back/forward buttons)
- `workbench.layoutControl.type`: "menu" (dropdown instead of toggles)
- `workbench.activityBar.location`: bottom (compact, under primary side bar)

**Layout (UI only, View → Appearance / Customize Layout):**
- Quick input position: center
- Panel alignment: justify (full window width)
- Secondary side bar: right (`Cmd+Option+B`)

## Claude Code Settings

The `.claude/settings.json` configures permissions:
- **Allowed:** Read-only git/docker/k8s, build/test/lint tools, web fetch from dev docs
- **Denied:** `.env`, credentials, private keys, `.tfvars`
- **Requires approval:** Package install, direct code execution, git writes, docker mutations

See `.claude/settings.json` for the full permission list.

## Claude Code Commands

Custom slash commands in `.claude/commands/`:

| Command       | Description                         | Arguments                                            |
| ------------- | ----------------------------------- | ---------------------------------------------------- |
| `/readme`     | Analyze repo and update README      | `[sections]`                                         |
| `/audit`      | Full codebase audit                 | `security`, `performance`, `quality`, `./path`, etc. |
| `/diff-audit` | Review changes for bugs             | `staged`, `modified`, `unpushed`, `main`, `main...HEAD`, `#<PR>` |
| `/iterate`    | Step through findings with approval | category, severity (`high`), or `./path`             |
| `/commit`     | Analyze changes and commit          | `all`, `staged`, `modified`, `<file>`                |

**Workflow:** `/audit` or `/diff-audit` → `/iterate` to fix findings → `/commit`
