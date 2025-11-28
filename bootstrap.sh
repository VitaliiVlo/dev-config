#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Resolve the directory where the script is located
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Creating symbolic links from $DOTFILES_DIR to $HOME..."

# Create symbolic links for configuration files
ln -sf "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
ln -sf "$DOTFILES_DIR/.gitignore_global" "$HOME/.gitignore_global"

ln -sf "$DOTFILES_DIR/.zprofile" "$HOME/.zprofile"
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

ln -sf "$DOTFILES_DIR/.Brewfile" "$HOME/.Brewfile"

mkdir -p "$HOME/.config/lsd"
ln -sf "$DOTFILES_DIR/.config/lsd/config.yaml" "$HOME/.config/lsd/config.yaml"

mkdir -p "$HOME/.config"
ln -sf "$DOTFILES_DIR/.config/starship.toml" "$HOME/.config/starship.toml"

mkdir -p "$HOME/.config/ghostty"
ln -sf "$DOTFILES_DIR/.config/ghostty/config" "$HOME/.config/ghostty/config"

mkdir -p "$HOME/.config/bat"
ln -sf "$DOTFILES_DIR/.config/bat/config" "$HOME/.config/bat/config"

VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"
ln -sf "$DOTFILES_DIR/.config/Code/User/settings.json" "$VSCODE_USER_DIR/settings.json"

echo "✅ Symbolic links created successfully!"
