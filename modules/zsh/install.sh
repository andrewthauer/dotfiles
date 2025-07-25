#!/usr/bin/env bash

set -eou pipefail

DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &>/dev/null && pwd)"
PATH="$DOTFILES_HOME/bin:$PATH"

install_zsh_plugins() {
  local plugins=("zsh-completions zsh-syntax-highlighting zsh-autosuggestions zsh-history-substring-search")

  case "$(os-info --package-manager)" in
    "apt")
      # TODO: Fix zsh-completions & zsh-history-substring-search on debian error even after registering
      plugins=("zsh-syntax-highlighting zsh-autosuggestions")
      ;;
    *)
      pkg install "${plugins[@]}"
      ;;
  esac
}

install_zsh() {
  case "$(os-info --family)" in
    "macos")
      brew install zsh
      ;;
    *)
      pkg install "zsh"
      ;;
  esac
}

main() {
  if [ "$(command -v zsh)" ]; then
    echo "zsh is already installed"
  else
    install_zsh
    install_zsh_plugins
  fi

  # Make sure the share directory exists
  mkdir -p "$XDG_DATA_HOME/zsh"

  # Link the zsh configuration
  dotfiles module add zsh
}

main "$@"
