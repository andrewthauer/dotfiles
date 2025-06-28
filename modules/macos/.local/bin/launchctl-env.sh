#!/usr/bin/env bash

set -e

DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &>/dev/null && pwd)}"
PATH="$DOTFILES_HOME/bin:$PATH"

export_xdg_env() {
  export XDG_CONFIG_HOME="${HOME}/.config"
  export XDG_DATA_HOME="${HOME}/.local/share"
  export XDG_CACHE_HOME="${HOME}/.cache"
  export XDG_STATE_HOME="${HOME}/.local/state"
  export XDG_BIN_HOME="${HOME}/.local/bin"
}

launchctl_xdg_dirs() {
  launchctl setenv XDG_CONFIG_HOME "${XDG_CONFIG_HOME}"
  launchctl setenv XDG_DATA_HOME "${XDG_DATA_HOME}"
  launchctl setenv XDG_CACHE_HOME "${XDG_CACHE_HOME}"
  launchctl setenv XDG_STATE_HOME "${XDG_STATE_HOME}"
  launchctl setenv XDG_BIN_HOME "${XDG_BIN_HOME}"
}

main() {
  export_xdg_env
  launchctl_xdg_dirs
}

main "$@"
