# History
HISTFILE=~/.zsh_history
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
setopt correct
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups

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
alias kctx='kubectl config current-context'
alias grep='grep --color=auto'

# Advanced aliases
if command -v bat &>/dev/null; then alias cat='bat'; fi
if command -v lsd &>/dev/null; then alias ls='lsd'; fi

BREW_PREFIX="/opt/homebrew"

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
zstyle ':completion:*' menu select

# zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
ZSH_AS_PATH="$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
if [ -f "$ZSH_AS_PATH" ]; then
  source "$ZSH_AS_PATH"
fi

# fzf key bindings and fuzzy completion
if command -v fzf &>/dev/null; then
  export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --border"
  export FZF_CTRL_T_OPTS="--walker-skip .git,node_modules,__pycache__,.venv --preview '[[ -d {} ]] && lsd --tree --depth=2 --color=always {} || bat --color=always --style=numbers --line-range=:500 {}'"
  export FZF_ALT_C_OPTS="--preview 'lsd --tree --depth=2 --color=always {}'"
  export FZF_CTRL_R_OPTS="--no-preview --height=50%"
  source <(fzf --zsh)
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
