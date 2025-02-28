#!/usr/bin/env bash

set -eou pipefail

setup_github() {
  if [ -f "$HOME/.ssh/known_hosts" ]; then
    ssh-keygen -R github.com
    ssh-keyscan -t rsa github.com >>~/.ssh/known_hosts
  else
    ssh-keyscan -t rsa github.com >~/.ssh/known_hosts
  fi
}

main() {
  setup_github
}

main "$@"
