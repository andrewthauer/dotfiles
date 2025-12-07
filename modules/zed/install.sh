#!/usr/bin/env bash

set -eou pipefail

DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &>/dev/null && pwd)"
PATH="$DOTFILES_HOME/bin:$PATH"

ZED_CHANNEL="${ZED_CHANNEL:-preview}"

link_dotfiles() {
  echo "Installing Zed editor configuration..."

  # Avoid absorbing extra zed config files into dotfiles
  dotfiles noabsorb "$XDG_CONFIG_HOME/zed"

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
    darwin)
      brew install --cask "zed@$ZED_CHANNEL" || true
      rm -f "$HOME/.local/bin/zed"
      ln -s /Applications/Zed\ Preview.app/Contents/MacOS/cli "$HOME/.local/bin/zed"
      ;;
    *)
      curl -f https://zed.dev/install.sh | ZED_CHANNEL="$ZED_CHANNEL" sh
      rm -f "$HOME/.local/bin/zed"
      ln -s /usr/bin/zeditor "$HOME/.local/bin/zed"
      ;;
  esac

  link_dotfiles
  sync_zed_settingss
}

main "$@"
