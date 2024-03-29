#!/usr/bin/env bash
#
# Excuted by bash at login pre-bash
#

# Uncomment this to enable debug trace mode
# export DOTFILES_TRACE="1"

if [ -n "$DOTFILES_TRACE" ]; then
  echo "load: ~/.bash_profile"
  echo "path: ${PATH}"
fi

# The current shell type
export SHELL_TYPE="bash"

# XDG configuration
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

# Dotfiles initialization
export DOTFILES_DIR="${DOTFILES_DIR:-${HOME}/.dotfiles}"
# shellcheck source=../../lib/utils.sh disable=SC1091
source "${DOTFILES_DIR}/lib/utils.sh"

# Load profile files into environment
if [ -d "${XDG_CONFIG_HOME}/profile.d" ]; then
  source_files_in "${XDG_CONFIG_HOME}"/profile.d/*
fi

# Ensure the xdg data directory exists
[ ! -d "${XDG_DATA_HOME}/bash" ] && mkdir -p "${XDG_DATA_HOME}/bash"

# Source the ~/.bashrc file
if [ -f "${HOME}/.bashrc" ] && [ -z "$BASH_RC_LOADED" ]; then
  # shellcheck disable=SC2034
  BASH_PROFILE_LOADED=true
  # shellcheck disable=SC1090,SC1091
  source "${HOME}/.bashrc"
  unset BASH_PROFILE_LOADED
fi
