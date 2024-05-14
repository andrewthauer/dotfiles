#!/usr/bin/env zsh
#
# Defines zsh environment & changes to use XGD directories
#

if [ -n "$DOTFILES_TRACE" ]; then
  echo "load: ~/.config/zsh/.zshenv"
  echo "path: ${PATH}"
fi

# The current shell type
export SHELL_TYPE="zsh"

# XDG configuration
# - https://wiki.archlinux.org/index.php/XDG_Base_Directory
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_BIN_HOME="${XDG_BIN_HOME:-$HOME/.local/bin}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# Ensure path arrays do not contain duplicates
typeset -gU cdpath fpath mailpath path

# Disable shell sessions
SHELL_SESSIONS_DISABLE=1

# Dotfiles initialization
export DOTFILES_DIR="${DOTFILES_DIR:-${HOME}/.dotfiles}"

# shellcheck source=../../../lib/init.sh
source "${DOTFILES_DIR}/lib/init.sh"
