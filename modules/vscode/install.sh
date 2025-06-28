#!/usr/bin/env bash

set -eou pipefail

DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &>/dev/null && pwd)"
PATH="$DOTFILES_HOME/bin:$PATH"

LIBRARY_DIR="$HOME/Library/Application Support"
SOURCE_DIR="$XDG_CONFIG_HOME/vscode"

main() {
  case "$(os-info --family)" in
    macos)
      dotfiles module add vscode
      # vscode
      ln -sf "$SOURCE_DIR/keybindings.json" "$LIBRARY_DIR/Code/User/keybindings.json"
      ln -sf "$SOURCE_DIR/settings.json" "$LIBRARY_DIR/Code/User/settings.json"
      # cursor
      ln -sf "$SOURCE_DIR/keybindings.json" "$LIBRARY_DIR/Cursor/User/keybindings.json"
      ln -sf "$SOURCE_DIR/settings.json" "$LIBRARY_DIR/Cursor/User/settings.json"
      ;;
  esac
}

main "$@"
