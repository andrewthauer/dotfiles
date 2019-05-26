#!/usr/bin/env bash
#
# Executes commands at the start of an interactive session
#

# Load the ~/.bash_profile if it exists
if [[ -f "${HOME}/.bash_profile" ]]; then
  source "${HOME}/.bash_profile"
fi

# Bash setup
source "${DOTFILES_MODULES_DIR}/bash/completion.sh"
source "${DOTFILES_MODULES_DIR}/bash/prompt.sh"

# Common shell config & modules
source "${DOTFILES_MODULES_DIR}/init.sh"

# Load the local .bashrc file
if [[ -f "$HOME/.bashrc.local" ]]; then
  source "$HOME/.bashrc.local"
fi
