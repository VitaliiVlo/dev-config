eval "$(/opt/homebrew/bin/brew shellenv)"

# Core
export EDITOR="code --wait"

# Python env
export PATH="$(brew --prefix python@3.14)/libexec/bin:$PATH"

# Go env
export GOROOT="$(brew --prefix go@1.25)/libexec"
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export GOPRIVATE="github.com/vitalii-vlo/*"
export PATH="$GOBIN:$GOROOT/bin:$PATH"
