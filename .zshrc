# .zshrc - Interactive shell config (runs for each new terminal)
# Contains: aliases, completions, keybindings, prompt
# See .zprofile for login shell config (environment variables, PATH)

BREW_PREFIX="${BREW_PREFIX:-/opt/homebrew}"

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt append_history
setopt share_history
setopt hist_ignore_all_dups
setopt hist_find_no_dups
setopt hist_verify
setopt hist_reduce_blanks
setopt hist_ignore_space

# Specific options
setopt globdots
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups

# Keybindings
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# Aliases
alias python='python3'
alias pip='pip3'
alias tf='terraform'
alias kk='kubectl'
alias c='clear'
alias kctx='kubectl config current-context'
alias grep='grep --color=auto'

# Advanced aliases
if command -v bat &>/dev/null; then alias cat='bat'; fi

if command -v rg &>/dev/null; then
  export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
fi

# fd: show hidden, follow symlinks, exclude common noise (no config file support)
# Defined outside conditional so fzf block can reference it
_FD_OPTS="--hidden --follow --strip-cwd-prefix --exclude .git --exclude node_modules --exclude .venv --exclude __pycache__ --exclude vendor"
if command -v fd &>/dev/null; then
  alias fd="fd $_FD_OPTS"
fi

# eza: shared options (defined outside conditional so fzf block can reference them)
_EZA_LIST_OPTS="-lagF --group-directories-first --git --time-style=relative --header --hyperlink --smart-group"
_EZA_TREE_OPTS="-aF --tree --level=2 --group-directories-first --git-ignore"
if command -v eza &>/dev/null; then
  alias ls='eza --group-directories-first'
  alias ll="eza $_EZA_LIST_OPTS"
  alias lt="eza $_EZA_TREE_OPTS"
  alias lr="eza $_EZA_LIST_OPTS --sort=modified --reverse"
else
  alias ll='ls -lah'
fi

# docker completions
DOCKER_COMP_PATH="${HOME}/.docker/completions"
if [[ -d "$DOCKER_COMP_PATH" ]]; then
  FPATH="$DOCKER_COMP_PATH:$FPATH"
fi

# zsh-completions
ZSH_COMP_PATH="$BREW_PREFIX/share/zsh-completions"
if [[ -d "$ZSH_COMP_PATH" ]]; then
  FPATH="$ZSH_COMP_PATH:$FPATH"
fi

# Enable completion
autoload -Uz compinit
compinit

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select

# zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
ZSH_AS_PATH="$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
if [[ -f "$ZSH_AS_PATH" ]]; then
  source "$ZSH_AS_PATH"
fi

# fzf key bindings and fuzzy completion
if command -v fzf &>/dev/null; then
  export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --border"
  export FZF_CTRL_R_OPTS="--no-preview --height=50%"
  # Use fd for fzf if available (faster, respects .gitignore)
  if command -v fd &>/dev/null; then
    export FZF_DEFAULT_COMMAND="fd --type f $_FD_OPTS"
    export FZF_CTRL_T_COMMAND="fd --type f $_FD_OPTS"
    export FZF_ALT_C_COMMAND="fd --type d $_FD_OPTS"
  fi
  export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range=:500 {} 2>/dev/null || cat {}'"
  export FZF_ALT_C_OPTS="--preview 'eza $_EZA_TREE_OPTS --color=always {} 2>/dev/null || ls -la {}'"
  eval "$(fzf --zsh)"
fi

# Zoxide (smarter cd)
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
fi

# Starship prompt
if command -v starship &>/dev/null; then
  eval "$(starship init zsh)"
fi

# zsh-syntax-highlighting
ZSH_SH_PATH="$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
if [[ -f "$ZSH_SH_PATH" ]]; then
  source "$ZSH_SH_PATH"
fi
