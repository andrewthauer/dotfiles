#!/usr/bin/env bash

set -eou pipefail

DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &>/dev/null && pwd)"
PATH="$DOTFILES_HOME/bin:$PATH"

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
