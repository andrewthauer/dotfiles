#!/usr/bin/env zsh
#
# Executes on interactive login
#

# Load local login (if exists)
if [[ -f "${XDG_CONFIG_HOME}/zsh/.zlogin.local" ]]; then
  source "${XDG_CONFIG_HOME}/zsh/.zlogin.local"
fi
