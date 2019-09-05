#!/usr/bin/env bash
#
# Executes commands at the start of an interactive session
#

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Load the ~/.bash_profile if has not been loaded
BASH_RC_LOADED=true
if [[ -f "${HOME}/.bash_profile" && -z $BASH_PROFILE_LOADED ]]; then
  source "${HOME}/.bash_profile"
fi
unset BASH_RC_LOADED

# Load core utilities used by other scripts
source "${DOTFILES_DIR}/lib/init.sh"

# Source scripts
source_bash_scripts
source_shell_scripts

# Load the local .bashrc file
if [ -f "$HOME/.bashrc.local" ]; then
  source "$HOME/.bashrc.local"
fi
