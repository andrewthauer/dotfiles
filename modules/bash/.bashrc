#!/usr/bin/env bash
#
# Executes at the start of an interactive session
#

if [ -n "$DOTFILES_TRACE" ]; then
  echo "load: ~/.bashrc"
  echo "path: ${PATH}" "path: ${PATH}"
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Load the ~/.bash_profile if has not been loaded
if [ -f "${HOME}/.bash_profile" ] && [ -z "$BASH_PROFILE_LOADED" ]; then
  # shellcheck disable=SC2034
  BASH_RC_LOADED=true
  # shellcheck disable=SC1090,SC1091
  source "${HOME}/.bash_profile"
  unset BASH_RC_LOADED
fi

# Source bash core scripts
source_files_in "${XDG_CONFIG_HOME}"/bash/init.d/*.sh

# Append bin directories to path
prepend_path "${DOTFILES_DIR}/bin"
prepend_path "${HOME}/.local/bin"
