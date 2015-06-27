#!/usr/bin/env bash

# -----------------------------------------------
# OSX Setup script
#

# Prompt for admin password upfront
sudo -v

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
