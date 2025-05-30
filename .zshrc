# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt append_history
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt hist_verify

# Specific options
setopt globdots
setopt correct

# Keybindings
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# Aliases
alias ll='ls -lah'
alias python='python3'
alias pip='pip3'
alias tf='terraform'
alias kk='kubectl'
alias c='clear'

# Advanced aliases
if command -v bat &>/dev/null; then alias cat='bat'; fi
if command -v lsd &>/dev/null; then alias ls='lsd'; fi

BREW_PREFIX=$(brew --prefix)

# docker completions
DOCKER_COMP_PATH="${HOME}/.docker/completions"
if [ -d "$DOCKER_COMP_PATH" ]; then
  FPATH="$DOCKER_COMP_PATH:$FPATH"
fi

# zsh-completions
ZSH_COMP_PATH="$BREW_PREFIX/share/zsh-completions"
if [ -d "$ZSH_COMP_PATH" ]; then
  FPATH="$ZSH_COMP_PATH:$FPATH"
fi

# Enable completion
autoload -Uz compinit
compinit

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select

# zsh-autosuggestions
ZSH_AS_PATH="$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
if [ -f "$ZSH_AS_PATH" ]; then
  source "$ZSH_AS_PATH"
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
fi

# fzf key bindings and fuzzy completion
if command -v fzf &>/dev/null; then
  eval "$(fzf --zsh)"
fi

# Starship prompt
if command -v starship &>/dev/null; then
  eval "$(starship init zsh)"
fi

# zsh-syntax-highlighting
ZSH_SH_PATH="$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
if [ -f "$ZSH_SH_PATH" ]; then
  source "$ZSH_SH_PATH"
fi
