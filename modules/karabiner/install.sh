#!/usr/bin/env bash

set -eou pipefail

DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &>/dev/null && pwd)"
PATH="$DOTFILES_HOME/bin:$PATH"

install_karabiner() {
  echo "Installing Karabiner-Elements..."
  brew list karabiner-elements || brew install karabiner-elements || true
}

configure_karabiner() {
  echo "Configuring Karabiner-Elements..."
  dotfiles module add karabiner

  # TODO: Walk user through configuration steps
  # ...
}

main() {
  case "$(os-info --family)" in
    "macos")
      install_karabiner
      configure_karabiner
      ;;
    *)
      echo "Karabiner-Elements is only available on macOS"
      exit 1
      ;;
  esac
}

main "$@"
