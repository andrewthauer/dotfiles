#!/usr/bin/env zsh
#
# Executes commands at login pre-zshrc
#

# Load core utilities used by other scripts
source "${DOTFILES_DIR}/lib/init.sh"

# Append bin directories to path
prepend_path "${DOTFILES_DIR}/bin"
prepend_path "${HOME}/.local/bin"

# Ensure the xdg data & cache directories exist
[[ ! -d "${XDG_DATA_HOME}/zsh" ]] && mkdir -p "${XDG_DATA_HOME}/zsh"
[[ ! -d "${XDG_CACHE_HOME}/zsh" ]] && mkdir -p "${XDG_CACHE_HOME}/zsh"

# Load local profile (if exists)
if [[ -f "${XDG_CONFIG_HOME}/zsh/.zprofile.local" ]]; then
  source "${XDG_CONFIG_HOME}/zsh/.zprofile.local"
fi
