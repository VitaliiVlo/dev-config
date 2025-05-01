# Enable command auto-correction and better completion
autoload -Uz compinit promptinit
compinit
promptinit

# Improve completions
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Prompt style
PROMPT='%F{green}%n%f:%F{yellow}%~%f$ '

# Enable aliases
alias ll='ls -lah'
# alias gs='git status'
# alias ga='git add'
# alias gc='git commit'
# alias gp='git push'
# alias dcu='docker-compose up'
# alias dcd='docker-compose down'
alias python='python3'
alias pip='pip3'
alias tf='terraform'
alias k='kubectl'

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt append_history
setopt hist_ignore_dups
setopt share_history
setopt inc_append_history
setopt hist_verify

# Use bat if available for better cat
if command -v bat &> /dev/null; then
  alias cat='bat'
fi

# Use lsd if available for better ls
if command -v lsd &> /dev/null; then
  alias ls='lsd'
fi
