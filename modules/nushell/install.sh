#!/usr/bin/env bash

set -e

main() {
  case "$("$DOTFILES_BIN"/os-info --family)" in
    "macos")
      brew install nushell carapace
      ;;
    *) ;;
  esac
}

main "$@"
