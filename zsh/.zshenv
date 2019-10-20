#!/usr/bin/env zsh
#
# Bootstrap file move zsh to xdg config
#

# XDG configuration
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

# Zsh home directory
ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

# Load the zshenv
source $ZDOTDIR/.zshenv
