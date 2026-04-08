# macOS Development Configuration Guide

Dotfiles configured with **Catppuccin Macchiato** theme and **JetBrains Mono** font (14pt). Configured for **Go 1.26**, **Python** (via `uv`), and **Node.js** (via `fnm`).

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
- `.Brewfile` - Global Brewfile
- `.ripgreprc` - Ripgrep defaults (smart-case, hidden files)
- `.config/starship.toml` - Starship configuration
- `.config/ghostty/config` - Ghostty configuration
- `.config/bat/config` - Bat configuration
- `.config/btop/btop.conf` - Btop configuration
- `.config/Code/User/settings.json` - VSCode configuration
- `.config/gh/config.yml` - GitHub CLI settings
- `.codex/config.toml` - Codex CLI config
- `.codex/AGENTS.md` - Codex user-level instructions
- `.codex/rules/` - Codex permission rules (git, dev, shell, infra)
- `.config/ccstatusline/settings.json` - Claude Code status line layout
- `.claude/settings.json` - Claude Code permissions
- `.claude/CLAUDE.md` - Claude Code user-level instructions

**Reference files (not symlinked):**

- `.config/Code/User/defaultSettings.jsonc` - VSCode defaults for comparing settings

## macOS Settings

Run `just defaults` to configure:

- Finder (list view, path bar, show extensions)
- .DS_Store cleanup (removes from home directory)
- Dock (no recents, faster animation)
- Screenshots (save to ~/Screenshots)

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

| Category              | Apps                                                      |
| --------------------- | --------------------------------------------------------- |
| Editor                | **VSCode**, Zed, JetBrains                                |
| Terminal              | **Ghostty**, Kitty, Alacritty                             |
| Containers            | **OrbStack**, Colima, Podman Desktop                      |
| Kubernetes            | **Headlamp**, Freelens, Aptakube                          |
| K8s Dev Tunnels       | **Telepresence**, mirrord                                 |
| Database              | **TablePlus**, Beekeeper Studio, Postico, MongoDB Compass |
| API Testing           | **Bruno**, Yaak, Hoppscotch, Insomnia                     |
| Browser               | **Brave**, Firefox, Zen Browser, Chrome                   |
| Ad Blocker (Chromium) | **uBlock Origin Lite**, AdGuard, Ghostery                 |
| Ad Blocker (Safari)   | **wBlock**, Wipr 2, 1Blocker, AdGuard                     |
| Archiver              | **Keka**, The Unarchiver                                  |
| VPN                   | **Mullvad**, Proton VPN                                   |
| Diagrams              | **Excalidraw**, tldraw, Mermaid, D2                       |
| Notes                 | **Apple Notes**, Bear, Obsidian                           |
| Password Manager      | **Apple Passwords**, 1Password, Bitwarden                 |
| macOS Tools           | **Raycast**, Rectangle, Ice, Middle                       |

**VSCode setup:**

- Enable settings sync with GitHub
- Enable Copilot
- Install `code` command to PATH (Cmd+Shift+P → "Shell Command")
- Configure layout (View → Appearance / Customize Layout):
    - Quick input position: center
    - Panel alignment: justify
    - Secondary side bar: right

## CLI Tools

Installed via Homebrew formulae and casks (see `.Brewfile`):

```bash
just brew-install  # Install from Brewfile
just brew-check    # Check for missing packages
just brew-outdated # Show outdated packages
just brew-update   # Update and upgrade all packages
just brew-cleanup  # Clean up old versions and cache
just brew-export   # Update Brewfile (excludes Go deps, VSCode extensions)
just versions      # Show installed Go, Node, Python versions
```

| Tool                    | Description                                             |
| ----------------------- | ------------------------------------------------------- |
| bat                     | `cat` with syntax highlighting                          |
| btop                    | System monitor TUI (modern `htop`)                      |
| eza                     | Modern `ls` replacement                                 |
| fd                      | Modern `find` replacement                               |
| fnm                     | Fast Node Manager (auto-switches via `.node-version`)   |
| fzf                     | Fuzzy finder (Ctrl+T files, Ctrl+R history, Alt+C dirs) |
| gemini-cli              | Google Gemini CLI                                       |
| gh                      | GitHub CLI                                              |
| git-delta               | Syntax-highlighting git pager (replaces `less`)         |
| jq / yq                 | JSON / YAML processors                                  |
| just                    | Task runner (replaces `make`)                           |
| k9s                     | Kubernetes TUI                                          |
| kubectl                 | Kubernetes CLI                                          |
| lazygit                 | Git TUI                                                 |
| ripgrep                 | Fast `grep` replacement                                 |
| starship                | Cross-shell prompt                                      |
| uv                      | Python version/package manager                          |
| zoxide                  | Smarter `cd` (learns from usage)                        |
| zsh-autosuggestions     | Fish-like command suggestions                           |
| zsh-completions         | Additional shell completions                            |
| zsh-syntax-highlighting | Command syntax highlighting                             |

## Casks

GUI applications and fonts installed via Homebrew Cask:

| Cask                | Description                               |
| ------------------- | ----------------------------------------- |
| 1password           | Password manager                          |
| balenaetcher        | USB flash tool                            |
| bitwarden           | Password manager (open source)            |
| bruno               | API testing client                        |
| claude-code         | Anthropic Claude CLI                      |
| codex               | OpenAI Codex CLI                          |
| firefox             | Web browser                               |
| font-fira-code      | Fallback monospace font                   |
| font-jetbrains-mono | Primary monospace font                    |
| ghostty             | Terminal emulator                         |
| keepingyouawake     | Prevent sleep                             |
| keka                | File archiver                             |
| logi-options+       | Logitech device manager                   |
| maccy               | Clipboard manager                         |
| middleclick         | Three-finger tap as middle click          |
| mongodb-compass     | MongoDB GUI                               |
| orbstack            | Docker/Linux VM (replaces Docker Desktop) |
| rectangle           | Window manager                            |
| slack               | Team messaging                            |
| tailscale-app       | VPN/mesh networking                       |
| visual-studio-code  | Code editor                               |
| zed                 | Code editor                               |

## Claude Code

The `.claude/settings.json` configures pre-approved and blocked permissions:

**Allowed:** Web search, fetch from dev docs (GitHub, Stack Overflow, MDN, Go/Python/Node/Rust/Terraform/Claude docs), git/docker/k8s read-only commands, build/test/lint tools, `fd` and `rg` for file search

**Blocked:** `.env` files, `.ssh/*`, `.kube/config`, `.git-credentials`, credentials, private keys, `.tfvars`

**Requires approval:** Package installs, direct code execution (`python`, `node`, `go run`), git writes, docker mutations

**Status line:** Custom layout via [`ccstatusline`](https://www.npmjs.com/package/ccstatusline) showing model, thinking effort, cwd, git branch, context %, session/weekly usage, and cost

**Enabled plugins:** pyright-lsp, gopls-lsp, typescript-lsp, code-review, feature-dev, code-simplifier, claude-md-management

