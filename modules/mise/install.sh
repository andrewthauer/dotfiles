#!/usr/bin/env bash

set -eou pipefail

DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &>/dev/null && pwd)"
PATH="$DOTFILES_HOME/bin:$PATH"

main() {
  case "$(os-info --family)" in
    darwin) pkg install --type brew mise ;;
    *) curl https://mise.jdx.dev/install.sh | sh ;;
  esac

  # Do not own ~/.config/mise
  dotfiles noabsorb "$XDG_CONFIG_HOME/mise"

  # Ensure the dotfiles module is available
  dotfiles module link mise

  # Use idomatic version file for mise
  mise settings add idiomatic_version_file_enable_tools java,node,python,ruby

  # Trust the global configuration file if it exists
  local mise_config_file="${MISE_GLOBAL_CONFIG_FILE:-$XDG_CONFIG_HOME/mise/config.local.toml}"
  if [ -f "$mise_config_file" ]; then
    mise trust "$mise_config_file" --yes
  fi
}

main "$@"
#
