# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

macOS dotfiles repository for setting up a development environment. All configs use **Catppuccin Macchiato** theme, **JetBrains Mono** font (14pt). Configured for **Go 1.25** and **Python 3.14** (version-specific paths in `.zprofile`).

## Key Commands

```bash
make install      # Full setup: symlink configs and install packages
make link         # Symlink configs to home directory
make defaults     # Configure macOS Finder/Dock/screenshots (interactive)
make brew-install # Install packages from Brewfile
make brew-check   # Check for missing Brewfile packages
make brew-export  # Export installed packages to Brewfile (excludes Go deps, VSCode extensions)
```

## Repository Structure

- `bootstrap.sh` - Creates symlinks (uses `set -euo pipefail`)
- `bootstrap-defaults.sh` - macOS defaults via `defaults write` (interactive prompts)
- `Makefile` - Make targets for common operations (`make help` for list)
- `.zshrc` / `.zprofile` - Zsh config (starship prompt, fzf with bat preview, eza aliases, syntax-highlighting, autosuggestions)
- `.gitconfig` - Git settings (rebase workflow, SSH for GitHub, diff3 conflicts, rerere)
- `.ripgreprc` - Ripgrep defaults (smart-case, hidden files, follow symlinks)
- `.config/ghostty/config` - Terminal emulator
- `.config/bat/config` - Cat replacement with syntax highlighting
- `.config/btop/btop.conf` - System monitor (tokyo-night theme)
- `.config/starship.toml` - Shell prompt (no nerd fonts preset)
- `.config/Code/User/settings.json` - VSCode settings (JSONC format with comments)
- `.config/Code/User/defaultSettings.jsonc` - VSCode defaults reference (for comparing settings)
- `.claude/settings.json` - Claude Code permissions (web, git, docker, build tools, sensitive file protection)
- `.claude/commands/` - Custom Claude Code slash commands
- `.editorconfig` - Project-level editor config template (not symlinked, copy to projects)

## Script Behavior

**bootstrap.sh:**
- Uses `ln -sf` (force symlink) - overwrites existing files
- Creates parent directories as needed for nested configs
- macOS-specific: VSCode path is `~/Library/Application Support/Code/User/`

**bootstrap-defaults.sh:**
- Interactive: prompts for each category (Finder, Dock, Screenshots)
- Restarts affected processes (Finder, Dock, SystemUIServer)
- Safe to re-run: idempotent `defaults write` commands

## Shell Aliases

Defined in `.zshrc`:

| Alias  | Command                                |
| ------ | -------------------------------------- |
| `tf`   | `terraform`                            |
| `kk`   | `kubectl`                              |
| `kctx` | `kubectl config current-context`       |
| `cat`  | `bat` (if installed)                   |
| `ls`   | `eza --group-directories-first`        |
| `ll`   | `eza` with git, timestamps, headers    |
| `lt`   | `eza` tree view (2 levels)             |
| `lr`   | `eza` sorted by modified (recent last) |

## Shell Tool Integration

fd and ripgrep share consistent defaults for daily use:

| Behavior        | fd                                                       | ripgrep        |
| --------------- | -------------------------------------------------------- | -------------- |
| Hidden files    | `--hidden`                                               | `--hidden`     |
| Follow symlinks | `--follow`                                               | `--follow`     |
| Exclusions      | `.git`, `node_modules`, `.venv`, `__pycache__`, `vendor` | Same           |
| Config location | Alias in `.zshrc` (no config file support)               | `~/.ripgreprc` |

fzf uses fd when available for faster fuzzy finding with bat preview:
- `Ctrl+T` - File search with bat preview
- `Ctrl+R` - History search (no preview)
- `Alt+C` - Directory search with eza tree preview

zoxide provides smart directory jumping via `z` command (learns from `cd` usage).

## Symlink Destinations

| Source                            | Destination                                |
| --------------------------------- | ------------------------------------------ |
| `.zshrc`, `.zprofile`             | `~/`                                       |
| `.gitconfig`, `.gitignore_global` | `~/`                                       |
| `.Brewfile`                       | `~/`                                       |
| `.ripgreprc`                      | `~/`                                       |
| `.config/{bat,btop,ghostty}/*`    | `~/.config/`                               |
| `.config/starship.toml`           | `~/.config/`                               |
| `.config/Code/User/settings.json` | `~/Library/Application Support/Code/User/` |
| `.claude/settings.json`           | `~/.claude/`                               |
| `.claude/commands/*`              | `~/.claude/commands/`                      |

## Config Validation

```bash
ghostty +show-config --default --docs      # Should show parsed config, no errors
bat --list-themes | grep -i catppuccin     # Should show "Catppuccin Macchiato"
btop --version                              # Should show version (config loads on start)
starship config                             # Should show TOML config
git config --list --show-origin             # Should show ~/.gitconfig as source
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

## Applications List Maintenance

When updating the Applications table in README.md:
- Selection criteria are ranked by priority in README.md - follow those guidelines
- Tools in **bold** are primary recommendations (one per category)
- GUI apps go in Applications section, text-based/TUI tools go in CLI Tools section
- Include 3-5 apps per category when possible
- Verify apps are actively maintained and not discontinued before adding

## Claude Code Settings

The `.claude/settings.json` configures permissions:
- **Allowed:** Read-only git/docker/k8s, build/test/lint tools, web fetch from dev docs, `fd` and `rg` for file search
- **Denied:** `.env`, credentials, private keys, `.tfvars`
- **Requires approval:** Package install, direct code execution, git writes, docker mutations
- **Enabled plugins:** context7, pyright-lsp, gopls-lsp, typescript-lsp, code-review, feature-dev

See `.claude/settings.json` for the full permission list.

## Claude Code Commands

Custom slash commands in `.claude/commands/`:

| Command       | Description                         | Arguments                                                  |
| ------------- | ----------------------------------- | ---------------------------------------------------------- |
| `/readme`     | Analyze repo and update README      | `[sections]` (e.g., `installation`, `usage api`)           |
| `/audit`      | Full codebase audit                 | category, `./path`, or combined (e.g., `security ./pkg`)   |
| `/diff-audit` | Review changes for bugs             | `staged`, `modified`, `main`, `main+local`, `#<PR>` or URL |
| `/iterate`    | Step through findings with approval | category, severity (`high`), `./path`, or combined         |
| `/commit`     | Analyze changes and commit          | `staged`, `modified`, `all`, `<file>`                      |

**Workflow:** `/audit` or `/diff-audit` → `/iterate` to fix findings → `/commit`

**Notes:**
- `/diff-audit main` falls back to `master` if `main` doesn't exist; specify other branches directly (e.g., `/diff-audit develop`)
- `/audit` and `/iterate` support combined filters: `/audit security ./src`, `/iterate high ./pkg`
