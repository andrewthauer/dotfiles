#!/usr/bin/env bash

set -eou pipefail

DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &>/dev/null && pwd)"
PATH="$DOTFILES_HOME/bin:$PATH"

main() {
  case "$(os-info --family)" in
    arch) pkg install neovim tree-sitter-cli ;;
    *) pkg install neovim ;;
  esac

  if [ "$(command -v mise)" ]; then
    echo "Installing node.js using mise..."
    mise install node --yes
  fi

  dotfiles module add neovim

  nvim +PlugInstall +qall
}

main "$@"
