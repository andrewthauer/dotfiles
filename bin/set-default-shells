#!/usr/bin/env bash
# Summary:
#   Recursively removes a directory pattern

set -e

setup_default_shells() {
  # disable usage of sudo if requested
  [[ "$DOTFILES_DISABLE_SUDO" -eq 0 ]] && sudo_cmd="sudo " || sudo_cmd=""

  local bash_path
  bash_path="$(which bash | head -1)"

  local zsh_path
  zsh_path="$(which zsh | head -1)"

  case "$("$DOTFILES_BIN"/os-info --family)" in
    "macos")
      ! grep -q "${bash_path}" /etc/shells && echo "${bash_path}" | $sudo_cmd tee -a /etc/shells
      ! grep -q "${zsh_path}" /etc/shells && echo "${zsh_path}" | $sudo_cmd tee -a /etc/shells
      ;;
    *) ;;
  esac

  # Change default shell to zsh
  chsh -s "$zsh_path"
}

setup_default_shells "$@"
