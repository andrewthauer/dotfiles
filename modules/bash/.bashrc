#!/usr/bin/env bash
#
# Executes at the start of an interactive session
#

if [ -n "$DOTFILES_TRACE" ]; then
  echo "load: ~/.bashrc"
  echo "path: ${PATH}" "path: ${PATH}"
fi

# If not running interactively or without a real TTY, skip interactive setup
# to avoid polluting stdout when bash is invoked with -i but no terminal attached
[[ -z "$PS1" || ! -t 1 ]] && return

# Load the ~/.bash_profile if has not been loaded
if [ -f "${HOME}/.bash_profile" ] && [ -z "$BASH_PROFILE_LOADED" ]; then
  # shellcheck disable=SC2034
  BASH_RC_LOADED=true
  # shellcheck disable=SC1090,SC1091
  source "${HOME}/.bash_profile"
  unset BASH_RC_LOADED
fi

# Append bin directories to path
prepend_path "${DOTFILES_HOME}/bin"
prepend_path "${HOME}/.local/bin"

# Source bash core scripts
source_files_in "${XDG_CONFIG_HOME}"/bash/init.d/*.bash
