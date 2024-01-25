#!/usr/bin/env bash
# Summary:
#   Install & setup this dotfiles repo
#
# Usage:
#   ./install.sh
#
# Environmenet Variables:
#   DOTFILES_DIR                        The target directory for the dotfiles repo
#   DOTFILES_DISABLE_SUDO               Allow usage of sudo: 1 (no) or 0 (yes)
#
# Examples:
#   ./install.sh
#   DOTFILES_DIR="$HOME/my-dotfiles" ./install.sh
#   sh -c "$(curl -fsSL https://raw.githubusercontent.com/andrewthauer/dotfiles/main/install.sh)"

set -e

export DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
export DOTFILES_BIN="$DOTFILES_DIR/bin"
export DOTFILES_DISABLE_SUDO="${DOTFILES_DISABLE_SUDO:-0}"

clone_dotfiles() {
  if [[ ! -d "${DOTFILES_DIR}" ]]; then
    echo "Cloning dotfiles repo..."
    git clone "https://github.com/andrewthauer/dotfiles.git" "$DOTFILES_DIR"
  fi
}

# shellcheck disable=SC2317
backup_dotfiles() {
  # Rename existing dotfiles
  local files=(~/.profile ~/.bash_profile ~/.bashrc ~/.zlogin ~/.zlogout ~/.zshenv ~/.zprofile ~/.zshrc)

  # move existing files
  for file in "${files[@]}"; do
    if [[ -f "${file}" && ! -L "${file}" ]]; then
      mv "${file}" "${file}.bak"
    fi
  done
}

link_dotfile_modules() {
  local dotfiles_mod_cmd="$DOTFILES_BIN/dotfiles-module"

  # Link core dotfiles modules
  "$dotfiles_mod_cmd" add _stow _core zsh utility git

  # Link packager specific dotfiles
  case "$("$DOTFILES_BIN"/os-info --family)" in
    "macos")
      "$dotfiles_mod_cmd" add homebrew
      ;;
    *) ;;
  esac
}

main() {
  echo "DOTFILES_DIR: $DOTFILES_DIR"
  echo "DOTFILES_DISABLE_SUDO: $DOTFILES_DISABLE_SUDO"

  # clone the dotfiles (if needed)
  clone_dotfiles
  cd "$DOTFILES_DIR"

  # Install base tools
  "$DOTFILES_BIN"/pkg install stow
  "$DOTFILES_BIN"/pkg install zsh
  "$DOTFILES_DIR"/modules/zsh/install.sh
  "$DOTFILES_DIR"/modules/starship/install.sh

  # link dotfiles modules
  # backup_dotfiles
  link_dotfile_modules

  # TODO: determine how to work in devcontainers without prompting for sudo password
  # "$DOTFILES_BIN"/set-default-shells

  # TODO: Ensure repo is using the ssh remote
  pushd "${DOTFILES_DIR}" >/dev/null
  git remote set-url origin git@github.com:andrewthauer/dotfiles.git
  popd >/dev/null
}

# Run the script
main "$@"
exit 0
