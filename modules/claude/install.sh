#!/usr/bin/env bash

set -eou pipefail

DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &>/dev/null && pwd)"
PATH="$DOTFILES_HOME/bin:$PATH"

link_file() {
  local source="$1"
  local target="$2"

  if [ -e "$target" ] && [ ! -L "$target" ]; then
    echo "Skipping $target: a real file or directory is in the way" >&2
    return 0
  fi

  ln -sfn "$source" "$target"
}

setup_claude_code() {
  # Avoid absorbing extra claude config files into dotfiles
  dotfiles noabsorb "$XDG_CONFIG_HOME/claude"

  # Link through ~/.config/agents, which merges the agents and local modules
  dotfiles noabsorb "$HOME/.claude"
  link_file "../.config/agents/AGENTS.md" "$HOME/.claude/CLAUDE.md"
  link_file "../.config/agents/skills" "$HOME/.claude/skills"
}

setup_claude_desktop() {
  # Setup a symlink from dotfiles to ~/Library/Application Support/Claude
  LIBRARY_DIR="$HOME/Library/Application Support"
  SOURCE_DIR="$XDG_CONFIG_HOME/claude-desktop"
  mkdir -p "$LIBRARY_DIR/Claude"
  ln -sf "$SOURCE_DIR/claude_desktop_config.json" "$LIBRARY_DIR/Claude/claude_desktop_config.json"
}

main() {
  case "$(os-info --family)" in
    darwin)
      pkg install --type brew claude claude-code
      ;;
  esac

  setup_claude_code
  setup_claude_desktop
}

main "$@"
