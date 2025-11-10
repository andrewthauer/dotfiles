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

# XDG configuration
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_BIN_HOME="${XDG_BIN_HOME:-$HOME/.local/bin}"

# Ensure the xdg data directory exists
if [ ! -d "${XDG_DATA_HOME}/bash" ]; then
  mkdir -p "${XDG_DATA_HOME}/bash"
fi

# Configure history file location
HISTFILE="${XDG_DATA_HOME}/bash/history"

# Check for custom dotfiles home
if [ -f "${XDG_CONFIG_HOME}/dotfiles-home" ]; then
  DOTFILES_HOME="${DOTFILES_HOME:-$(cat "${XDG_CONFIG_HOME}/dotfiles-home")}"
fi

# Dotfiles initialization
export DOTFILES_HOME="${DOTFILES_HOME:-${HOME}/.dotfiles}"

# shellcheck source=../../lib/init.sh disable=SC1091
source "${DOTFILES_HOME}/lib/init.sh"

# Export all environment files
if [ -d "${XDG_CONFIG_HOME}/environment.d" ]; then
  export_env_files_in "${XDG_CONFIG_HOME}"/environment.d/*.conf
fi

# Load profile files into environment
if [ -d "${XDG_CONFIG_HOME}/profile.d" ]; then
  source_files_in "${XDG_CONFIG_HOME}"/profile.d/*
fi

# Source the ~/.bashrc file
if [ -f "${HOME}/.bashrc" ] && [ -z "$BASH_RC_LOADED" ]; then
  # shellcheck disable=SC2034
  BASH_PROFILE_LOADED=true
  # shellcheck disable=SC1090,SC1091
  source "${HOME}/.bashrc"
  unset BASH_PROFILE_LOADED
fi
