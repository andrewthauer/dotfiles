#!/usr/bin/env bash
# Summary:
#   Registers shells and sets the default shell

set -e

add_shell() {
  local shell_path="$1"

  if [ ! -f "$shell_path" ]; then
    echo "Shell path $shell_path does not exist"
    return 1
  fi

  # disable usage of sudo if requested
  [[ "$DOTFILES_DISABLE_SUDO" -eq 0 ]] && sudo_cmd="sudo " || sudo_cmd=""

  case "$("$DOTFILES_BIN"/os-info --family)" in
    "macos")
      ! grep -q "${shell_path}" /etc/shells && echo "${shell_path}" | $sudo_cmd tee -a /etc/shells
      ;;
    *) ;;
  esac

  return 0
}

set_default_shell() {
  local shell_path="$1"

  if [ ! -f "$shell_path" ]; then
    echo "Shell path $shell_path does not exist"
    return 1
  fi

  # Change default shell to zsh
  chsh -s "$zsh_path"
}

main() {
  local default_shell="${1:-zsh}"

  # registers shells with os (e.g. /etc/shells)
  add_shell "$(which bash | head -1)"
  add_shell "$(which zsh | head -1)"
  add_shell "$(which nu | head -1)"

  # Change default shell to zsh
  set_default_shell "$(which "$default_shell" | head -1)"
}

main "$@"
