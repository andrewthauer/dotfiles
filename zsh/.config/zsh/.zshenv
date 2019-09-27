#!/usr/bin/env zsh
#
# Defines zsh environment & changes to use XGD directories
#

# Dotfiles dir
export DOTFILES_DIR="${DOTFILES_DIR:=${HOME}/.dotfiles}"

# Load common shell env
source "${DOTFILES_DIR}/.profile"

# Zsh home directory
ZDOTDIR="${ZDOTDIR:=${XDG_CONFIG_HOME}/zsh}"

# Ensure path arrays do not contain duplicates
typeset -gU cdpath fpath mailpath path

# Load local zshenv (if exists)
if [[ -f "${XDG_CONFIG_HOME}/zsh/.zshenv.local" ]]; then
  source "${XDG_CONFIG_HOME}/zsh/.zshenv.local"
fi
