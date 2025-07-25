#!/usr/bin/env bash

set -eou pipefail

DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &>/dev/null && pwd)"
PATH="$DOTFILES_HOME/bin:$PATH"

main() {
  if [ "$(command -v rustup)" ]; then
    echo "rustup is already installed"
  else
    case "$(os-info --package-manager)" in
      *)
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
        ;;
    esac
  fi

}

main "$@"
