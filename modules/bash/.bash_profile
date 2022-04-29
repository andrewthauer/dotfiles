#!/usr/bin/env bash
#
# Excuted by bash at login pre-bash
#

# The current shell type
export CURRENT_SHELL="bash"

# XDG configuration
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

# Load common shell env
# shellcheck disable=SC1091
source "${XDG_CONFIG_HOME}/environment"

# Load the common shell login shell profile
# shellcheck disable=SC1091
source "${XDG_CONFIG_HOME}/profile"

# Ensure the xdg data directory exists
[[ ! -d "${XDG_DATA_HOME}/bash" ]] && mkdir -p "${XDG_DATA_HOME}/bash"

# Source the ~/.bashrc file
if [[ -f "${HOME}/.bashrc" && -z $BASH_RC_LOADED ]]; then
  # shellcheck disable=SC2034
  BASH_PROFILE_LOADED=true
  # shellcheck disable=SC1090
  source "${HOME}/.bashrc"
  unset BASH_PROFILE_LOADED
fi
