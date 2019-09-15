#!/usr/bin/env bash
#
# Excuted by bash at login pre-bash
#

# Dotfiles dir
export DOTFILES_DIR="${HOME}/.dotfiles"

# Load common shell env
source "${DOTFILES_DIR}/.env"

# Load local profile (if exists)
if [[ -f "${HOME}/.profile.local" ]]; then
  source "${HOME}/.profile.local"
elif [[ -f "$HOME/.bash_profile.local" ]]; then
  source "$HOME/.bash_profile.local"
fi

# Source the .bashrc file
BASH_PROFILE_LOADED=true
if [[ -f "$HOME/.bashrc" && -z $BASH_RC_LOADED ]]; then
  source "${HOME}/.bashrc"
fi
unset BASH_PROFILE_LOADED
