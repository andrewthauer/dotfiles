#!/usr/bin/env bash

set -eou pipefail

prepare_dirs() {
  mkdir -p "${XDG_CONFIG_HOME}"/less
  mkdir -p "${XDG_CACHE_HOME}"/less
  mkdir -p "${XDG_BIN_HOME}"
}

main() {
  prepare_dirs
}

main "$@"
