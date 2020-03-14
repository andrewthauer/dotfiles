#!/usr/bin/env zsh
#
# Executes commands at login pre-zshrc
#

# Completions file
export ZSH_COMPDUMP="${XDG_CACHE_HOME}/zsh/zcompdump"

# Ensure the xdg data & cache directories exist
[[ ! -d "${XDG_DATA_HOME}/zsh" ]] && mkdir -p "${XDG_DATA_HOME}/zsh"
[[ ! -d "${XDG_CACHE_HOME}/zsh" ]] && mkdir -p "${XDG_CACHE_HOME}/zsh"

# Load the common shell profile
source "${XDG_CONFIG_HOME}/profile"
