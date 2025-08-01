#!/usr/bin/env bash

set -eou pipefail

DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &>/dev/null && pwd)"
PATH="$DOTFILES_HOME/bin:$PATH"

mise_devcontainer_setup() {
  # Move any existing mise config file to a backup
  if [ -f "$XDG_CONFIG_HOME/mise/config.toml" ] && [ ! -L "$XDG_CONFIG_HOME/mise/config.toml" ]; then
    mv "$XDG_CONFIG_HOME/mise/config.toml" "$XDG_CONFIG_HOME/config.toml.old"
  fi

  # Custom mise config to avoid conflicts with mounted volumes or base images
  if [ -n "$MISE_GLOBAL_CONFIG_FILE" ]; then
    cat >"$DOTFILES_LOCAL_MODULE_PATH/.config/environment.d/mise.conf" <<EOF
MISE_GLOBAL_CONFIG_FILE="${MISE_GLOBAL_CONFIG_FILE}"
EOF
  fi
}

main() {
  if [ "$(command -v mise)" ]; then
    echo "mise is already installed"
  else
    case "$(os-info --family)" in
      "macos") pkg install --type brew mise ;;
      *) curl https://mise.jdx.dev/install.sh | sh ;;
    esac
  fi

  # Special handling for devcontainer setup
  if [ -n "${REMOTE_CONTAINERS:-}" ] || [ -n "${DEVPOD:-}" ]; then
    mise_devcontainer_setup
  fi

  # Ensure the dotfiles module is available
  dotfiles module link mise

  # Use idomatic version file for mise
  mise settings add idiomatic_version_file_enable_tools java,node,python,ruby

  # Trust the global configuration file if it exists
  local mise_config_file="${MISE_GLOBAL_CONFIG_FILE:-$XDG_CONFIG_HOME/mise/config.toml}"
  if [ -f "$mise_config_file" ]; then
    mise trust "$mise_config_file" --yes
  fi
}

main "$@"
