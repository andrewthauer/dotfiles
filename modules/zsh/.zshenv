#!/usr/bin/env zsh
#
# Defines zsh environment
#

# Zsh home directory
ZDOTDIR="${ZDOTDIR:-$HOME}"

# Load common shell environment
export DOTFILES_DIR="${HOME}/.dotfiles"
source "${DOTFILES_DIR}/env.sh"

# Ensure path arrays do not contain duplicates
typeset -gU cdpath fpath mailpath path

# Set the list of directories that Zsh searches for programs
path=(
  $path
  ${DOTFILES_DIR}/{bin,local/bin}
)

# Set the function path
fpath=(
  $fpath
  ${DOTFILES_BIN_DIR}
  ${DOTFILES_ZFUNC_DIR}
)

# Load ~/.zshenv.local
if [[ -f "${HOME}/.zshenv.local" ]]; then
  source "${HOME}/.zshenv.local"
fi
