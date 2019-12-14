#!/usr/bin/env bash
#
# Excuted by bash at login pre-bash
#

# The current shell type
export CURRENT_SHELL="bash"

# XDG configuration
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

# Load common shell env
source "${XDG_CONFIG_HOME}/environment"

# Load the common shell login shell profile
if shopt -q login_shell; then
  source "${XDG_CONFIG_HOME}/profile"
fi

# Ensure the xdg data directory exists
[[ ! -d "${XDG_DATA_HOME}/bash" ]] && mkdir -p "${XDG_DATA_HOME}/bash"

# Source the ~/.bashrc file
if [[ -f "${HOME}/.bashrc" && -z $BASH_RC_LOADED ]]; then
  BASH_PROFILE_LOADED=true
  source "${HOME}/.bashrc"
  unset BASH_PROFILE_LOADED
fi
