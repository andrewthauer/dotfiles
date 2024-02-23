#!/usr/bin/env zsh
#
# Defines zsh environment & changes to use XGD directories
#

if [ -n "$DOTFILES_TRACE" ]; then
  echo "load: ~/.config/zsh/.zshenv"
  echo "path: ${PATH}"
fi

# The current shell type
export CURRENT_SHELL="zsh"

# Ensure path arrays do not contain duplicates
typeset -gU cdpath fpath mailpath path

# Disable shell sessions
SHELL_SESSIONS_DISABLE=1
