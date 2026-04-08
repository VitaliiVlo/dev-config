# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

macOS dotfiles repository for setting up a development environment. All configs use **Catppuccin Macchiato** theme, **JetBrains Mono** font (14pt). Configured for **Go 1.26** (via Homebrew), **Python** (via `uv`), and **Node.js** (via `fnm`).

## Key Commands

```bash
just install      # Full setup: symlink configs and install packages
just link         # Symlink configs to home directory
just defaults     # Configure macOS Finder/Dock/screenshots (interactive)
just versions     # Show installed Go, Node, Python versions
just brew-install # Install packages from Brewfile
just brew-check   # Check for missing Brewfile packages
just brew-outdated # Show outdated Homebrew packages
just brew-update  # Update and upgrade all Homebrew packages
just brew-cleanup # Clean up old versions and cache
just brew-export  # Export installed packages to Brewfile (excludes Go deps, VSCode extensions)
```

## Repository Structure

- `bootstrap.sh` - Creates symlinks (uses `set -euo pipefail`)
- `bootstrap-defaults.sh` - macOS defaults via `defaults write` (interactive prompts)
- `justfile` - Task runner recipes (`just` for list)
- `.Brewfile` - Homebrew package manifest (symlinked to `~/`)
- `.zshrc` / `.zprofile` - Zsh config (starship prompt, fnm, uv, fzf with bat preview, eza aliases, syntax-highlighting, autosuggestions)
- `.gitconfig` / `.gitignore_global` - Git settings (delta pager, rebase workflow, SSH for GitHub, zdiff3 conflicts, rerere)
- `.ripgreprc` - Ripgrep defaults (smart-case, hidden files, follow symlinks)
- `.config/ghostty/config` - Terminal emulator
- `.config/bat/config` - Cat replacement with syntax highlighting
- `.config/btop/btop.conf` - System monitor (tokyo-night theme, closest to Catppuccin)
- `.config/starship.toml` - Shell prompt (no nerd fonts preset)
- `.config/Code/User/settings.json` - VSCode settings (JSONC format with comments)
- `.config/Code/User/defaultSettings.jsonc` - VSCode defaults reference (for comparing settings)
- `.config/ccstatusline/settings.json` - Claude Code status line layout (via ccstatusline)
- `.claude/CLAUDE.md` - Claude Code user-level instructions (symlinked to `~/`)
- `.claude/settings.json` - Claude Code permissions (web, git, docker, build tools, sensitive file protection)
- `.codex/AGENTS.md` - Codex user-level instructions (symlinked to `~/`)
- `.codex/config.toml` - Codex CLI config (model, sandbox, profiles)

## Script Behavior

**bootstrap.sh:**

- Uses `ln -sf` (force symlink) - overwrites existing files
- Creates parent directories as needed for nested configs
- macOS-specific: VSCode path is `~/Library/Application Support/Code/User/`

**bootstrap-defaults.sh:**

- Interactive: prompts for each category (Finder, .DS_Store cleanup, Dock, Screenshots)
- Restarts affected processes (Finder, Dock, SystemUIServer)
- Safe to re-run: idempotent `defaults write` commands

## Shell Aliases

Defined in `.zshrc`:

| Alias    | Command                                |
| -------- | -------------------------------------- |
| `python` | `python3`                              |
| `pip`    | `pip3`                                 |
| `tf`     | `terraform`                            |
| `kk`     | `kubectl`                              |
| `kctx`   | `kubectl config current-context`       |
| `lzg`    | `lazygit`                              |
| `c`      | `clear`                                |
| `cat`    | `bat` (if installed)                   |
| `ls`     | `eza --group-directories-first`        |
| `ll`     | `eza` with git, timestamps, headers    |
| `lt`     | `eza` tree view (2 levels)             |
| `lr`     | `eza` sorted by modified (recent last) |

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

fnm (Fast Node Manager) auto-switches Node versions via `.node-version` or `.nvmrc` when entering a directory (`--use-on-cd`).

uv manages Python versions and project dependencies. System `python3` comes from Xcode CLT or brew; `uv` handles per-project venvs and global CLI tools (`uv tool install`). Shell completions are loaded in `.zshrc`.

git-delta is configured as the git pager (`.gitconfig`) with Catppuccin Macchiato syntax theme. It uses bat's theme engine — the theme is available because bat has it installed.

## Git Aliases

Defined in `.gitconfig`:

| Alias  | Command                            |
| ------ | ---------------------------------- |
| `st`   | `status`                           |
| `df`   | `diff`                             |
| `dfs`  | `diff --staged`                    |
| `cm`   | `commit -m`                        |
| `ca`   | `commit --amend --no-edit`         |
| `lg`   | `log --oneline --graph --decorate` |
| `undo` | `reset --soft HEAD~1`              |
| `wipe` | `reset --hard HEAD`                |

## Config Validation

```bash
ghostty +show-config --default --docs      # Should show parsed config, no errors
bat --list-themes | grep -i catppuccin     # Should show "Catppuccin Macchiato"
delta --list-syntax-themes | grep -i catppuccin  # Should show Catppuccin themes
btop --version                              # Should show version (config loads on start)
starship config                             # Should show TOML config
git config --list --show-origin             # Should show ~/.gitconfig as source
fnm list                                    # Should show installed Node versions
uv python list --only-installed             # Should show installed Python versions
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

When updating the Applications table in README.md, see the selection criteria documented there. Key guidelines:

- Tools in **bold** are primary recommendations (one per category)
- GUI apps go in Applications section, text-based/TUI tools go in CLI Tools section
- Include 3-5 apps per category when possible
- Verify apps are actively maintained before adding
- Research community sentiment (Reddit, GitHub issues, HN) before adding new tools

## Claude Code Settings

The `.claude/settings.json` configures permissions:

- **Allowed:** Read-only git/docker/k8s, build/test/lint tools, web search, web fetch from dev docs, `fd` and `rg` for file search
- **Denied:** `.env`, `.ssh/*`, `.kube/config`, `.git-credentials`, credentials, private keys, `.tfvars`
- **Requires approval:** Package install, direct code execution, git writes, docker mutations
- **Enabled plugins:** pyright-lsp, gopls-lsp, typescript-lsp, code-review, feature-dev, code-simplifier, claude-md-management
- **Status line:** Custom layout via `ccstatusline` (model, thinking effort, cwd, git branch, context %, session/weekly usage, cost)

See `.claude/settings.json` for the full permission list.

