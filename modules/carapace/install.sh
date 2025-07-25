#!/usr/bin/env bash

set -eou pipefail

DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &>/dev/null && pwd)"
PATH="$DOTFILES_HOME/bin:$PATH"

link_dotfiles() {
  echo "Installing Carapace configuration..."

  # We need to ensure the config directory exists and has a child so stow doesn't symlink the parent directory
  mkdir -p "$XDG_CONFIG_HOME/carapace/bridge/fish"
  mkdir -p "$XDG_CONFIG_HOME/carapace/bridge/zsh"
  touch "$XDG_CONFIG_HOME/carapace/_no_parent_symlink" || true
  touch "$XDG_CONFIG_HOME/carapace/bridge/no_parent_symlink" || true

  # We can now safely link the carapace configuration
  dotfiles module add carapace
  dotfiles module link carapace
}

main() {
  if [ "$(command -v carapace)" ]; then
    echo "carapace is already installed"
  else
    case "$(os-info --family)" in
      "macos")
        brew install carapace || true
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
