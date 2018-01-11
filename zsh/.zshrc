#!/usr/bin/env zsh
#
# Executes commands at the start of an interactive session
#

if [[ -f "$ZPLUG_HOME/init.zsh" ]]; then
  # Initialize zplug
  source $ZPLUG_HOME/init.zsh

  # Load zplug
  zplug load $ZPLUG_LOAD_OPTIONS
fi

# Load the local zsh file
if [[ -f "$HOME/.zshrc.local" ]]; then
  source "$HOME/.zshrc.local"
fi
