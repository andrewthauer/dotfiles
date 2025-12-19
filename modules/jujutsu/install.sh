#!/usr/bin/env bash

set -eou pipefail

DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &>/dev/null && pwd)"
PATH="$DOTFILES_HOME/bin:$PATH"

install_tools() {
  pkg install lazyjj

  # if ! command -v jjui &>/dev/null; then
  #   mise use --global go:github.com/idursun/jjui/cmd/jjui@latest
  # fi
}

main() {
  case "$(os-info --family)" in
    *) pkg install jujutsu difftastic ;;
  esac

  install_tools
}

main "$@"
