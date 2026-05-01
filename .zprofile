BREW_PREFIX="${BREW_PREFIX:-/opt/homebrew}"
eval "$($BREW_PREFIX/bin/brew shellenv)"

# Core
export EDITOR="code --wait"
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/ripgreprc"

# Go
export GOPRIVATE="github.com/vitalii-vlo/*"
export PATH="$HOME/go/bin:$PATH"

# uv (global Python CLI tools via `uv tool install`)
export PATH="$HOME/.local/bin:$PATH"

# OrbStack
ORBSTACK_INIT="$HOME/.orbstack/shell/init.zsh"
if [[ -f "$ORBSTACK_INIT" ]]; then
  source "$ORBSTACK_INIT"
fi
