#!/usr/bin/env bash

set -eou pipefail

DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &>/dev/null && pwd)"
PATH="$DOTFILES_HOME/bin:$PATH"

install_prerequisites() {
  if [ "$(command -v mise)" ]; then
    echo "Installing node.js using mise..."
    mise install node --yes
  fi
}

install_plugins() {
  nvim +PlugInstall +qall
}

main() {
  if [ "$(command -v neovim)" ]; then
    echo "neovim is already installed"
  else
    case "$(os-info --family)" in
      "macos")
        brew install neovim || true
        ;;
      *)
        pkg install "neovim"
        ;;
    esac
  fi

  install_prerequisites
  install_plugins
}

main "$@"
