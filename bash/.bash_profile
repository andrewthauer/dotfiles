#!/usr/bin/env bash
#
# Excuted by bash at login pre-bash
#

# Dotfiles directory
export DOTFILES_DIR="${HOME}/.dotfiles"

# Load common shell environment
if [[ -f "${DOTFILES_DIR}/shell/config/environment.sh" ]]; then
  source "${DOTFILES_DIR}/shell/config/environment.sh"
fi
