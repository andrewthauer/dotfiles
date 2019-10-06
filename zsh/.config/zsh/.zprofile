#!/usr/bin/env zsh
#
# Executes commands at login pre-zshrc
#

# Ensure the xdg data & cache directories exist
[[ ! -d "${XDG_DATA_HOME}/zsh" ]] && mkdir -p "${XDG_DATA_HOME}/zsh"
[[ ! -d "${XDG_CACHE_HOME}/zsh" ]] && mkdir -p "${XDG_CACHE_HOME}/zsh"

# Set the list of directories that Zsh searches for programs
path=(
  ~/.local/bin
  ${DOTFILES_DIR}/bin
  $path
)

# Set the function path
fpath=(
  $XDG_DATA_HOME/zsh/functions
  $fpath
)

# Prompt
ZSH_PROMPT="pure"
if [[ -d "${XDG_DATA_HOME}/${ZSH_PROMPT}" ]]; then
  fpath+="${XDG_DATA_HOME}/${ZSH_PROMPT}"
fi

# Load local profile (if exists)
if [[ -f "${XDG_CONFIG_HOME}/zsh/.zprofile.local" ]]; then
  source "${XDG_CONFIG_HOME}/zsh/.zprofile.local"
fi
