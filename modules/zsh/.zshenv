#!/usr/bin/env zsh
#
# Defines zsh environment
#

# Ensure the profile is loaded
if [[ -f "${HOME}/.zprofile" && ! -z $ZSH_PROFILE_LOADED ]]; then
  source "${HOME}/.zprofile"
fi

# Load local zshenv (if exists)
if [[ -f "${HOME}/.zshenv.local" ]]; then
  source "${HOME}/.zshenv.local"
fi
