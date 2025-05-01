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
The following files are automatically symlinked by running `./setup_symlinks.sh`:
- Custom `.zprofile` - Shell environment variables
- Custom `.zshrc` - Shell configuration and aliases
- Custom `.gitconfig` - Git user and global settings
- Custom `.config/lsd/config.yaml` - LSD (LSDeluxe) configuration

### CLI Tools (via Homebrew)
```
brew install bat lsd k9s go@v.v
```
- **bat**: Better alternative to `cat` with syntax highlighting
- **lsd**: Modern alternative to `ls` with icons and colors
- **k9s**: Terminal UI for Kubernetes
- **Go**

### Applications
Install the following via Homebrew Cask or their official installers:
- Docker Desktop + k8s + kubectl
- VSCode (Enable settings sync with GitHub)
- iTerm2
- Chrome
- Mermaid or PUML for diagrams
