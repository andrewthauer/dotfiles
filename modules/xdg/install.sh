#!/usr/bin/env bash

set -eou pipefail

main() {
  # prepare xdg directories
  mkdir -p "${HOME}/.ssh"
  mkdir -p "${XDG_CONFIG_HOME}/less"
  mkdir -p "${XDG_CONFIG_HOME}/ssh"
  mkdir -p "${XDG_CACHE_HOME}/less"
  mkdir -p "${XDG_BIN_HOME}"
}

main "$@"
