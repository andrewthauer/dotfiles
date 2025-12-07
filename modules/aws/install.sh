#!/usr/bin/env bash

set -eou pipefail

DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &>/dev/null && pwd)"
PATH="$DOTFILES_HOME/bin:$PATH"

main() {
  case "$(os-info --family)" in
    *) pkg install awscli ;;
  esac

  # Make sure the share directory exists
  mkdir -p "$HOME/.aws"
  mkdir -p "$XDG_CONFIG_HOME/aws"
  mkdir -p "$XDG_DATA_HOME/aws"

  # Backup existing dotfiles
  if [ ! -e "$HOME/.aws" ] && [ ! -L "$HOME/.aws" ]; then
    pushd "$HOME" >/dev/null || false
    ln -s "$XDG_CONFIG_HOME/aws/config" ".aws"
    popd >/dev/null || false
  fi
}

main "$@"
