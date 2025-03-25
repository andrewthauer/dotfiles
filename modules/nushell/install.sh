#!/usr/bin/env bash

set -eou pipefail

DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &>/dev/null && pwd)"
PATH="$DOTFILES_HOME/bin:$PATH"

main() {
  if [ "$(command -v nushell)" ]; then
    echo "nushell is already installed"
    exit 0
  fi

  case "$(os-info --family)" in
    "macos")
      brew install nushell carapace
      ;;
    "debian")
      if [ ! -f "/etc/apt/trusted.gpg.d/fury-nushell.gpg" ]; then
        curl -fsSL https://apt.fury.io/nushell/gpg.key | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/fury-nushell.gpg
      fi
      echo "deb https://apt.fury.io/nushell/ /" | sudo tee /etc/apt/sources.list.d/fury.list
      SKIP_PACAKGE_MANGER_UPDATE="false" pkg install nushell
      ;;
  esac
}

main "$@"
