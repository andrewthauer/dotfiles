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

# Common aliases
source "${DOTFILES_DIR}/config/shared/aliases.sh"

# Load plugin modules
source "${DOTFILES_DIR}/modules/asdf/init.sh"
source "${DOTFILES_DIR}/modules/fasd/init.sh"
source "${DOTFILES_DIR}/modules/node/init.sh"
source "${DOTFILES_DIR}/modules/python/init.sh"
source "${DOTFILES_DIR}/modules/ruby/init.sh"
source "${DOTFILES_DIR}/modules/ssh/init.sh"
source "${DOTFILES_DIR}/modules/utility/init.sh"

# Aliases
source "${DOTFILES_DIR}/modules/docker/aliases.sh"
source "${DOTFILES_DIR}/modules/git/aliases.sh"

# Load the local .bashrc file
if [[ -f "$HOME/.bashrc.local" ]]; then
  source "$HOME/.bashrc.local"
fi
