#!/usr/bin/env bash
#
# Excuted by bash at login pre-bash
#

# Already loaded flag
BASH_PROFILE_LOADED=true

# Dotfiles dir
export DOTFILES_DIR="${HOME}/.dotfiles"

# Load common shell environment
source "${DOTFILES_DIR}/env.sh"

# Source the .bashrc file
if [[ -f "$HOME/.bashrc" ]]; then
  source "${HOME}/.bashrc"
fi

# Load the local .bash_profile file
if [[ -f "$HOME/.bash_profile.local" ]]; then
  source "$HOME/.bash_profile.local"
fi
