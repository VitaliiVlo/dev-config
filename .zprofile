# .zprofile - Login shell config (runs once at login)
# Contains: environment variables, PATH modifications
# See .zshrc for interactive shell config (aliases, completions, prompt)

BREW_PREFIX="${BREW_PREFIX:-/opt/homebrew}"
eval "$($BREW_PREFIX/bin/brew shellenv)"

# Core
export EDITOR="code --wait"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# PATH order (highest priority first): $GOBIN → $GOROOT/bin → Python → Homebrew → system

# Python env
export PATH="$BREW_PREFIX/opt/python@3.14/libexec/bin:$PATH"

# Go env
export GOROOT="$BREW_PREFIX/opt/go@1.25/libexec"
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export GOPRIVATE="github.com/vitalii-vlo/*"
export PATH="$GOBIN:$GOROOT/bin:$PATH"
