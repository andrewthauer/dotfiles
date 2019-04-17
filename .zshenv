#!/usr/bin/env zsh
#
# Defines environment variables
#

# Zsh home directory
ZDOTDIR="${ZDOTDIR:-$HOME}"

# Dotfiles directory
export DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

# Load common shell environment
source "${DOTFILES_DIR}/shell/environment.sh"

# Ensure path arrays do not contain duplicates
typeset -gU cdpath fpath mailpath path

# Set the list of directories that Zsh searches for programs
path=(
  /usr/local/{bin,sbin}
  $path
  ${DOTFILES_DIR}/{bin,local/bin}
)

# Set the function path
fpath=(
  $fpath
  ${DOTFILES_DIR}/bin
)

# Load ~/.zshenv.local
if [[ -f "${HOME}/.zshenv.local" ]]; then
  source "${HOME}/.zshenv.local"
fi
