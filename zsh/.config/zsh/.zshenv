#!/usr/bin/env zsh
#
# Defines zsh environment & changes to use XGD directories
#

# The current shell type
export CURRENT_SHELL="zsh"

# Load common shell env
source "${XDG_CONFIG_HOME}/environment"

# Ensure path arrays do not contain duplicates
typeset -gU cdpath fpath mailpath path

# Set the function path
fpath=(
  $XDG_DATA_HOME/zsh/functions
  $fpath
)

# Disable shell sessions
SHELL_SESSIONS_DISABLE=1

# Prompt
# ZSH_PROMPT="pure"
# if [[ -d "${XDG_DATA_HOME}/${ZSH_PROMPT}" ]]; then
#   fpath+="${XDG_DATA_HOME}/${ZSH_PROMPT}"
# fi
