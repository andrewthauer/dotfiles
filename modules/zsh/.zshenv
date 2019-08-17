#!/usr/bin/env zsh
#
# Defines zsh environment
#

# Dotfiles dir
export DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

# Load common shell env
source "${DOTFILES_DIR}/modules/shared/env.sh"

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

# Load local zshenv (if exists)
if [[ -f "${HOME}/.zshenv.local" ]]; then
  source "${HOME}/.zshenv.local"
fi
