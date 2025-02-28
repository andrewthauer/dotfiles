#!/usr/bin/env bash

set -eou pipefail

main() {
  if [ "$(command -v starship)" ]; then
    echo "starship is already installed"
    exit 0
  fi

  case "$("$DOTFILES_DIR"/bin/os-info --package-manager)" in
    "apt")
      curl -sS https://starship.rs/install.sh | sh -s -- -y
      ;;
    *)
      "$DOTFILES_DIR"/bin/pkg install "starship"
      ;;
  esac
}

main "$@"
