#!/usr/bin/env zsh
#
# Executes commands at login pre-zshrc
#

# Load local profile (if exists)
if [ -f "${HOME}/.profile.local" ]; then
  source "${HOME}/.profile.local"
elif [ -f "${HOME}/.zprofile.local" ]; then
  source "${HOME}/.zprofile.local"
fi
