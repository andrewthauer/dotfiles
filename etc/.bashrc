#!/usr/bin/env bash
#
# Executes at the start of an interactive session
#

# If not running interactively, don't do anything
[[ -z "$PS1" ]] && return

# Load the ~/.bash_profile if has not been loaded
if [[ -f "${HOME}/.bash_profile" && -z $BASH_PROFILE_LOADED ]]; then
  BASH_RC_LOADED=true
  source "${HOME}/.bash_profile"
  unset BASH_RC_LOADED
fi

# Source bash core scripts
source_files_in $XDG_CONFIG_HOME/bash/init.d/*.sh

# Source common interactive shell scripts
source_files_in $XDG_CONFIG_HOME/shell.d/*.sh
