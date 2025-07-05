#!/usr/bin/env bash

set -eou pipefail

DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &>/dev/null && pwd)"
PATH="$DOTFILES_HOME/bin:$PATH"

# Zed package to use
ZED_PACKAGE="zed@preview"

install_macos() {
  echo "Installing $ZED_PACKAGE editor..."
  if ! brew list --cask | grep -q "^$ZED_PACKAGE\$"; then
    brew install --cask $ZED_PACKAGE || true
  else
    echo "$ZED_PACKAGE is already installed"
  fi
}

link_dotfile() {
  echo "Installing Zed editor configuration..."

  # We need to ensure the config directory exists and has a child so stow doesn't symlink the parent directory
  mkdir -p "$XDG_CONFIG_HOME/zed"
  touch "$XDG_CONFIG_HOME/zed/_no_parent_symlink" || true

  # We can now safely link the Zed configuration
  dotfiles module add zed
}

sync_zed_settingss() {
  local source_settings_file="$DOTFILES_HOME/modules/zed/.config/zed/settings-safe.json"
  local target_settings_file="$XDG_CONFIG_HOME/zed/settings.json"

  if [ ! -f "$target_settings_file" ]; then
    cp "$source_settings_file" "$target_settings_file"
  fi

  # TODO: Merge settings.json with existing settings if it exists
  # ...
}

main() {
  case "$(os-info --family)" in
    macos)
      install_macos
      ;;
  esac

  link_dotfile
  sync_zed_settingss
}

main "$@"
