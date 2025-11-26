#!/usr/bin/env bash

set -eou pipefail

DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &>/dev/null && pwd)"
PATH="$DOTFILES_HOME/bin:$PATH"

main() {
  case "$(os-info --family)" in
    darwin)
      mkdir -p "$HOME/Library/LaunchAgents"
      ;;
    *)
      echo "This module is for macOS only"
      exit 1
      ;;
  esac
}

main "$@"
