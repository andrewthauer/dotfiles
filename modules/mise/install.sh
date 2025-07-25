#!/usr/bin/env bash

set -eou pipefail

DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &>/dev/null && pwd)"
PATH="$DOTFILES_HOME/bin:$PATH"

main() {
  if [ "$(command -v mise)" ]; then
    echo "mise is already installed"
  else
    case "$(os-info --family)" in
      "macos")
        brew list mise || brew install mise || true
        ;;
      *)
        curl https://mise.jdx.dev/install.sh | sh
        ;;
    esac
  fi

  # Ensure the dotfiles module is available
  dotfiles module add --continue-on-error mise

  # Trust the global configuration file if it exists
  local mise_config_file="${MISE_GLOBAL_CONFIG_FILE:-$XDG_CONFIG_HOME/mise/config.toml}"
  if [ -f "$mise_config_file" ]; then
    mise trust "$mise_config_file" --yes
  fi
}

main "$@"
