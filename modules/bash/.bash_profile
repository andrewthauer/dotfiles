#!/usr/bin/env bash
#
# Excuted by bash at login pre-bash
#

# Dotfiles dir
export DOTFILES_DIR="${HOME}/.dotfiles"

# Load common shell environment
source "${DOTFILES_DIR}/env"

# Load the local .bash_profile file
if [[ -f "$HOME/.bash_profile.local" ]]; then
  source "$HOME/.bash_profile.local"
fi
