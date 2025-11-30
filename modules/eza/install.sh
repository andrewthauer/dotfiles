#!/usr/bin/env bash

set -eou pipefail

DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &>/dev/null && pwd)"
PATH="$DOTFILES_HOME/bin:$PATH"

EZA_THEMES_DIR="$XDG_DATA_HOME/eza/themes"
EZA_THEME="catppuccin"

main() {
  case "$(os-info --family)" in
    *) pkg install eza ;;
  esac

  # Install or update eza theme
  if [ -d "$EZA_THEMES_DIR" ]; then
    git -C "$EZA_THEMES_DIR" pull
  else
    git clone https://github.com/eza-community/eza-themes.git "$EZA_THEMES_DIR"
  fi

  # Link eza dotfiles
  dotfiles noabsorb "$XDG_CONFIG_HOME/eza"
  dotfiles module link eza

  # Setup theme
  echo "Setting eza theme..."
  if [ -L "$XDG_CONFIG_HOME/eza/theme.yml" ]; then
    rm "$XDG_CONFIG_HOME/eza/theme.yml"
  fi
  ln -sf "$EZA_THEMES_DIR/themes/$EZA_THEME.yml" "$XDG_CONFIG_HOME/eza/theme.yml"
}

main "$@"
