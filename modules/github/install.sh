#!/usr/bin/env bash

set -eou pipefail

DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &>/dev/null && pwd)"
PATH="$DOTFILES_HOME/bin:$PATH"

setup_github() {
  # Avoid absorbing extra gh config files into dotfiles
  dotfiles noabsorb "$XDG_CONFIG_HOME/gh"
}

setup_ssh_keys() {
  if ! command -v ssh-keygen &>/dev/null; then
    echo "ssh-keygen is not available, please install it to generate SSH keys"
    return 0
  fi

  if [ -f "$HOME/.ssh/known_hosts" ]; then
    ssh-keygen -R github.com
    ssh-keyscan -t rsa github.com >>~/.ssh/known_hosts
  else
    ssh-keyscan -t rsa github.com >~/.ssh/known_hosts
  fi
}

main() {
  setup_github
  setup_ssh_keys
}

main "$@"
