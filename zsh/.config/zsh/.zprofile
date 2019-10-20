#!/usr/bin/env zsh
#
# Executes commands at login pre-zshrc
#

# Ensure the xdg data & cache directories exist
[[ ! -d "${XDG_DATA_HOME}/zsh" ]] && mkdir -p "${XDG_DATA_HOME}/zsh"
[[ ! -d "${XDG_CACHE_HOME}/zsh" ]] && mkdir -p "${XDG_CACHE_HOME}/zsh"

# Load local profile (if exists)
if [[ -f "${XDG_CONFIG_HOME}/zsh/.zprofile.local" ]]; then
  source "${XDG_CONFIG_HOME}/zsh/.zprofile.local"
fi
