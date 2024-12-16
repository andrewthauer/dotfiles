#!/usr/bin/env zsh
#
# Bootstrap ~/.zshenv file to xdg config
#

# Uncomment this to enable debug trace mode
# export DOTFILES_TRACE="1"

if [ -n "$DOTFILES_TRACE" ]; then
  echo "load: ~/.zshenv"
  echo "path: ${PATH}"
fi

# XDG configuration
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_BIN_HOME="${XDG_BIN_HOME:-$HOME/.local/bin}"

# Zsh home directory
ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

# Load the zshenv
source "${ZDOTDIR}/.zshenv"
