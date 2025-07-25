#!/usr/bin/env bash

set -eou pipefail

DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &>/dev/null && pwd)"
PATH="$DOTFILES_HOME/bin:$PATH"

main() {
  case "$(os-info --family)" in
    "macos")
      brew list mise || brew install mise || true
      ;;
    *)
      if [ "$(command -v mise)" ]; then
        echo "mise is already installed"
      else
        curl https://mise.jdx.dev/install.sh | sh
      fi
      ;;
  esac

  dotfiles module add --continue-on-error mise

  if [ -f "$XDG_CONFIG_HOME/mise/config.toml" ]; then
    mise trust "$XDG_CONFIG_HOME/mise/config.toml" --yes
  fi
}

main "$@"
