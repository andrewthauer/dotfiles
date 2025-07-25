#!/usr/bin/env bash

set -eou pipefail

DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &>/dev/null && pwd)"
PATH="$DOTFILES_HOME/bin:$PATH"

configure_claude_desktop() {
  LIBRARY_DIR="$HOME/Library/Application Support"

  # dotfiles module link "local-genai"

  # claude
  SOURCE_DIR="$XDG_CONFIG_HOME/claude-desktop"
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
}

main "$@"
