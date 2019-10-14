#!/usr/bin/env zsh
#
# Executes commands at the start of an interactive session
#

# Enable zprof performance profiling
[[ -n $PROFILE_STARTUP ]] && zmodload zsh/zprof

# Load core utilities used by other scripts
source "${DOTFILES_DIR}/lib/init.sh"

# Do not throw errors when file globs do not match anything
setopt NULL_GLOB

# Source zsh core scripts
source_files_in $XDG_CONFIG_HOME/zsh/init.d/*.zsh

# Source common shell scripts
source_files_in $XDG_CONFIG_HOME/profile.d/*.sh

# Load the local zsh file
if [[ -f "${XDG_CONFIG_HOME}/zsh/.zshrc.local" ]]; then
  source "${XDG_CONFIG_HOME}/zsh/.zshrc.local"
fi
