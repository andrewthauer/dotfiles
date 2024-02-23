#!/usr/bin/env zsh
#
# Executes commands at login pre-zshrc
#

if [ -n "$DOTFILES_TRACE" ]; then
  echo "load: ~/.config/zsh/.zprofile"
  echo "path: ${PATH}"
fi

# Dotfiles initialization
export DOTFILES_DIR="${DOTFILES_DIR:-${HOME}/.dotfiles}"
# shellcheck source=../../../lib/init.sh
source "${DOTFILES_DIR}/lib/init.sh"

# Load profile files into environment
if [ -d "${XDG_CONFIG_HOME}/profile.d" ]; then
  source_files_in "${XDG_CONFIG_HOME}"/profile.d/*
fi

# Completions file
export ZSH_COMPDUMP="${XDG_CACHE_HOME}/zsh/zcompdump"

# Ensure the xdg data & cache directories exist
[[ ! -d "${XDG_DATA_HOME}/zsh" ]] && mkdir -p "${XDG_DATA_HOME}/zsh"
[[ ! -d "${XDG_CACHE_HOME}/zsh" ]] && mkdir -p "${XDG_CACHE_HOME}/zsh"
