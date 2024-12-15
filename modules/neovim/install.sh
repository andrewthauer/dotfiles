#!/usr/bin/env bash

set -eou pipefail

install_plugins() {
  nvim +PlugInstall +qall
}

main() {
  case "$("$DOTFILES_BIN"/os-info --family)" in
    "macos")
      brew install neovim
      ;;
    *) ;;
  esac

  install_plugins
}

main "$@"
