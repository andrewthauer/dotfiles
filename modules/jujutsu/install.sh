#!/usr/bin/env bash

set -eou pipefail

DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &>/dev/null && pwd)"
PATH="$DOTFILES_HOME/bin:$PATH"

install_tools() {
  if ! command -v lazyjj &>/dev/null; then
    pkg install lazyjj
  fi

  # if ! command -v jjui &>/dev/null; then
  #   mise use --global go:github.com/idursun/jjui/cmd/jjui@latest
  # fi
}

main() {
  if [ "$(command -v jj)" ]; then
    echo "jj is already installed"
  fi

  install_tools
}

main "$@"
