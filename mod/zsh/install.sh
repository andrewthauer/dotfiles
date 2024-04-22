#!/usr/bin/env bash

install_zsh_plugins() {
  local plugins=("zsh-completions zsh-syntax-highlighting zsh-autosuggestions zsh-history-substring-search")

  case ${pkg_mgr} in
    "apt")
      # TODO: Fix zsh-completions & zsh-history-substring-search on debian error even after registering
      plugins=("zsh-syntax-highlighting zsh-autosuggestions")
      ;;
    *) ;;
  esac

  "$DOTFILES_DIR/bin/pkg" install "${plugins[@]}"
}

main() {
  # shellcheck disable=SC2086
  pkg_mgr="$("$DOTFILES_DIR"/bin/os-info --package-manager)"

  install_zsh_plugins
}

main "$@"
