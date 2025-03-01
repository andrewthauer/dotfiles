#!/usr/bin/env zsh
#
# Defines zsh environment & changes to use XGD directories
#

if [ -n "$DOTFILES_TRACE" ]; then
  echo "load: ~/.config/zsh/.zshenv"
  echo "path: ${PATH}"
fi

# Ensure path arrays do not contain duplicates
typeset -gU cdpath fpath mailpath path

# Disable shell sessions
SHELL_SESSIONS_DISABLE=1

# Check for custom dotfiles home
if [ -f "${XDG_CONFIG_HOME}/dotfiles-home" ]; then
  DOTFILES_HOME="${DOTFILES_HOME:-$(cat "${XDG_CONFIG_HOME}/dotfiles-home")}"
fi

# Dotfiles initialization
export DOTFILES_HOME="${DOTFILES_HOME:-${HOME}/.dotfiles}"

# shellcheck source=../../../lib/init.sh
source "${DOTFILES_HOME}/lib/init.sh"

# Export all environment files
if [ -d "${XDG_CONFIG_HOME}/environment.d" ]; then
  export_env_files_in "${XDG_CONFIG_HOME}"/environment.d/*.conf
fi
