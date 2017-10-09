#!/usr/bin/env sh
# Executes commands at the start of an interactive session

# If not running interactively (powershell), don't do anything
[ -z "$PS1" ] && return

# Launch zsh (for windows bash)
# Check for MS: uname -r | sed -n 's/.*\( *Microsoft *\).*/\1/p'
# NOTE: It may be possible to remove this post windows 10 creators update
if [ -t 1 ]; then
  exec zsh
fi

# Dotfiles directory
export DOTFILES_DIR="${HOME}/.dotfiles"
