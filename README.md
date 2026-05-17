# Dotfiles

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
- [Flatpaks](#flatpaks)
- [Claude Code](#claude-code)
- [Codex](#codex)

## Quick Start

1. Complete [Prerequisites](#prerequisites) (Xcode CLT, Homebrew, SSH key, Touch ID).
2. Clone this repository.
3. Run `make setup` (base packages) or `make setup-all` (base + work packages) to configure macOS, symlink configs, install packages, and show versions.

Run `make help` to list all available targets.

## Prerequisites

> Apple Silicon only. Homebrew prefix defaults to `/opt/homebrew` in `.zshrc` / `.zprofile` (override via `BREW_PREFIX` env), but Intel `/usr/local` layout is not tested or supported.

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
- `.config/ripgrep/ripgreprc` - Ripgrep defaults (smart-case, hidden files, follow symlinks); resolved via `RIPGREP_CONFIG_PATH`
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
- `.config/superfile/config.toml` - Superfile (`spf`) terminal file manager settings (linked into Library/Application Support/superfile)
- `.config/vscode/settings.json` - VSCode configuration (linked into `Library/Application Support/Code/User`)
- `.config/zed/settings.json` - Zed editor settings
- `.claude/settings.json` - Claude Code permissions
- `.claude/CLAUDE.md` - Claude Code user-level instructions
- `.config/ccstatusline/settings.json` - Claude Code status line layout
- `.codex/config.toml` - Codex CLI config (model, sandbox, plugins)
- `.codex/AGENTS.md` - Codex user-level instructions
- `.codex/rules/` - Codex permission rules (git, dev, shell, infra)

**Not symlinked (used directly from repo):**

- `.Brewfile` - Base Brewfile (shell, fonts, daily-driver apps, VSCode extensions)
- `.Brewfile.work` - Work Brewfile (work-specific GUIs — API client, K8s GUI, DB GUI, container runtime, comms, VPN; curated manually)
- `.flatpaks` - Base Flathub app IDs for Linux (paired with `.Brewfile` casks where an equivalent exists)
- `.flatpaks.work` - Work Flathub app IDs for Linux (paired with `.Brewfile.work` casks; curated manually)
- `flatpaks-install.sh` - Installs `.flatpaks` / `.flatpaks.work` at user scope (Linux only, no-op on macOS)
- `CLAUDE.md` - Repository instructions for Claude Code (auto-discovered in cwd; Codex reads it via `project_doc_fallback_filenames`)
- `.config/vscode/defaultSettings.jsonc` - VSCode defaults for comparing settings

## macOS Settings

Run `make defaults` to configure (in order applied):

- Folders (~/Projects, ~/Screenshots)
- System defaults (key repeat, natural scrolling, save to disk)
- Screenshots (save to ~/Screenshots, no shadow, PNG)
- Finder (list view, path bar, show extensions, folders first, search current folder)
- Dock (autohide, no recents, minimize to app, fixed Spaces order, hot corners disabled)

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
| Database              | **Beekeeper Studio**, TablePlus, Postico, MongoDB Compass                            |
| API Testing           | **Bruno**, Yaak, Hoppscotch                                                          |
| Medical Imaging       | **Horos**, Weasis, OsiriX Lite                                                       |
| Browser (Gecko)       | **Firefox**, Zen + **uBlock Origin**                                                 |
| Browser (Chromium)    | **Brave**, Arc, Helium + **uBlock Origin Lite**                                      |
| Browser (WebKit)      | **Safari**, Orion + **wBlock**                                                       |
| Diagrams              | **Excalidraw**, tldraw                                                               |
| Diagram as Code       | **Mermaid**, D2                                                                      |
| Notes                 | **Apple Notes**, Bear, Obsidian                                                      |
| Todo                  | **Apple Reminders**, Things 3                                                        |
| Calendar              | **Apple Calendar**, Fantastical                                                      |
| Mail                  | **Apple Mail**, Mimestream                                                           |
| Password Manager      | **Apple Passwords**, 1Password, Bitwarden                                            |
| Office                | **Apple iWork** (Pages, Numbers, Keynote), Google Workspace, Microsoft 365           |
| macOS Utilities       | Rectangle, Maccy, Keka, KeepingYouAwake, Thaw, MiddleClick, LinearMouse, balenaEtcher |
| Networking            | Cloudflare WARP, LocalSend, Tailscale                                                |
| Linux Distros         | Bluefin, elementary OS, Fedora Silverblue, Fedora Workstation, Pop!_OS               |

**VSCode setup:**

- Enable settings sync with GitHub
- Sign in to Copilot Chat (base `github.copilot` installs as a dependency; next-edit suggestions intentionally off via `github.copilot.nextEditSuggestions.enabled: false`)
- Configure layout (View → Appearance / Customize Layout):
  - Quick input position: center
  - Panel alignment: justify
  - Secondary side bar: right

## CLI Tools

Installed via Homebrew formulae and casks (see `.Brewfile` and `.Brewfile.work`):

```bash
make brew-install       # Install all packages (base + work)
make brew-install-base  # Install base packages only
make brew-install-work  # Install work packages only
make brew-cleanup       # Clean up old versions and cache
make brew-export        # Export installed packages (incl. VSCode extensions) to .Brewfile, then strip .Brewfile.work entries; add new work entries to .Brewfile.work manually
make versions           # Show installed Go, Node, Python versions
```

| Tool                    | Description                                             |
| ----------------------- | ------------------------------------------------------- |
| argocd                  | Argo CD CLI (Kubernetes GitOps)                         |
| atuin                   | Shell history sync + Ctrl+R replacement                 |
| awscli                  | AWS command-line interface                              |
| bat                     | `cat` with syntax highlighting                          |
| bottom                  | System monitor TUI (`btm`, modern `htop`)               |
| dua-cli                 | Interactive disk usage analyzer (alternative to gdu)    |
| exiftool                | Read/write image/audio/video metadata                   |
| eza                     | Modern `ls` replacement                                 |
| fd                      | Modern `find` replacement                               |
| fnm                     | Fast Node Manager (auto-switches via `.node-version`)   |
| fx                      | Terminal JSON viewer / processor                        |
| fzf                     | Fuzzy finder (Ctrl+T files, Alt+C dirs)                 |
| gdu                     | Fast parallel disk usage analyzer (Go)                  |
| gh                      | GitHub CLI                                              |
| git                     | Distributed version control                             |
| git-delta               | Syntax-highlighting git pager (replaces `less`)         |
| git-lfs                 | Git Large File Storage extension                        |
| gitui                   | Git TUI (Rust, alternative to lazygit)                  |
| glow                    | Terminal Markdown renderer                              |
| go                      | Go toolchain (1.26)                                     |
| helm                    | Kubernetes package manager                              |
| jq / yq                 | JSON / YAML processors                                  |
| k9s                     | Kubernetes TUI                                          |
| kdash                   | Kubernetes dashboard TUI (Rust)                         |
| kubectl                 | Kubernetes CLI                                          |
| kustomize               | Kubernetes manifest overlays/patches                    |
| lazydocker              | Docker TUI                                              |
| lazygit                 | Git TUI                                                 |
| lazysql                 | Multi-engine SQL TUI                                    |
| litecli                 | SQLite CLI with autocomplete                            |
| micro                   | Terminal text editor                                    |
| pgcli                   | PostgreSQL CLI with autocomplete                        |
| protobuf                | Protocol Buffers compiler (`protoc`)                    |
| rainfrog                | Postgres/MySQL/SQLite database TUI (alternative to lazysql) |
| ripgrep                 | Fast `grep` replacement                                 |
| sevenzip                | 7-Zip file archiver                                     |
| shellcheck              | Shell script static analyzer                            |
| shfmt                   | Shell script formatter                                  |
| starship                | Cross-shell prompt                                      |
| superfile               | Modern terminal file manager (alternative to yazi)      |
| tlrc                    | `tldr` client (Rust); binary is `tldr`                  |
| uv                      | Python version/package manager                          |
| yazi                    | Terminal file manager                                   |
| zoxide                  | Smarter `cd` (learns from usage)                        |
| zsh-autosuggestions     | Fish-like command suggestions                           |
| zsh-completions         | Additional shell completions                            |
| zsh-syntax-highlighting | Command syntax highlighting                             |

## Validate

After `make setup`, verify everything wired up:

- `make versions` — Go / Node / Python toolchains print
- `git config --list --show-origin | head -5` — settings come from `~/.config/git/config`
- `ls -l ~/.config/ghostty/config ~/.zshrc ~/.config/git/config` — symlinks point at this repo

For full audit recipe (TOML/JSON/YAML/JSONC parsers, `brew bundle check`, `shellcheck`, symlink walk, web verification of suspect keys) see `CLAUDE.md` "Config Validation" section.

## Updating

- `brew update && brew upgrade` — update Homebrew formulae and casks
- `make brew-export` — refresh `.Brewfile` from current install state (then add any new work entries to `.Brewfile.work` manually; see CLAUDE.md "Brewfile maintenance" for strip step semantics)
- `make brew-cleanup` — prune old versions and cache
- `flatpak update --user` — update installed Flathub apps (Linux)
- `make flatpaks-export` — refresh `.flatpaks` from current install state (then add any new work entries to `.flatpaks.work` manually; same strip semantics as `brew-export`)
- VSCode / Zed / Ghostty — auto-update enabled, no action needed
- Go: `brew upgrade go`. Node: `fnm install <version>`. Python: `uv python install <version>`.

## Casks

GUI applications, CLIs, and fonts installed via Homebrew Cask:

### Base Casks

| Cask                        | Description                      |
| --------------------------- | -------------------------------- |
| 1password                   | Password manager                 |
| 1password-cli               | 1Password CLI                    |
| arc                         | Web browser (Chromium)           |
| balenaetcher                | USB flash tool                   |
| brave-browser               | Web browser (Chromium)           |
| claude-code                 | Anthropic Claude CLI             |
| cloudflare-warp             | VPN / 1.1.1.1 client             |
| codex                       | OpenAI Codex CLI                 |
| firefox                     | Web browser                      |
| font-fira-code              | Fallback monospace font          |
| font-jetbrains-mono         | Primary monospace font           |
| font-symbols-only-nerd-font | Nerd Font icons (symbols only)   |
| ghostty                     | Terminal emulator                |
| horos                       | Medical imaging viewer (DICOM)   |
| keepingyouawake             | Prevent sleep                    |
| keka                        | File archiver                    |
| linearmouse                 | Per-device mouse customization   |
| localsend                   | Cross-platform LAN file sharing  |
| maccy                       | Clipboard manager                |
| middleclick                 | Three-finger tap as middle click |
| obsidian                    | Notes / knowledge base           |
| rectangle                   | Window manager                   |
| thaw                        | Menu bar manager                 |
| visual-studio-code          | Code editor                      |
| zed                         | Code editor                      |
| zen                         | Web browser (Gecko)              |

### Work Casks

| Cask             | Description                               |
| ---------------- | ----------------------------------------- |
| beekeeper-studio | Multi-engine SQL GUI                      |
| bruno            | API testing client                        |
| google-chrome    | Web browser                               |
| headlamp         | Kubernetes GUI                            |
| mongodb-compass  | MongoDB GUI                               |
| orbstack         | Docker/Linux VM (replaces Docker Desktop) |
| slack            | Team messaging                            |
| tailscale-app    | VPN/mesh networking                       |

## Flatpaks

GUI applications for Linux installed via Flathub at **user scope** (`~/.local/share/flatpak`, no sudo). Mirrors the `.Brewfile` / `.Brewfile.work` split.

- `make flatpaks-install-base` — install `.flatpaks`
- `make flatpaks-install-work` — install `.flatpaks.work`
- `make flatpaks-install` — both
- `make flatpaks-export` — refresh `.flatpaks` from installed state (strips `.flatpaks.work` entries; add new work entries manually)

All targets no-op on macOS. Requires `flatpak` (install via `brew install flatpak` on Linux). Bootstrap adds the Flathub user remote automatically on first run.

### Base Flatpaks

| Flathub ID                  | Paired cask        | Description                     |
| --------------------------- | ------------------ | ------------------------------- |
| app.zen_browser.zen         | zen                | Web browser (Gecko)             |
| com.brave.Browser           | brave-browser      | Web browser (Chromium)          |
| com.github.tchx84.Flatseal  | —                  | Flatpak permission editor       |
| com.onepassword.OnePassword | 1password          | Password manager                |
| com.visualstudio.code       | visual-studio-code | Code editor                     |
| dev.zed.Zed                 | zed                | Code editor                     |
| md.obsidian.Obsidian        | obsidian           | Notes / knowledge base          |
| org.localsend.localsend_app | localsend          | Cross-platform LAN file sharing |
| org.mozilla.firefox         | firefox            | Web browser                     |

### Work Flatpaks

| Flathub ID                | Paired cask      | Description          |
| ------------------------- | ---------------- | -------------------- |
| com.google.Chrome         | google-chrome    | Web browser          |
| com.mongodb.Compass       | mongodb-compass  | MongoDB GUI          |
| com.slack.Slack           | slack            | Team messaging       |
| com.usebruno.Bruno        | bruno            | API testing client   |
| io.beekeeperstudio.Studio | beekeeper-studio | Multi-engine SQL GUI |
| io.kinvolk.Headlamp       | headlamp         | Kubernetes GUI       |

### macOS-only (no Flathub equivalent)

- **CLI tools** — `1password-cli`, `claude-code`, `codex`, `cloudflare-warp` (use brew formulae or distro packages on Linux).
- **Fonts** — `font-fira-code`, `font-jetbrains-mono`, `font-symbols-only-nerd-font` (install via distro packages or directly from upstream releases on Linux; Flathub is not a font distribution channel).
- **GUI apps not on Flathub** — `arc`, `balenaetcher`, `ghostty`, `horos`, `orbstack`, `tailscale-app` (use distro packages, upstream binaries, or alternatives on Linux).
- **macOS-system tools** — `keepingyouawake`, `keka`, `linearmouse`, `maccy`, `middleclick`, `rectangle`, `thaw` (no direct Linux concept; equivalents are distro-specific GNOME/KDE settings or extensions).

## Claude Code

The `.claude/settings.json` configures permissions and plugins:

- **Allowed:** Web search, fetch from dev docs (GitHub, Stack Overflow, MDN, Go/Python/Node/Terraform/Docker/Kubernetes/Claude docs), git/docker/k8s read-only commands, build/test/lint tools, dependency sync (`go mod tidy/download`, `uv sync/lock`, `npm ci`), version probes (`go/uv/python/python3/node/npm --version`, `fnm list/current`), `fd`/`rg`/`grep`/`find`/`which`/`tldr`/`date` for file search and inspection
- **Denied:** `.env` files, `.ssh/*`, `.kube/config`, `.git-credentials`, credentials, private keys, `.tfvars`
- **Requires approval:** Arbitrary package install (`brew install`, `npm install`, `uv add`), direct code execution (`python`, `node`, `go run`), git writes, docker mutations
- **Enabled plugins:** pyright-lsp, gopls-lsp, typescript-lsp, code-review, feature-dev, code-simplifier, claude-md-management, caveman, context7, slack, atlassian, posthog, datadog, pr-review-toolkit
- **Marketplace:** [caveman](https://github.com/JuliusBrussee/caveman) (auto-update enabled)
- **Status line:** Custom layout via [`ccstatusline`](https://www.npmjs.com/package/ccstatusline) (model, thinking effort, cwd, git branch, context %, session/weekly usage, cost)
- **Usage tracking:** [`ccusage`](https://github.com/ryoppippi/ccusage) for token usage and cost analysis

## Codex

The `.codex/config.toml` configures model selection, sandboxing, profiles, plugins, and MCP integrations:

- **Default behavior:** On-request approvals, `workspace-write` sandbox, cached web search by default, analytics/feedback disabled
- **Profiles:** `quick` and `research` (`research` enables live web search)
- **Rules:** `.codex/rules/` defines allowed command groups for `git`, `dev`, `shell`, and `infra`
- **Enabled plugins:** Slack, caveman
- **Marketplace:** [caveman](https://github.com/JuliusBrussee/caveman)
- **MCP servers:** Atlassian, Datadog, Context7, PostHog
