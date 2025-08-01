#!/usr/bin/env bash

set -eou pipefail

DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &>/dev/null && pwd)"
PATH="$DOTFILES_HOME/bin:$PATH"

link_dotfiles() {
  # Avoid absorbing extra carapace config files into dotfiles
  dotfiles noabsorb "$XDG_CONFIG_HOME/carapace"
  dotfiles noabsorb "$XDG_CONFIG_HOME/carapace/bridge"
}

main() {
  if [ "$(command -v carapace)" ]; then
    echo "carapace is already installed"
  else
    case "$(os-info --family)" in
      "macos")
        pkg install carapace
        ;;
      "debian")
        echo "deb [trusted=yes] https://apt.fury.io/rsteube/ /" | sudo tee /etc/apt/sources.list.d/carapace.list
        SKIP_PACAKGE_MANGER_UPDATE="false" pkg install carapace-bin
        ;;
    esac
  fi

  link_dotfiles
}

main "$@"
