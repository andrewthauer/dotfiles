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

# Dotfiles initialization
export DOTFILES_DIR="${DOTFILES_DIR:-${HOME}/.dotfiles}"

# shellcheck source=../../../lib/init.sh
source "${DOTFILES_DIR}/lib/init.sh"

# Export all environment files
if [ -d "${XDG_CONFIG_HOME}/environment.d" ]; then
  export_env_files_in "${XDG_CONFIG_HOME}"/environment.d/*.conf
fi
