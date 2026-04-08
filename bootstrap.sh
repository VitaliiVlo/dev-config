#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -euo pipefail

# Resolve the directory where the script is located
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Creating symbolic links from $DOTFILES_DIR to $HOME..."

# Create symbolic links for configuration files
ln -sf "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
ln -sf "$DOTFILES_DIR/.gitignore_global" "$HOME/.gitignore_global"

ln -sf "$DOTFILES_DIR/.zprofile" "$HOME/.zprofile"
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

ln -sf "$DOTFILES_DIR/.Brewfile" "$HOME/.Brewfile"
ln -sf "$DOTFILES_DIR/.ripgreprc" "$HOME/.ripgreprc"

mkdir -p "$HOME/.config"
ln -sf "$DOTFILES_DIR/.config/starship.toml" "$HOME/.config/starship.toml"

mkdir -p "$HOME/.config/ghostty"
ln -sf "$DOTFILES_DIR/.config/ghostty/config" "$HOME/.config/ghostty/config"

mkdir -p "$HOME/.config/bat"
ln -sf "$DOTFILES_DIR/.config/bat/config" "$HOME/.config/bat/config"

mkdir -p "$HOME/.config/btop"
ln -sf "$DOTFILES_DIR/.config/btop/btop.conf" "$HOME/.config/btop/btop.conf"

mkdir -p "$HOME/.config/ccstatusline"
ln -sf "$DOTFILES_DIR/.config/ccstatusline/settings.json" "$HOME/.config/ccstatusline/settings.json"

mkdir -p "$HOME/.codex"
ln -sf "$DOTFILES_DIR/.codex/config.toml" "$HOME/.codex/config.toml"
ln -sf "$DOTFILES_DIR/.codex/AGENTS.md" "$HOME/.codex/AGENTS.md"

mkdir -p "$HOME/.claude"
ln -sf "$DOTFILES_DIR/.claude/settings.json" "$HOME/.claude/settings.json"
ln -sf "$DOTFILES_DIR/.claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"


VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"
mkdir -p "$VSCODE_USER_DIR"
ln -sf "$DOTFILES_DIR/.config/Code/User/settings.json" "$VSCODE_USER_DIR/settings.json"

echo "✅ Symbolic links created successfully!"
