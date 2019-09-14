#!/usr/bin/env zsh
#
# Executes commands at the start of an interactive session
#

# Enable zprof performance profiling
[[ -n $PROFILE_STARTUP ]] && zmodload zsh/zprof

# Load core utilities used by other scripts
source "${DOTFILES_DIR}/lib/init.sh"

# Source scripts
source_files_in ~/.zsh/*.zsh
source_files_in ~/.shell/*.sh

# Load the local zsh file
if [[ -f "$HOME/.zshrc.local" ]]; then
  source "$HOME/.zshrc.local"
fi
