#!/usr/bin/env bash

set -eou pipefail

DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &>/dev/null && pwd)"
PATH="$DOTFILES_HOME/bin:$PATH"

main() {
  if [ "$(command -v bash)" ]; then
    echo "bash is already installed"
  else
    pkg install bash
  fi

  # Make sure the share directory exists
  mkdir -p "$XDG_DATA_HOME/bash"

  # Backup existing dotfiles
  dotfiles backup files ~/.bash_profile ~/.bashrc
}

main "$@"
