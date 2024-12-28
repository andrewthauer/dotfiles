#!/usr/bin/env bash

set -eou pipefail

main() {
  case "$("$DOTFILES_BIN"/os-info --family)" in
    "macos")
      brew install nushell carapace
      ;;
    *)
      "$DOTFILES_DIR"/bin/pkg install "nushell"
      ;;
  esac
}

main "$@"
