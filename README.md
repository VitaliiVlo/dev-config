# macOS Development Configuration Guide

## Quick Start

1. Clone this repository
2. Run `./bootstrap.sh` to symlink configuration files
3. Run `./bootstrap-defaults.sh` to configure macOS settings
4. Run `brew bundle install --global` to install CLI tools

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

The following files are automatically symlinked by running `./bootstrap.sh`:
- `.zprofile` - Shell environment variables
- `.zshrc` - Shell configuration and aliases
- `.gitconfig` - Git user and global settings
- `.gitignore_global` - Global gitignore
- `.Brewfile` - Global Brewfile
- `.config/lsd/config.yaml` - LSDeluxe configuration
- `.config/starship.toml` - Starship configuration
- `.config/ghostty/config` - Ghostty configuration
- `.config/bat/config` - Bat configuration
- `.config/Code/User/settings.json` - VSCode configuration
- `.claude/settings.json` - Claude Code permissions

## macOS Settings

Run `./bootstrap-defaults.sh` to configure:
- Finder (list view, path bar, show extensions)
- Dock (no recents, faster animation)
- Screenshots (save to ~/Screenshots)

## CLI Tools

Managed via Homebrew Brewfile:
```bash
# Install from Brewfile
brew bundle install --global

# Check for missing dependencies
brew bundle check --global

# Update Brewfile from installed packages
brew bundle dump --global --force --no-go --no-vscode
```

## Applications

Install via official installers or Homebrew Cask:

| Category | Apps |
|----------|------|
| Browser | Chrome, Firefox, Brave |
| Editor | VSCode, GoLand, PyCharm |
| Terminal | Ghostty, Wezterm, Kitty, Alacritty |
| Database | Beekeeper Studio, TablePlus, MongoDB Compass |
| API Testing | Postman, Insomnia, Bruno, Yaak, HTTPie |
| Diagrams | Excalidraw, tldraw, Mermaid, PlantUML |
| Containers | Docker Desktop, Lens |

**VSCode setup:**
- Enable settings sync with GitHub
- Enable Copilot
- Install `code` command to PATH (Cmd+Shift+P → "Shell Command")

## Claude Code

The `.claude/settings.json` configures pre-approved and blocked permissions:

**Allowed:** Web search, fetch from dev docs (GitHub, Stack Overflow, MDN, Go/Python/Node docs), git/docker read-only commands, build/test/lint tools

**Blocked:** `.env` files, credentials, secrets, private keys, `.tfvars`

**Requires approval:** Direct code execution (`python`, `node`, `npx`, `go run`), git writes, docker mutations
