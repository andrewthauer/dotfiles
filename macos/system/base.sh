#!/usr/bin/env sh
#
# Base macOS boostrap settings
#

# Prompt for sudo up front
sudo -v

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Install xcode command line tools
xcode-select --install
