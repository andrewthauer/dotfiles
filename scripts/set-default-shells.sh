#!/usr/bin/env bash
# Summary:
#   Registers shells and sets the default shell

set -e

DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." &>/dev/null && pwd)"
source "${DOTFILES_HOME}/lib/xdg.sh"
PATH="${DOTFILES_HOME}/bin:${XDG_BIN_HOME}:${PATH}"

add_shell() {
  local shell_path="$1"
  local shell="$2"

  if [ ! -f "$shell_path" ]; then
    echo "Warning: shell $shell not found"
    return 0
  fi

  # disable usage of sudo if requested
  [[ "$DOTFILES_NO_SUDO" -eq 0 ]] && sudo_cmd="sudo" || sudo_cmd=""

  case "$(os-info --family)" in
    *)
      if grep -qF "${shell_path}" /etc/shells && echo "${shell_path}" >/dev/null; then
        echo "Shell $shell_path already found in /etc/shells"
      else
        echo "Adding $shell_path to /etc/shells"
        echo "${shell_path}" | "$sudo_cmd" tee -a /etc/shells
      fi
      ;;
  esac

  return 0
}

set_default_shell() {
  local shell_path="$1"

  if [ ! -f "$shell_path" ]; then
    echo "Shell path $shell_path does not exist"
    return 1
  fi

  echo "Changing default shell to $shell_path"
  case "$(os-info --os)" in
    darwin) chsh -s "$shell_path" ;;
    *) chsh -s "$shell_path" ;;
  esac
}

main() {
  # Default to zsh
  local default_shell="${1:-zsh}"

  # registers shells with os (e.g. /etc/shells)
  add_shell "$(which bash 2>/dev/null | head -1 | tr -d "\n")" "bash"
  add_shell "$(which zsh 2>/dev/null | head -1 | tr -d "\n")" "zsh"
  add_shell "$(which fish 2>/dev/null | head -1 | tr -d "\n")" "fish"
  add_shell "$(which nu 2>/dev/null | head -1 | tr -d "\n")" "nu"

  # Change default shell
  set_default_shell "$(which "$default_shell" | head -1)"
}

main "$@"
