#!/usr/bin/env zsh
#
# Executes on interactive login
#

# Load local login (if exists)
if [[ -f "${HOME}/.zlogin.local" ]]; then
  source "${HOME}/.zlogin.local"
fi
