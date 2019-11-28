#!/usr/bin/env zsh
#
# Bootstrap ~/.zshrc file to xdg config
#

# Zsh home directory
ZDOTDIR="${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}"

# Load the zshenv
source "${ZDOTDIR}/.zshrc"
