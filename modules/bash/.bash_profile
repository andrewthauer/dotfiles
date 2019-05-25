#!/usr/bin/env bash
#
# Excuted by bash at login pre-bash
#

# Load common shell environment
export DOTFILES_DIR="${HOME}/.dotfiles"
source "${DOTFILES_DIR}/env.sh"

# Load the local .bash_profile file
if [[ -f "$HOME/.bash_profile.local" ]]; then
  source "$HOME/.bash_profile.local"
fi
