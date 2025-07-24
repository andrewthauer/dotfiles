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
  link_dotfiles
}

main "$@"
