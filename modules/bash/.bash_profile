#!/usr/bin/env bash
#
# Excuted by bash at login pre-bash
#

# Already loaded flag
BASH_PROFILE_LOADED=true

# Dotfiles dir
export DOTFILES_DIR="${HOME}/.dotfiles"

# Load common shell env & profile
source "${DOTFILES_DIR}/modules/shared/env.sh"
source "${DOTFILES_DIR}/modules/shared/profile.sh"

# Source the .bashrc file
if [[ -f "$HOME/.bashrc" && -z $BASH_RC_LOADED ]]; then
  source "${HOME}/.bashrc"
fi

# Load the local .bash_profile file
if [[ -f "$HOME/.bash_profile.local" ]]; then
  source "$HOME/.bash_profile.local"
fi
