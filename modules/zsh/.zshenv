#!/usr/bin/env zsh
#
# Bootstrap ~/.zshenv file to xdg config
#

# Uncomment this to enable debug trace mode
# export DOTFIL`ES_TRACE="1"

if [ -n "$DOTFILES_TRACE" ]; then
  echo "load: ~/.zshenv"
  [ -n "$DOTFILES_TRACE_PATH" ] && echo "path: ${PATH}"
fi

# XDG configuration
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

# Zsh home directory
ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

# Load the zshenv
source "${ZDOTDIR}/.zshenv"
