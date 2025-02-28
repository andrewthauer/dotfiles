#!/usr/bin/env bash

set -eou pipefail

install_plugins() {
  nvim +PlugInstall +qall
}

main() {
  if [ "$(command -v neovim)" ]; then
    echo "neovim is already installed"
    exit 1
  fi

  case "$("$DOTFILES_DIR"/bin/os-info --family)" in
    "macos")
      brew install neovim
      ;;
    *)
      "$DOTFILES_DIR"/bin/pkg install "neovim"
      ;;
  esac

  install_plugins
}

main "$@"
