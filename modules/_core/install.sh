#!/usr/bin/env bash

prepare_dirs() {
  mkdir -p "${XDG_CONFIG_HOME}/nvim"
  mkdir -p "${XDG_CONFIG_HOME}/less"
  mkdir -p "${XDG_CACHE_HOME}/less"
  mkdir -p "${XDG_BIN_HOME}"
}

main() {
  prepare_dirs
}

main "$@"
