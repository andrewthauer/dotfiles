#!/usr/bin/env bash

set -eou pipefail

DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &>/dev/null && pwd)"
PATH="$DOTFILES_HOME/bin:$PATH"

main() {
  if [ "$(command -v starship)" ]; then
    echo "starship is already installed"
  else
    case "$(os-info --package-manager)" in
      "apt") curl -fsSL https://starship.rs/install.sh | sh -s -- --yes --bin-dir ~/.local/bin ;;
      *) pkg install "starship" ;;
    esac
  fi

}

main "$@"
