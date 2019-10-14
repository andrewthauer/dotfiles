#!/usr/bin/env bash
#
# Excuted by bash at login pre-bash
#

# The current shell type
export CURRENT_SHELL="bash"

# Dotfiles dir
export DOTFILES_DIR="${HOME}/.dotfiles"

# Load common shell env
source "${DOTFILES_DIR}/profile"

# Load core utilities used by other scripts
source "${DOTFILES_DIR}/lib/init.sh"

# Append to path
prepend_path "${DOTFILES_DIR}/bin"
prepend_path "${HOME}/.local/bin"

# Ensure the xdg data directory exists
[[ ! -d "${XDG_DATA_HOME}/bash" ]] && mkdir -p "${XDG_DATA_HOME}/bash"

# Load local profile (if exists)
if [[ -f "${XDG_CONFIG_HOME}/bash/.bash_profile.local" ]]; then
  source "${XDG_CONFIG_HOME}/bash/.bash_profile.local"
fi

# Source the .bashrc file
BASH_PROFILE_LOADED=true
if [[ -f "${HOME}/.bashrc" && -z $BASH_RC_LOADED ]]; then
  source "${HOME}/.bashrc"
fi
unset BASH_PROFILE_LOADED
