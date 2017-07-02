#!/usr/bin/env sh
#
# Setup macOS System
#

# Exit on error or unset variable
set -o nounset
set -o errexit

# Current directory
local dir="$(dirname "$0")"

# Setup macOS defaults
# source "$dir/macos-defaults.sh"

# Prompt for sudo up front
sudo -v

# Set ZSH as Default Shell
$ chsh -s $(which zsh)

# create a zshrc file
if [ ! -f "$HOME/.zshrc" ]; then
  touch "$HOME/.zshrc"
fi

# Reload shell
source ~/.zshrc

# Install Homebrew & packages
source "$dir/brews.zsh"

# Setup terminal
# TODO: Setup .terminal file
