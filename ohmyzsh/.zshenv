#!/usr/bin/env zsh
#
# Bootstrap ~/.zshenv file to xdg config
#

# XDG configuration
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

# The current shell type
export CURRENT_SHELL="zsh"

# Load common shell env
source "${XDG_CONFIG_HOME}/environment"

# Disable shell sessions
SHELL_SESSIONS_DISABLE=1
