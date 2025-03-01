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

find_deno_path() {
  local deno_paths=(
    "${XDG_DATA_HOME}/mise/installs/deno/latest/bin/deno"
    "${XDG_BIN_HOME}/deno"
    "/opt/homebrew/bin/deno"
    "/usr/local/bin/deno"
  )

  for deno_path in "${deno_paths[@]}"; do
    if [ -f "${deno_path}" ]; then
      echo "${deno_path}"
      return 0
    fi
  done

  return 1
}

launchctl_env_files() {
  local script="envx.ts"
  local deno_cmd

  deno_cmd=$(find_deno_path)
  if [ -z "${deno_cmd}" ]; then
    echo "Deno not found"
    return 1
  fi

  $deno_cmd run -A "$script" --launchctl-set "${XDG_CONFIG_HOME}"/environment.d/*.conf
}

main() {
  export_xdg_env
  launchctl_xdg_dirs
  # launchctl_env_files
}

main "$@"
