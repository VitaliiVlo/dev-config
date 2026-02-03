# macOS Development Configuration Guide

Dotfiles configured with **Catppuccin Macchiato** theme and **JetBrains Mono** font (14pt). Configured for **Go 1.25** and **Python 3.14**.

## Quick Start

1. Clone this repository
2. Run `make install` to symlink configs and install packages
3. Run `make defaults` to configure macOS settings (optional)

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

The following files are automatically symlinked by running `make link`:
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
- `.claude/settings.json` - Claude Code permissions
- `.claude/commands/` - Claude Code custom slash commands

**Reference files (not symlinked):**
- `.config/Code/User/defaultSettings.jsonc` - VSCode defaults for comparing settings
- `.editorconfig` - Editor config template (copy to projects)

## macOS Settings

Run `make defaults` to configure:
- Finder (list view, path bar, show extensions)
- Dock (no recents, faster animation)
- Screenshots (save to ~/Screenshots)

## Applications

**Selection criteria (ranked by priority):**
1. Polished UX, feels native
2. Lightweight and simple, not bloated with features
3. Popular and actively maintained
4. macOS available (Linux is a plus)
5. Rising or stable trends (avoid declining tools)
6. Reasonable price (free is a plus)

Install via official installers or Homebrew Cask:

| Category         | Apps                                                    |
| ---------------- | ------------------------------------------------------- |
| Editor           | **VSCode**, Zed, JetBrains                              |
| Terminal         | **Ghostty**, Kitty, Alacritty, WezTerm                  |
| Containers       | **OrbStack**, Colima, Podman Desktop, Rancher Desktop   |
| Kubernetes       | **Headlamp**, Freelens, Aptakube, Telepresence, mirrord |
| Database         | **TablePlus**, Beekeeper Studio, DbGate, MongoDB Compass |
| API Testing      | **Bruno**, Hoppscotch, Insomnia, Yaak                   |
| Browser          | **Brave**, Firefox, Zen Browser, Chrome                 |
| Diagrams         | **Excalidraw**, tldraw, Mermaid, D2                     |
| Notes            | **Obsidian**, Logseq, Simplenote, Bear, Apple Notes     |
| Password Manager | **1Password**, Bitwarden, Proton Pass                   |

**VSCode setup:**
- Enable settings sync with GitHub
- Enable Copilot
- Install `code` command to PATH (Cmd+Shift+P → "Shell Command")
- Configure layout (View → Appearance / Customize Layout):
  - Quick input position: center
  - Panel alignment: justify
  - Secondary side bar: right

## CLI Tools

Installed via Homebrew formulae (see `.Brewfile`):

```bash
make brew-install  # Install from Brewfile
make brew-check    # Check for missing packages
make brew-export   # Update Brewfile (excludes Go deps, VSCode extensions)
```

| Tool | Description |
| ---- | ----------- |
| bat | `cat` with syntax highlighting |
| btop | System monitor TUI (modern `htop`) |
| eza | Modern `ls` replacement |
| fd | Modern `find` replacement |
| fzf | Fuzzy finder (Ctrl+T files, Ctrl+R history, Alt+C dirs) |
| grpcurl | `curl` for gRPC services |
| ripgrep | Fast `grep` replacement |
| jq / yq | JSON / YAML processors |
| zoxide | Smarter `cd` (learns from usage) |
| starship | Cross-shell prompt |
| httpie | HTTP client |
| k9s | Kubernetes TUI |
| kubectl | Kubernetes CLI |

## Casks

Additional applications and fonts installed via Homebrew Cask:

| Cask | Description |
| ---- | ----------- |
| claude-code | Claude Code CLI |
| codex | OpenAI Codex CLI |
| font-jetbrains-mono | Primary monospace font |
| font-fira-code | Fallback monospace font |

## Claude Code

The `.claude/settings.json` configures pre-approved and blocked permissions:

**Allowed:** Web search, fetch from dev docs (GitHub, Stack Overflow, MDN, Go/Python/Node/Rust/Terraform/Claude docs), git/docker/k8s read-only commands, build/test/lint tools, `fd` and `rg` for file search

**Blocked:** `.env` files, credentials, secrets, private keys, `.tfvars`

**Requires approval:** Package installs, direct code execution (`python`, `node`, `go run`), git writes, docker mutations

**Enabled plugins:** context7, pyright-lsp, gopls-lsp, typescript-lsp, code-review, feature-dev

**Custom commands:** `/readme`, `/audit`, `/diff-audit`, `/iterate`, `/commit`

**Workflow:** `/audit` or `/diff-audit` → `/iterate` → `/commit` (see CLAUDE.md for details)
