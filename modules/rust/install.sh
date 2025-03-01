#!/usr/bin/env bash

set -eou pipefail

main() {
  if [ "$(command -v rustup)" ]; then
    echo "rustup is already installed"
    exit 0
  fi

  case "$("$DOTFILES_DIR"/bin/os-info --package-manager)" in
    *)
      curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
      ;;
  esac
}

main "$@"
