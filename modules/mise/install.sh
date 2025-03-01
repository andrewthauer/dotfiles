#!/usr/bin/env bash

set -eou pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &>/dev/null && pwd)}"
PATH="$DOTFILES_DIR/bin:$PATH"

main() {
  if [ "$(command -v mise)" ]; then
    echo "mise is already installed"
    exit 0
  fi

  case "$(os-info --family)" in
    "macos")
      brew install mise
      ;;
    *)
      curl https://mise.jdx.dev/install.sh | sh
      ;;
  esac
}

main "$@"
