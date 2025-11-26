#!/usr/bin/env bash

set -eou pipefail

DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &>/dev/null && pwd)"
PATH="$DOTFILES_HOME/bin:$PATH"

main() {
  case "$(os-info --family)" in
    *) pkg install bash ;;
  esac

  # Make sure the share directory exists
  mkdir -p "$XDG_DATA_HOME/bash"

  # Backup existing dotfiles
  dotfiles backup files ~/.bash_profile ~/.bashrc
}

main "$@"
