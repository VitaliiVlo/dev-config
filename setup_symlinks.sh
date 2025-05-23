#!/bin/bash

# Script to create symbolic links from dev-config to home directory
# Created: May 1, 2025

set -e # Exit immediately if a command exits with a non-zero status

# Resolve the directory where the script is located
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Creating symbolic links from $DOTFILES_DIR to $HOME..."

# Create symbolic links for individual files
ln -sf "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
ln -sf "$DOTFILES_DIR/.gitignore_global" "$HOME/.gitignore_global"
ln -sf "$DOTFILES_DIR/.zprofile" "$HOME/.zprofile"
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

# Ensure ~/.config/lsd directory exists
mkdir -p "$HOME/.config/lsd"
ln -sf "$DOTFILES_DIR/.config/lsd/config.yaml" "$HOME/.config/lsd/config.yaml"

# Ensure ~/.config/ghostty directory exists
mkdir -p "$HOME/.config/ghostty"
ln -sf "$DOTFILES_DIR/.config/ghostty/config" "$HOME/.config/ghostty/config"

echo "✅ Symbolic links created successfully!"
