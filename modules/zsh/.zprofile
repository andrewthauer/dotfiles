#!/usr/bin/env zsh
#
# Executes commands at login pre-zshrc
#

# Load common shell profile
source "${DOTFILES_MODULES_DIR}/shared/profile.sh"

# Load local zprofile (if exists)
if [[ -f "${HOME}/.zprofile.local" ]]; then
  source "${HOME}/.zprofile.local"
fi
