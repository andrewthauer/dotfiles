#!/usr/bin/env zsh
#
# Executes commands at login pre-zshrc
#

# Set the list of directories that Zsh searches for programs
path=(
  ~/.local/bin
  ${DOTFILES_DIR}/bin
  $path
)

# Set the function path
fpath=(
  ~/.zsh/functions
  $fpath
)

# Load local profile (if exists)
if [[ -f "${HOME}/.zprofile.local" ]]; then
  source "${HOME}/.zprofile.local"
elif [[ -f "${HOME}/.profile.local" ]]; then
  source "${HOME}/.profile.local"
fi
