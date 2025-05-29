# macOS Development Configuration Guide

### System Configuration
- **OS Configuration**
- **Install Xcode Command Line Tools**<br>
  **git, make, grep, tar ...**
  ```
  xcode-select --install
  ```
- **Configure sudo with Touch ID**
  ```
  Uncomment /etc/pam.d/sudo_local
  ```
- **Generate SSH key for Git**
  ```
  ssh-keygen -t ed25519 -C "your_email@example.com"
  cat ~/.ssh/id_ed25519.pub | pbcopy
  ```
- **Install Homebrew**

### Configuration Files
The following files are automatically symlinked by running `./bootstrap.sh`:
- Custom `.zprofile` - Shell environment variables
- Custom `.zshrc` - Shell configuration and aliases
- Custom `.gitconfig` - Git user and global settings
- Custom `.gitignore_global` - Global gitignore
- Custom `.config/lsd/config.yaml` - LSDeluxe configuration
- Custom `.config/ghostty/config` - Ghostty configuration
- Custom `.config/starship.toml` - Starship configuration

### CLI Tools (via Homebrew)
- Create or update the Brewfile:
  ```
  brew bundle dump --global --force
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
Install the following via Homebrew Cask or their official installers:
- Docker Desktop + k8s + kubectl
- VSCode (Enable settings sync with GitHub, install code command to PATH)
- Ghostty
- Chrome
- MongoDB Compass
- Postman
- Notion
- Mermaid or PUML for diagrams
