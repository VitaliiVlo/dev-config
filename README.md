# macOS Development Configuration Guide

Dotfiles configured with **Catppuccin Macchiato** (dark) / **Catppuccin Latte** (light) theme and **JetBrains Mono** font (14pt) with **Fira Code**, **Menlo**, **Monaco**, and **Symbols Nerd Font Mono** fallbacks. Configured for **Go 1.26**, **Python** (via `uv`), and **Node.js** (via `fnm`).

## Contents

- [Quick Start](#quick-start)
- [Prerequisites](#prerequisites)
- [Configuration Files](#configuration-files)
- [macOS Settings](#macos-settings)
- [Applications](#applications)
- [CLI Tools](#cli-tools)
- [Validate](#validate)
- [Updating](#updating)
- [Casks](#casks)
- [Claude Code](#claude-code)
- [Codex](#codex)

## Quick Start

1. Complete [Prerequisites](#prerequisites) (Xcode CLT, Homebrew, SSH key, Touch ID).
2. Clone this repository.
3. Run `make setup` to configure macOS, symlink configs, install packages, and show versions.

Run `make help` to list all available targets.

## Prerequisites

- **Install Xcode Command Line Tools:** git, make, grep, tar etc.
  ```bash
  xcode-select --install
  ```
- **Install Homebrew**
  ```bash
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```
- **Generate SSH key for Git**
  ```bash
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

The following files are automatically symlinked by running `make link`:

- `.zprofile` - Shell environment variables
- `.zshrc` - Shell configuration and aliases
- `.config/git/config` - Git user and global settings (XDG path)
- `.config/git/ignore` - Global gitignore (XDG path)
- `.config/ripgrep/ripgreprc` - Ripgrep defaults (smart-case, hidden files); resolved via `RIPGREP_CONFIG_PATH`
- `.config/ghostty/config` - Ghostty configuration
- `.config/starship/starship.toml` - Starship configuration (symlinked to `~/.config/starship.toml`, flat path per starship.rs)
- `.config/bat/config` - Bat configuration
- `.config/gh/config.yml` - GitHub CLI settings
- `.config/lazygit/config.yml` - Lazygit settings
- `.config/micro/settings.json` - Micro editor settings
- `.config/yazi/yazi.toml` - Yazi file manager settings
- `.config/atuin/config.toml` - Atuin shell history settings
- `.config/bottom/bottom.toml` - Bottom (`btm`) system monitor settings
- `.config/glow/glow.yml` - Glow Markdown renderer settings
- `.config/tlrc/config.toml` - tlrc (tldr client) settings (linked into Library/Application Support/tlrc)
- `.config/vscode/settings.json` - VSCode configuration (linked into `Library/Application Support/Code/User`)
- `.config/zed/settings.json` - Zed editor settings
- `.claude/settings.json` - Claude Code permissions
- `.claude/CLAUDE.md` - Claude Code user-level instructions
- `.config/ccstatusline/settings.json` - Claude Code status line layout
- `.codex/config.toml` - Codex CLI config (model, sandbox, plugins)
- `.codex/AGENTS.md` - Codex user-level instructions
- `.codex/rules/` - Codex permission rules (git, dev, shell, infra)

**Not symlinked (used directly from repo):**

- `.Brewfile.core` - Core Brewfile (shell, fonts, daily-driver apps, VSCode extensions)
- `.Brewfile.extra` - Extra Brewfile (work-specific tooling, IDEs, infra; curated manually)
- `.config/vscode/defaultSettings.jsonc` - VSCode defaults for comparing settings

## macOS Settings

Run `make defaults` to configure:

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
| Editor                | **VSCode**, Zed, Cursor                                                              |
| Terminal              | **Ghostty**, Kitty, Alacritty                                                        |
| AI                    | **Claude Code**, Codex, Gemini CLI, OpenCode                                         |
| Containers            | **OrbStack**, Colima, Podman Desktop                                                 |
| Kubernetes            | **Headlamp**, Aptakube, Freelens                                                     |
| Kubernetes Remote Dev | **Telepresence**, mirrord                                                            |
| Database              | TablePlus, Postico, MongoDB Compass, Beekeeper Studio                                |
| API Testing           | **Bruno**, Yaak, Hoppscotch                                                          |
| Browser (Gecko)       | **Firefox**, Zen + **uBlock Origin**                                                 |
| Browser (Chromium)    | **Chrome**, Helium, Arc + **uBlock Origin Lite**                                     |
| Browser (WebKit)      | **Safari**, Orion + **wBlock**, Wipr 2                                               |
| Diagrams              | **Excalidraw**, tldraw                                                               |
| Diagram as Code       | **Mermaid**, D2                                                                      |
| Notes                 | **Apple Notes**, Bear, Obsidian                                                      |
| Todo                  | **Apple Reminders**, Things 3                                                        |
| Calendar              | **Apple Calendar**, Fantastical                                                      |
| Mail                  | **Apple Mail**, Mimestream                                                           |
| Password Manager      | **Apple Passwords**, 1Password, Bitwarden                                            |
| macOS Tools           | Raycast, Rectangle, Maccy, Keka, KeepingYouAwake, Ice, MiddleClick, balenaEtcher     |

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
make brew-install       # Install all packages (core + extra)
make brew-install-core  # Install core packages only
make brew-install-extra # Install extra packages only
make brew-check         # Check for missing packages
make brew-cleanup       # Clean up old versions and cache
make brew-export        # Export installed packages (incl. VSCode extensions) to .Brewfile.core, then strip .Brewfile.extra entries; add new extras to .Brewfile.extra manually
make versions           # Show installed Go, Node, Python versions
```

| Tool                    | Description                                             |
| ----------------------- | ------------------------------------------------------- |
| argocd                  | Argo CD CLI (Kubernetes GitOps)                         |
| atuin                   | Shell history sync + Ctrl+R replacement                 |
| awscli                  | AWS command-line interface                              |
| bat                     | `cat` with syntax highlighting                          |
| bottom                  | System monitor TUI (`btm`, modern `htop`)               |
| dust                    | Disk usage analyzer (modern `du`)                       |
| eza                     | Modern `ls` replacement                                 |
| fd                      | Modern `find` replacement                               |
| fnm                     | Fast Node Manager (auto-switches via `.node-version`)   |
| fx                      | Terminal JSON viewer / processor                        |
| fzf                     | Fuzzy finder (Ctrl+T files, Alt+C dirs)                 |
| gh                      | GitHub CLI                                              |
| git                     | Distributed version control                             |
| git-delta               | Syntax-highlighting git pager (replaces `less`)         |
| git-lfs                 | Git Large File Storage extension                        |
| glow                    | Terminal Markdown renderer                              |
| go                      | Go toolchain (1.26)                                     |
| helm                    | Kubernetes package manager                              |
| jq / yq                 | JSON / YAML processors                                  |
| k9s                     | Kubernetes TUI                                          |
| kubectl                 | Kubernetes CLI                                          |
| kustomize               | Kubernetes manifest overlays/patches                    |
| lazydocker              | Docker TUI                                              |
| lazygit                 | Git TUI                                                 |
| litecli                 | SQLite CLI with autocomplete                            |
| micro                   | Terminal text editor                                    |
| pgcli                   | PostgreSQL CLI with autocomplete                        |
| protobuf                | Protocol Buffers compiler (`protoc`)                    |
| ripgrep                 | Fast `grep` replacement                                 |
| sevenzip                | 7-Zip file archiver                                     |
| shellcheck              | Shell script static analyzer                            |
| shfmt                   | Shell script formatter                                  |
| starship                | Cross-shell prompt                                      |
| tlrc                    | `tldr` client (Rust)                                    |
| uv                      | Python version/package manager                          |
| yazi                    | Terminal file manager                                   |
| zoxide                  | Smarter `cd` (learns from usage)                        |
| zsh-autosuggestions     | Fish-like command suggestions                           |
| zsh-completions         | Additional shell completions                            |
| zsh-syntax-highlighting | Command syntax highlighting                             |

## Validate

After `make setup`, verify everything wired up:

- `make brew-check` — every Brewfile package installed
- `make versions` — Go / Node / Python toolchains print
- `git config --list --show-origin | head -5` — settings come from `~/.config/git/config`
- `ls -l ~/.config/ghostty/config ~/.zshrc ~/.config/git/config` — symlinks point at this repo

For full audit recipe (TOML/JSON/YAML/JSONC parsers, `brew bundle check`, `shellcheck`, symlink walk, web verification of suspect keys) see `CLAUDE.md` "Config Validation" section.

## Updating

- `brew update && brew upgrade` — update Homebrew formulae and casks
- `make brew-export` — refresh `.Brewfile.core` from current install state (then add any new extras to `.Brewfile.extra` manually)
- `make brew-cleanup` — prune old versions and cache
- VSCode / Zed / Ghostty — auto-update enabled, no action needed
- Go: `brew upgrade go`. Node: `fnm install <version>`. Python: `uv python install <version>`.

## Casks

GUI applications and fonts installed via Homebrew Cask:

### Core Casks

| Cask                        | Description                      |
| --------------------------- | -------------------------------- |
| arc                         | Web browser (Chromium)           |
| balenaetcher                | USB flash tool                   |
| claude-code                 | Anthropic Claude CLI             |
| codex                       | OpenAI Codex CLI                 |
| firefox                     | Web browser                      |
| font-fira-code              | Fallback monospace font          |
| font-jetbrains-mono         | Primary monospace font           |
| font-symbols-only-nerd-font | Nerd Font icons (symbols only)   |
| ghostty                     | Terminal emulator                |
| google-chrome               | Web browser                      |
| helium-browser              | Web browser (Chromium)           |
| jordanbaird-ice             | Menu bar manager (Ice)           |
| keepingyouawake             | Prevent sleep                    |
| keka                        | File archiver                    |
| maccy                       | Clipboard manager                |
| middleclick                 | Three-finger tap as middle click |
| rectangle                   | Window manager                   |
| visual-studio-code          | Code editor                      |
| zed                         | Code editor                      |
| zen                         | Web browser (Gecko)              |

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

- **Allowed:** Web search, fetch from dev docs (GitHub, Stack Overflow, MDN, Go/Python/Node/Terraform/Docker/Kubernetes/Claude docs), git/docker/k8s read-only commands, build/test/lint tools, `fd` and `rg` for file search
- **Denied:** `.env` files, `.ssh/*`, `.kube/config`, `.git-credentials`, credentials, private keys, `.tfvars`
- **Requires approval:** Package installs, direct code execution (`python`, `node`, `go run`), git writes, docker mutations
- **Enabled plugins:** pyright-lsp, gopls-lsp, typescript-lsp, code-review, feature-dev, code-simplifier, claude-md-management, caveman, context7, slack, atlassian, posthog, datadog, pr-review-toolkit
- **Marketplace:** [caveman](https://github.com/JuliusBrussee/caveman) (auto-update enabled)
- **Status line:** Custom layout via [`ccstatusline`](https://www.npmjs.com/package/ccstatusline) (model, thinking effort, cwd, git branch, context %, session/weekly usage, cost)
- **Usage tracking:** [`ccusage`](https://github.com/ryoppippi/ccusage) for token usage and cost analysis

## Codex

The `.codex/config.toml` configures model selection, sandboxing, profiles, plugins, and MCP integrations:

- **Default behavior:** On-request approvals, `workspace-write` sandbox, cached web search by default, analytics/feedback disabled
- **Profiles:** `quick`, `deep`, and `research` (`research` enables live web search)
- **Rules:** `.codex/rules/` defines allowed command groups for `git`, `dev`, `shell`, and `infra`
- **Enabled plugins:** Slack, caveman
- **Marketplace:** [caveman](https://github.com/JuliusBrussee/caveman)
- **MCP servers:** Atlassian, Datadog, Context7, PostHog
