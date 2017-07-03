#!/usr/bin/env zsh
#
# Executes commands at the start of an interactive session
#

# Enable to profile startup time (then run zprof)
# zmodload zsh/zprof

if [[ -f "$ZPLUG_HOME/init.zsh" ]]; then
  # Initialize zplug
  source $ZPLUG_HOME/init.zsh

  # NOTE: This adds load time
  # Install plugins if there are plugins that have not been installed
  # if ! zplug check --verbose; then
  #   printf "Install? [y/N]: "
  #   if read -q; then
  #     echo; zplug install
  #   fi
  # fi

  # Load zplug
  zplug load $ZPLUG_LOAD_OPTIONS
fi

# Load the local zsh file
if [[ -f "$HOME/.zshrc.local" ]]; then
  source "$HOME/.zshrc.local"
fi
