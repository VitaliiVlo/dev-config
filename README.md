# macOS Development Configuration Guide

Dotfiles configured with **Catppuccin Macchiato** theme and **JetBrains Mono** font (14pt) with **Fira Code**, **Menlo**, **Monaco**, and **Symbols Nerd Font Mono** fallbacks. Configured for **Go 1.26**, **Python** (via `uv`), and **Node.js** (via `fnm`).

## Quick Start

1. Clone this repository
2. Run `just install` to symlink configs and install packages
3. Run `just defaults` to configure macOS settings (optional)

## Prerequisites

- **Install Xcode Command Line Tools:** git, make, grep, tar etc.
  ```
  xcode-select --install
  ```
- **Install Homebrew**
  ```
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```
- **Generate SSH key for Git**
  ```
  ssh-keygen -t ed25519 -C "your_email@example.com"
  pbcopy < ~/.ssh/id_ed25519.pub
  ```
- **Configure sudo with Touch ID**
  ```bash
  sudo cp /etc/pam.d/sudo_local.template /etc/pam.d/sudo_local
  sudo nano /etc/pam.d/sudo_local
  # Uncomment: auth sufficient pam_tid.so
  ```

## Configuration Files

The following files are automatically symlinked by running `just link`:

- `.zprofile` - Shell environment variables
- `.zshrc` - Shell configuration and aliases
- `.gitconfig` - Git user and global settings
- `.gitignore_global` - Global gitignore
- `.ripgreprc` - Ripgrep defaults (smart-case, hidden files)
- `.config/ghostty/config` - Ghostty configuration
- `.config/starship.toml` - Starship configuration
- `.config/bat/config` - Bat configuration
- `.config/btop/btop.conf` - Btop configuration
- `.config/gh/config.yml` - GitHub CLI settings
- `.config/lazygit/config.yml` - Lazygit settings
- `.config/micro/settings.json` - Micro editor settings
- `.config/yazi/yazi.toml` - Yazi file manager settings
- `.config/Code/User/settings.json` - VSCode configuration
- `.config/zed/settings.json` - Zed editor settings
- `.claude/settings.json` - Claude Code permissions
- `.claude/CLAUDE.md` - Claude Code user-level instructions
- `.config/ccstatusline/settings.json` - Claude Code status line layout
- `.codex/config.toml` - Codex CLI config (model, sandbox, plugins)
- `.codex/AGENTS.md` - Codex user-level instructions
- `.codex/rules/` - Codex permission rules (git, dev, shell, infra)

**Not symlinked (used directly from repo):**

- `.Brewfile.core` - Core Brewfile (shell, fonts, daily-driver apps)
- `.Brewfile.extra` - Extra Brewfile (work-specific tooling, IDEs, infra; curated manually)
- `.config/Code/User/defaultSettings.jsonc` - VSCode defaults for comparing settings

## macOS Settings

Run `just defaults` to configure:

- Projects folder (~/Projects)
- Screenshots (save to ~/Screenshots, no shadow, PNG)
- Finder (list view, path bar, show extensions, folders first, search current folder)
- Dock (autohide, no recents, minimize to app, fixed Spaces order, hot corners disabled)
- System defaults (key repeat, natural scrolling, save to disk)

## Applications

**Prerequisites:**

- macOS available (Linux is a plus)

**Selection criteria (ranked by priority):**

1. Polished UX, feels native
2. Lightweight and simple, not bloated with features
3. Popular and actively maintained
4. Trusted and appreciated in developer communities (Reddit, GitHub, HN)
5. Rising or stable trends (avoid declining tools)

**Plus factors (not required):**

- Reasonable price or free
- Open source
- Enterprise backing or official status

Install via official installers or Homebrew Cask:

| Category              | Apps                                                                                 |
| --------------------- | ------------------------------------------------------------------------------------ |
| Editor                | **VSCode**, Zed, Cursor, JetBrains                                                   |
| Terminal              | **Ghostty**, Kitty, iTerm2, Alacritty                                                |
| AI                    | **Claude Code**, Codex, Gemini CLI, OpenCode                                         |
| Containers            | **OrbStack**, Colima, Docker Desktop, Podman Desktop                                 |
| Kubernetes            | **Headlamp**, Aptakube, Freelens                                                     |
| Kubernetes Remote Dev | **Telepresence**, mirrord                                                            |
| Database              | **TablePlus**, Postico, MongoDB Compass, Beekeeper Studio                            |
| API Testing           | **Bruno**, Yaak, Hoppscotch                                                          |
| Browser               | **Firefox**, Safari, Chrome, Brave                                                   |
| Ad Blocker (Chromium) | **uBlock Origin Lite**                                                               |
| Ad Blocker (Firefox)  | **uBlock Origin**                                                                    |
| Ad Blocker (Safari)   | **Wipr 2**, wBlock                                                                   |
| Diagrams              | **Excalidraw**, tldraw                                                               |
| Diagram as Code       | **Mermaid**, D2                                                                      |
| Notes                 | **Apple Notes**, Bear, Obsidian                                                      |
| Password Manager      | **Apple Passwords**, 1Password, Bitwarden                                            |
| macOS Tools           | **Raycast**, Rectangle, Maccy, Keka, KeepingYouAwake, Ice, MiddleClick, balenaEtcher |

**VSCode setup:**

- Enable settings sync with GitHub
- Enable Copilot
- Configure layout (View → Appearance / Customize Layout):
  - Quick input position: center
  - Panel alignment: justify
  - Secondary side bar: right

## CLI Tools

Installed via Homebrew formulae and casks (see `.Brewfile.core` and `.Brewfile.extra`):

```bash
just brew-install       # Install all packages (core + extra)
just brew-install-core  # Install core packages only
just brew-install-extra # Install extra packages only
just brew-check        # Check for missing packages
just brew-outdated     # Show outdated packages
just brew-update       # Update and upgrade all packages
just brew-cleanup      # Clean up old versions and cache
just brew-export       # Export installed core packages to .Brewfile.core; keep .Brewfile.extra curated manually
just versions          # Show installed Go, Node, Python versions
```

| Tool                    | Description                                             |
| ----------------------- | ------------------------------------------------------- |
| awscli                  | AWS command-line interface                              |
| bat                     | `cat` with syntax highlighting                          |
| btop                    | System monitor TUI (modern `htop`)                      |
| eza                     | Modern `ls` replacement                                 |
| fd                      | Modern `find` replacement                               |
| fnm                     | Fast Node Manager (auto-switches via `.node-version`)   |
| fzf                     | Fuzzy finder (Ctrl+T files, Ctrl+R history, Alt+C dirs) |
| gh                      | GitHub CLI                                              |
| git-delta               | Syntax-highlighting git pager (replaces `less`)         |
| jq / yq                 | JSON / YAML processors                                  |
| just                    | Task runner (replaces `make`)                           |
| k9s                     | Kubernetes TUI                                          |
| kubectl                 | Kubernetes CLI                                          |
| lazydocker              | Docker TUI                                              |
| lazygit                 | Git TUI                                                 |
| micro                   | Terminal text editor                                    |
| pgcli                   | PostgreSQL CLI with autocomplete                        |
| ripgrep                 | Fast `grep` replacement                                 |
| sevenzip                | 7-Zip file archiver                                     |
| starship                | Cross-shell prompt                                      |
| uv                      | Python version/package manager                          |
| yazi                    | Terminal file manager                                   |
| zoxide                  | Smarter `cd` (learns from usage)                        |
| zsh-autosuggestions     | Fish-like command suggestions                           |
| zsh-completions         | Additional shell completions                            |
| zsh-syntax-highlighting | Command syntax highlighting                             |

## Casks

GUI applications and fonts installed via Homebrew Cask:

### Core Casks

| Cask                        | Description                      |
| --------------------------- | -------------------------------- |
| balenaetcher                | USB flash tool                   |
| claude-code                 | Anthropic Claude CLI             |
| codex                       | OpenAI Codex CLI                 |
| firefox                     | Web browser                      |
| font-fira-code              | Fallback monospace font          |
| font-jetbrains-mono         | Primary monospace font           |
| font-symbols-only-nerd-font | Nerd Font icons (symbols only)   |
| ghostty                     | Terminal emulator                |
| google-chrome               | Web browser                      |
| keepingyouawake             | Prevent sleep                    |
| keka                        | File archiver                    |
| maccy                       | Clipboard manager                |
| middleclick                 | Three-finger tap as middle click |
| rectangle                   | Window manager                   |
| visual-studio-code          | Code editor                      |
| zed                         | Code editor                      |

### Extra Casks

| Cask            | Description                               |
| --------------- | ----------------------------------------- |
| bruno           | API testing client                        |
| headlamp        | Kubernetes GUI                            |
| mongodb-compass | MongoDB GUI                               |
| orbstack        | Docker/Linux VM (replaces Docker Desktop) |
| slack           | Team messaging                            |
| tailscale-app   | VPN/mesh networking                       |

## Claude Code

The `.claude/settings.json` configures permissions and plugins:

**Allowed:** Web search, fetch from dev docs (GitHub, Stack Overflow, MDN, Go/Python/Node/Terraform/Docker/Kubernetes/Claude docs), git/docker/k8s read-only commands, build/test/lint tools, `fd` and `rg` for file search

**Denied:** `.env` files, `.ssh/*`, `.kube/config`, `.git-credentials`, credentials, private keys, `.tfvars`

**Requires approval:** Package installs, direct code execution (`python`, `node`, `go run`), git writes, docker mutations

**Enabled plugins:** pyright-lsp, gopls-lsp, typescript-lsp, code-review, feature-dev, code-simplifier, claude-md-management, caveman

**Marketplace:** [caveman](https://github.com/JuliusBrussee/caveman) (auto-update enabled)

**Status line:** Custom layout via [`ccstatusline`](https://www.npmjs.com/package/ccstatusline) showing model, thinking effort, cwd, git branch, context %, session/weekly usage, and cost

**Usage tracking:** [`ccusage`](https://github.com/ryoppippi/ccusage) for analyzing token usage and costs from local JSONL files

## Codex

The `.codex/config.toml` configures model selection, sandboxing, profiles, plugins, and MCP integrations:

**Default behavior:** On-request approvals, `workspace-write` sandbox, cached web search by default, and analytics/feedback disabled

**Profiles:** `quick`, `deep`, and `research` (`research` enables live web search)

**Rules:** `.codex/rules/` defines allowed command groups for `git`, `dev`, `shell`, and `infra`

**Enabled plugins:** Slack, caveman

**Marketplace:** [caveman](https://github.com/JuliusBrussee/caveman)

**MCP servers:** Atlassian, Datadog
