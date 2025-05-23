# ─────────────── Core setup ───────────────
autoload -Uz compinit promptinit
compinit
promptinit

# ──────── Improved completions/UI ─────────
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# ───────────── Prompt style ───────────────
PROMPT='%F{green}%n%f:%F{yellow}%~%f$ '

# ──────────── Editor choice ───────────────
export EDITOR='code --wait'

# ───────────── Aliases ────────────────────
alias ll='ls -lah'
alias python='python3'
alias pip='pip3'
alias tf='terraform'
alias kk='kubectl'

# ─────────── Fancy replacements ────────────
if command -v bat &>/dev/null; then alias cat='bat'; fi
if command -v lsd &>/dev/null; then alias ls='lsd'; fi

# ───────────── History setup ──────────────
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt append_history
setopt hist_ignore_dups
setopt share_history
setopt inc_append_history
setopt hist_verify
setopt correct
# setopt correct_all
# setopt autocd

# ─── Homebrew-installed Zsh plugins ───
BREW_PREFIX=$(brew --prefix)

# zsh-syntax-highlighting (live syntax coloring)
ZSHL_PATH="$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
if [ -f "$ZSHL_PATH" ]; then
  source "$ZSHL_PATH"
fi

# zsh-history-substring-search (case-insensitive, substring search)
HSS_PATH="$BREW_PREFIX/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
if [ -f "$HSS_PATH" ]; then
  source "$HSS_PATH"
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
fi

# zsh-autosuggestions (inline suggestions from history)
ZAS_PATH="$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
if [ -f "$ZAS_PATH" ]; then
  source "$ZAS_PATH"
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
fi
