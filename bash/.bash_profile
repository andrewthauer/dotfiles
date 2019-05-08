#!/usr/bin/env bash
#
# Excuted by bash at login pre-bash
#

# Dotfiles directory
export DOTFILES_DIR="${HOME}/.dotfiles"

# Load common shell environment
source "${DOTFILES_DIR}/shell/environment.sh"

# Load the local .bash_profile file
if [[ -f "$HOME/.bash_profile.local" ]]; then
  source "$HOME/.bash_profile.local"
fi
