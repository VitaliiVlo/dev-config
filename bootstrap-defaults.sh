#!/bin/bash

set -euo pipefail

heading()  { printf "\n\033[1;34m%s\033[0m\n" "$*"; }
confirm()  { read -r -p "$1 [Y/n] " ans; [[ "${ans:-Y}" =~ ^[Yy]$ ]]; }

if confirm "Create ~/Projects folder?"; then
  mkdir -p "$HOME/Projects"
fi

if confirm "Move screenshots to ~/Screenshots (instead of Desktop)?"; then
  heading "→ Setting screenshot location…"
  mkdir -p "$HOME/Screenshots"
  defaults write com.apple.screencapture location       "$HOME/Screenshots"
  defaults write com.apple.screencapture show-thumbnail -bool   true
  defaults write com.apple.screencapture disable-shadow -bool   true
  defaults write com.apple.screencapture type           -string "png"
  killall SystemUIServer >/dev/null 2>&1 || true
fi

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
  defaults write com.apple.finder FXDefaultSearchScope            -string "SCcf"  # Search current folder
  defaults write com.apple.finder _FXSortFoldersFirst             -bool  true
  defaults write com.apple.finder _FXSortFoldersFirstOnDesktop    -bool  true
  defaults write com.apple.finder AppleShowAllFiles               -bool  true
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
  defaults write com.apple.desktopservices DSDontWriteUSBStores     -bool true
  killall Finder >/dev/null 2>&1 || true
fi

if confirm "Tweak Dock (autohide, no recents, minimize to app…)?"; then
  heading "→ Configuring Dock…"
  # Appearance
  defaults write com.apple.dock orientation             -string "bottom"
  defaults write com.apple.dock tilesize                -int    64
  defaults write com.apple.dock show-process-indicators -bool   true
  defaults write com.apple.dock show-recents            -bool   false
  # Behavior
  defaults write com.apple.dock autohide                -bool   true
  defaults write com.apple.dock autohide-delay          -float  0
  defaults write com.apple.dock autohide-time-modifier  -float  0.25
  defaults write com.apple.dock minimize-to-application -bool   true
  defaults write com.apple.dock mineffect               -string "genie"
  defaults write com.apple.dock launchanim              -bool   true
  # Mission Control & Spaces
  defaults write com.apple.dock mru-spaces              -bool   false
  defaults write com.apple.dock expose-group-apps       -bool   true
  # Hot corners (disabled)
  defaults write com.apple.dock wvous-tl-corner         -int    0
  defaults write com.apple.dock wvous-tr-corner         -int    0
  defaults write com.apple.dock wvous-bl-corner         -int    0
  defaults write com.apple.dock wvous-br-corner         -int    0
  killall Dock >/dev/null 2>&1 || true
fi

if confirm "System defaults (key repeat, scrolling, save dialogs)?"; then
  heading "→ Configuring system defaults…"
  defaults write NSGlobalDomain ApplePressAndHoldEnabled            -bool  false  # Key repeat instead of accent menu
  defaults write NSGlobalDomain com.apple.swipescrolldirection     -bool  true   # Natural scrolling
  defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud  -bool  false  # Save to disk by default
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode  -bool false
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool false
fi

heading "Finished processing selected defaults."
