#!/usr/bin/env zsh
#
# Defines zsh environment
#

# Dotfiles dir
export DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

# Load common shell env
source "${DOTFILES_DIR}/.env"

# Zsh home directory
ZDOTDIR="${ZDOTDIR:-$HOME}"

# Zsh cache directory
ZSH_CACHE_DIR="${ZSH_CACHE_DIR:-$HOME/.zsh/cache}"

# Ensure path arrays do not contain duplicates
typeset -gU cdpath fpath mailpath path

# Set the list of directories that Zsh searches for programs
path=(
  $path
  ${DOTFILES_DIR}/bin
)

# Set the function path
fpath=(
  "${HOME}/.zsh/functions"
  $fpath
)

# Load local zshenv (if exists)
if [[ -f "${HOME}/.zshenv.local" ]]; then
  source "${HOME}/.zshenv.local"
fi
