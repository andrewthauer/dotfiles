#!/usr/bin/env bash
# Summary:
#   Registers shells and sets the default shell

set -e

add_shell() {
  local shell_path="$1"

  if [ ! -f "$shell_path" ]; then
    echo "Warning: shell $shell_path not found"
    return 1
  fi

  # disable usage of sudo if requested
  [[ "$DOTFILES_DISABLE_SUDO" -eq 0 ]] && sudo_cmd="sudo " || sudo_cmd=""

  case "$("$DOTFILES_DIR"/bin/os-info --family)" in
    *)
      if grep -qF "${shell_path}" /etc/shells && echo "${shell_path}" >/dev/null; then
        echo "Shell $shell_path already found in /etc/shells"
      else
        echo "Adding $shell_path to /etc/shells"
        $sudo_cmd tee -a /etc/shells
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

  # disable usage of sudo if requested
  [[ "$DOTFILES_DISABLE_SUDO" -eq 0 ]] && sudo_cmd="sudo " || sudo_cmd=""

  case "$("$DOTFILES_DIR"/bin/os-info --os)" in
    darwin)
      echo "Changing default shell to $shell_path"
      chsh -s "$shell_path"
      ;;
    *)
      echo "Unsupported OS: Unable to change default shell"
      ;;
  esac
}

main() {
  local default_shell="${1:-zsh}"

  # registers shells with os (e.g. /etc/shells)
  add_shell "$(which bash | head -1 | tr -d "\n")"
  add_shell "$(which zsh | head -1 | tr -d "\n")"
  add_shell "$(which nu | head -1 | tr -d "\n")"

  # Change default shell to zsh
  set_default_shell "$(which "$default_shell" | head -1)"
}

main "$@"
