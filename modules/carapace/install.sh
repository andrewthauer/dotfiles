#!/usr/bin/env bash

set -eou pipefail

DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &>/dev/null && pwd)"
PATH="$DOTFILES_HOME/bin:$PATH"

main() {
  case "$(os-info --family)" in
    darwin) pkg --type brew install carapace ;;
    arch) pkg --type aur install carapace-bin ;;
    debian) pkg install --type apt-repo --repo "deb  https://apt.fury.io/rsteube/ /" carapace-bin ;;
    *)
      echo "Unsupported OS for carapace installation"
      exit 1
      ;;
  esac

  # Avoid absorbing extra carapace config files into dotfiles
  dotfiles noabsorb "$XDG_CONFIG_HOME/carapace"
  dotfiles noabsorb "$XDG_CONFIG_HOME/carapace/bridge"
}

main "$@"
