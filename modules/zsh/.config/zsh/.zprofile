#!/usr/bin/env zsh
#
# Executes commands at login pre-zshrc
#

if [ -n "$DOTFILES_TRACE" ]; then
  echo "load: ~/.config/zsh/.zprofile"
  echo "path: ${PATH}"
fi

# Completions file
export ZSH_COMPDUMP="${XDG_CACHE_HOME}/zsh/zcompdump"

# Ensure the xdg data & cache directories exist
[ ! -d "${XDG_DATA_HOME}/zsh" ] && mkdir -p "${XDG_DATA_HOME}/zsh"
[ ! -d "${XDG_CACHE_HOME}/zsh" ] && mkdir -p "${XDG_CACHE_HOME}/zsh"

# Load profile files into environment
if [ -d "${XDG_CONFIG_HOME}/profile.d" ]; then
  source_files_in "${XDG_CONFIG_HOME}"/profile.d/*
fi
