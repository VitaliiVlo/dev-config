BREW_PREFIX="/opt/homebrew"
eval "$($BREW_PREFIX/bin/brew shellenv)"

# Core
export EDITOR="code --wait"

# Python env
export PATH="$BREW_PREFIX/opt/python@3.14/libexec/bin:$PATH"

# Go env
export GOROOT="$BREW_PREFIX/opt/go@1.25/libexec"
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export GOPRIVATE="github.com/vitalii-vlo/*"
export PATH="$GOBIN:$GOROOT/bin:$PATH"
