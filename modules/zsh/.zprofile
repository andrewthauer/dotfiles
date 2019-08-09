#!/usr/bin/env zsh
#
# Executes commands at login pre-zshrc
#

# Dotfiles dir
export DOTFILES_DIR="${HOME}/.dotfiles"

# Load common shell env
source "${DOTFILES_DIR}/env.sh"

# Zsh home directory
ZDOTDIR="${ZDOTDIR:-$HOME}"

# Ensure path arrays do not contain duplicates
typeset -gU cdpath fpath mailpath path

# Set the list of directories that Zsh searches for programs
path=(
  $path
  ${DOTFILES_BIN_DIR}
)

# Set the function path
fpath=(
  $fpath
  ${DOTFILES_ZFUNC_DIR}
)

# Load local zprofile (if exists)
if [[ -f "${HOME}/.zprofile.local" ]]; then
  source "${HOME}/.zprofile.local"
fi
