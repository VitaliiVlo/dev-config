# macOS Development Configuration Guide

### System Configuration
- **OS Configuration**
  ```
  bootstrap-defaults.sh
  ```
- **Install Xcode Command Line Tools:** git, make, grep, tar etc.
  ```
  xcode-select --install
  ```
- **Configure sudo with Touch ID**
  ```
  cd /etc/pam.d
  cp sudo_local.template sudo_local
  Uncomment last line
  ```
- **Generate SSH key for Git**
  ```
  ssh-keygen -t ed25519 -C "your_email@example.com"
  cat ~/.ssh/id_ed25519.pub | pbcopy
  ```
- **Install Homebrew**
  ```
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```

### Configuration Files
The following files are automatically symlinked by running `./bootstrap.sh`:
- Custom `.zprofile` - Shell environment variables
- Custom `.zshrc` - Shell configuration and aliases
- Custom `.gitconfig` - Git user and global settings
- Custom `.gitignore_global` - Global gitignore
- Custom `.config/lsd/config.yaml` - LSDeluxe configuration
- Custom `.config/starship.toml` - Starship configuration
- Custom `.config/ghostty/config` - Ghostty configuration
- Custom `.config/bat/config` - Bat configuration
- Custom `.config/Code/User/settings.json` - VSCode configuration
- Custom `.Brewfile` - Global Brewfile

### CLI Tools (via Homebrew)
- Create or update the Brewfile:
  ```
  brew bundle dump --global --force --no-go --no-vscode
  ```
- Check Brewfile missing dependencies:
  ```
  brew bundle check --global
  ```
- Install from Brewfile:
  ```
  brew bundle install --global
  ```

### Applications
Install the following via official installers or Homebrew Cask:
- Browser
  - Chrome
  - Firefox
  - Brave
- VSCode
  - Enable settings sync with GitHub
  - Enable Copilot account
  - Install `code` command to PATH
- Jetbrains
  - Golang
  - PyCharm
- Terminal emulator
  - Ghostty
  - Wezterm
  - Kitty
  - Alacritty
- Database viewer
  - Beekeeper studio
  - TablePlus
  - Mongo Compass
- API testing
  - Postman
  - Insomnia
  - Bruno
  - Yaak
  - HTTPie
- Diagrams
  - Excalidraw
  - tldraw
  - Lucidchart
  - Mermaid
  - PUML
- Docker Desktop
- Lens (k8s)
