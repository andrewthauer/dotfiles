#!/usr/bin/env bash
# Executes commands at the start of an interactive session

#
# Windows Bash
#

# If not running interactively (powershell), don't do anything
[ -z "$PS1" ] && return

# Launch zsh (for windows bash)
# NOTE: It may be possible to remove this post windows 10 creators update
if [ $(uname -r | sed -n 's/.*\( *Microsoft *\).*/\1/p') ]; then
  exec zsh
fi

#
# Configuration
#

# Load the ~/.bash_profile if it exists
if [[ -f "${HOME}/.bash_profile" ]]; then
  source "${HOME}/.bash_profile"
fi

# Prompt
# PS1=

# Common shell files
source "${DOTFILES_DIR}/shell/aliases.sh"
source "${DOTFILES_DIR}/shell/init.sh"

# Load the local .bashrc file
if [[ -f "$HOME/.bashrc.local" ]]; then
  source "$HOME/.bashrc.local"
fi
