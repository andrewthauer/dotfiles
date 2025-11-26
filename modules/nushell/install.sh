#!/usr/bin/env bash

set -eou pipefail

DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &>/dev/null && pwd)"
PATH="$DOTFILES_HOME/bin:$PATH"

main() {
  case "$(os-info --family)" in
    "debian") pkg install --type apt-repo --repo "deb [trusted=yes] https://apt.fury.io/nushell/ /" nushell ;;
    *) pkg install nushell ;;
  esac
}

main "$@"
