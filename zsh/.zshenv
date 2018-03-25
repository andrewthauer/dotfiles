#!/usr/bin/env zsh
#
# Defines environment variables
#

# Zsh home directory
export ZDOTDIR="${ZDOTDIR:-$HOME}"

# Dotfiles directory
export DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

# Ensure path arrays do not contain duplicates
typeset -gU cdpath fpath mailpath path

# Set the list of directories that Zsh searches for programs
path=(
  /usr/local/{bin,sbin}
  $path
  $DOTFILES_DIR/bin
)

# Set the function path
fpath=(
  $DOTFILES_DIR/functions
  $fpath
)

# Zplug settings (and custom local)
export ZPLUG_HOME="${ZPLUG_HOME:-$HOME/.zplug}"
export ZPLUG_LOADFILE="${DOTFILES_DIR}/zsh/zplug.zsh"
export ZPLUG_LOCAL_LOADFILE="${HOME}/.zplug.local"

# Load common shell environment
if [[ -f "${DOTFILES_DIR}/shell/config/environment.sh" ]]; then
  source "${DOTFILES_DIR}/shell/config/environment.sh"
fi

# Load ~/.zshenv.local
if [[ -f "${HOME}/.zshenv.local" ]]; then
  source "${HOME}/.zshenv.local"
fi
