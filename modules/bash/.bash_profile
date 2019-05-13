#!/usr/bin/env bash
#
# Excuted by bash at login pre-bash
#

# Common dotfiles env setup
export DOTFILES_DIR="${HOME}/.dotfiles"
source "${DOTFILES_DIR}/env.sh"

# Load common shell environment
source "${DOTFILES_MOD_DIR}/shell/environment.sh"

# Load the local .bash_profile file
if [[ -f "$HOME/.bash_profile.local" ]]; then
  source "$HOME/.bash_profile.local"
fi
