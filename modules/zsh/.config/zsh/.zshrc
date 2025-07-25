#!/usr/bin/env zsh
#
# Executes commands at the start of an interactive session
#

if [ -n "$DOTFILES_TRACE" ]; then
  echo "load: ~/.config/zsh/.zshrc"
  echo "path: ${PATH}"
fi

# Enable zprof performance profiling
[ -n "$PROFILE_STARTUP" ] && zmodload zsh/zprof

# Append bin directories to path
prepend_path "${DOTFILES_HOME}/bin"
prepend_path "${HOME}/.local/bin"

# Source zsh core scripts
source_files_in "${XDG_CONFIG_HOME}"/zsh/init.d/*.zsh

# Source zsh plugins
source_files_in "${XDG_CONFIG_HOME}"/zsh/plugins/*.zsh
