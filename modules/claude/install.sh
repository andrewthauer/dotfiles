#!/usr/bin/env bash

set -eou pipefail

DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &>/dev/null && pwd)"
PATH="$DOTFILES_HOME/bin:$PATH"

setup_claude_code() {
  # Avoid absorbing extra claude config files into dotfiles
  dotfiles noabsorb "$XDG_CONFIG_HOME/claude"
}

setup_claude_desktop() {
  # Setup a symlink from dotfiles to ~/Library/Application Support/Claude
  LIBRARY_DIR="$HOME/Library/Application Support"
  SOURCE_DIR="$XDG_CONFIG_HOME/claude-desktop"
  mkdir -p "$LIBRARY_DIR/Claude"
  ln -sf "$SOURCE_DIR/claude_desktop_config.json" "$LIBRARY_DIR/Claude/claude_desktop_config.json"
}

main() {
  if [ "$(command -v claude)" ]; then
    echo "claude is already installed"
  else
    case "$(os-info --family)" in
      macos)
        pkg install claude claude-code
        configure_claude_desktop
        ;;
    esac
  fi

  setup_claude_code
  setup_claude_desktop
}

main "$@"
