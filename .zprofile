eval "$(/opt/homebrew/bin/brew shellenv)"

# Core
export EDITOR="code --wait"

# Go env
export GOROOT="/opt/homebrew/opt/go@1.25/libexec"
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export GOPRIVATE="github.com/vitalii-vlo/*"
export PATH="$GOBIN:$GOROOT/bin:$PATH"
