#!/usr/bin/env bash

set -eou pipefail

install_zsh_plugins() {
  local plugins=("zsh-completions zsh-syntax-highlighting zsh-autosuggestions zsh-history-substring-search")

  case "$("$DOTFILES_DIR"/bin/os-info --package-manager)" in
    "apt")
      # TODO: Fix zsh-completions & zsh-history-substring-search on debian error even after registering
      plugins=("zsh-syntax-highlighting zsh-autosuggestions")
      ;;
    *)
      "$DOTFILES_DIR"/bin/pkg install "${plugins[@]}"
      ;;
  esac
}

main() {
  case "$("$DOTFILES_DIR"/bin/os-info --family)" in
    "macos")
      brew install zsh
      ;;
    *)
      "$DOTFILES_DIR"/bin/pkg install "zsh"
      ;;
  esac

  install_zsh_plugins
}

main "$@"
