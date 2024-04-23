#!/usr/bin/env bash

main() {
  case "$("$DOTFILES_DIR"/bin/os-info --package-manager)" in
    "apt") curl -sS https://starship.rs/install.sh | sh -s -- -y ;;
    *) "$DOTFILES_DIR"/bin/pkg install "starship" ;;
  esac
}

main "$@"
