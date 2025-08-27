#!/usr/bin/env bash

set -eou pipefail

DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &>/dev/null && pwd)"
PATH="$DOTFILES_HOME/bin:$PATH"

install_karabiner() {
  echo "Installing Karabiner-Elements..."
  pkg install --type brew karabiner-elements
}

configure_karabiner() {
  echo "Configuring Karabiner-Elements..."
  dotfiles module link karabiner

  # TODO: Walk user through configuration steps
  # ...
}

main() {
  case "$(os-info --family)" in
    "macos")
      if brew list karabiner-elements &>/dev/null; then
        echo "Karabiner-Elements already installed, skipping..."
        return 0
      fi
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
