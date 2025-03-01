#!/usr/bin/env bash

set -eou pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &>/dev/null && pwd)}"
PATH="$DOTFILES_DIR/bin:$PATH"

main() {
  if [ "$(command -v starship)" ]; then
    echo "starship is already installed"
    exit 0
  fi

  case "$(os-info --package-manager)" in
    "apt") curl -sS https://starship.rs/install.sh | sh -s -- -y ;;
    *) pkg install "starship" ;;
  esac
}

main "$@"
