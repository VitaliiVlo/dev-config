# .zprofile - Login shell config (runs once at login)
# Contains: environment variables, PATH modifications
# See .zshrc for interactive shell config (aliases, completions, prompt)

BREW_PREFIX="${BREW_PREFIX:-/opt/homebrew}"
eval "$($BREW_PREFIX/bin/brew shellenv)"

# Core
export EDITOR="code --wait"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# Go: only what Go doesn't provide by default
export GOPRIVATE="github.com/vitalii-vlo/*"
export PATH="$HOME/go/bin:$PATH"
