#!/bin/bash

set -euo pipefail

heading()  { printf "\n\033[1;34m%s\033[0m\n" "$*"; }
confirm()  { read -r -p "$1 [Y/n] " ans; [[ "${ans:-Y}" =~ ^[Yy]$ ]]; }

if confirm "Apply Finder tweaks (List view, path bar, show extensions…)?"; then
  heading "→ Configuring Finder…"
  defaults write com.apple.finder FXPreferredViewStyle            -string "Nlsv"  # List view
  defaults write com.apple.finder ShowPathbar                     -bool  true
  defaults write com.apple.finder ShowStatusBar                   -bool  true
  defaults write com.apple.finder AppleShowAllExtensions          -bool  true
  defaults write com.apple.finder ShowHardDrivesOnDesktop         -bool  false
  defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool  true
  defaults write com.apple.finder ShowMountedServersOnDesktop     -bool  true
  defaults write com.apple.finder ShowRemovableMediaOnDesktop     -bool  true
  defaults write com.apple.finder FXEnableExtensionChangeWarning  -bool  true
  defaults write com.apple.finder QLEnableTextSelection           -bool  true
  # defaults write com.apple.Finder  AppleShowAllFiles              -bool  true
  killall Finder >/dev/null 2>&1 || true
fi

if confirm "Clean up .DS_Store?"; then
  heading "→ Cleaning up .DS_Store…"
  # || true: Some .DS_Store files in ~/Library are protected; skip them silently
  # Exclude directories that are large and rarely need cleanup
  find "$HOME" -xdev -name .DS_Store \
    -not -path "*/Library/Caches/*" \
    -not -path "*/.Trash/*" \
    -not -path "*/node_modules/*" \
    -not -path "*/.venv/*" \
    -not -path "*/venv/*" \
    -delete 2>/dev/null || true
  killall Finder >/dev/null 2>&1 || true
fi

if confirm "Tweak Dock (no recents, faster animation…)?"; then
  heading "→ Configuring Dock…"
  defaults write com.apple.dock autohide               -bool  false
  defaults write com.apple.dock autohide-delay         -float 0
  defaults write com.apple.dock autohide-time-modifier -float 0.25
  defaults write com.apple.dock show-recents           -bool  false
  defaults write com.apple.dock tilesize               -int   64
  killall Dock >/dev/null 2>&1 || true
fi

if confirm "Move screenshots to ~/Screenshots (instead of Desktop)?"; then
  heading "→ Setting screenshot location…"
  mkdir -p "$HOME/Screenshots"
  defaults write com.apple.screencapture location "$HOME/Screenshots"
  killall SystemUIServer >/dev/null 2>&1 || true
fi

heading "🎉  All selected defaults applied!"
