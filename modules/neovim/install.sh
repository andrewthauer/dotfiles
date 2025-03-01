#!/usr/bin/env bash

set -eou pipefail

DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &>/dev/null && pwd)}"
PATH="$DOTFILES_HOME/bin:$PATH"

install_plugins() {
  nvim +PlugInstall +qall
}

main() {
  if [ "$(command -v neovim)" ]; then
    echo "neovim is already installed"
    exit 1
  fi

  case "$(os-info --family)" in
    "macos") brew install neovim ;;
    *) pkg install "neovim" ;;
  esac

  install_plugins
}

main "$@"
