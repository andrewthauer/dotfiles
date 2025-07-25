#!/usr/bin/env bash

set -eou pipefail

setup_github() {
  # We need to ensure the config directory exists and has a child so stow doesn't symlink the parent directory
  mkdir -p "$XDG_CONFIG_HOME/gh"
  touch "$XDG_CONFIG_HOME/gh/_no_parent_symlink" || true
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
