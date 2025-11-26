#!/usr/bin/env bash

set -eou pipefail

DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &>/dev/null && pwd)"
PATH="$DOTFILES_HOME/bin:$PATH"

main() {
  case "$(os-info --family)" in
    *) pkg install zsh ;;
  esac

  # Install zsh plugins
  local plugins=("zsh-completions zsh-syntax-highlighting zsh-autosuggestions zsh-history-substring-search")
  case "$(os-info --package-manager)" in
    "apt")
      # TODO: Fix zsh-completions & zsh-history-substring-search on debian error even after registering
      plugins=("zsh-syntax-highlighting zsh-autosuggestions")
      ;;
    *) pkg install "${plugins[@]}" ;;
  esac

  # Ensure zsh xdg directories exist
  mkdir -p "${XDG_DATA_HOME}/zsh"
  mkdir -p "${XDG_CACHE_HOME}/zsh"

  # Backup existing dotfiles
  dotfiles backup files ~/.zshenv ~/.zprofile ~/.zshrc
}

main "$@"
#
