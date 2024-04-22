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

set -eo pipefail

export DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
export DOTFILES_BIN="$DOTFILES_DIR/bin"
export DOTFILES_DISABLE_SUDO="${DOTFILES_DISABLE_SUDO:-0}"

clone_dotfiles() {
  if [ ! -d "${DOTFILES_DIR}" ]; then
    echo "Cloning dotfiles repo..."
    git clone "https://github.com/andrewthauer/dotfiles.git" "$DOTFILES_DIR"

    # Ensure repo is using the ssh remote
    pushd "${DOTFILES_DIR}" >/dev/null
    git remote set-url origin git@github.com:andrewthauer/dotfiles.git
    popd >/dev/null
  fi
}

install_core_packages() {
  # Install os specific packages
  case "$("$DOTFILES_BIN"/os-info --family)" in
    "macos")
      "$DOTFILES_MODULES_DIR/homebrew/install.sh"
      # shellcheck disable=SC1091
      source "$DOTFILES_MODULES_DIR/homebrew/.config/homebrew/shellenv.sh"
      ;;
    *) ;;
  esac

  # Install core packages
  "$DOTFILES_BIN"/pkg install stow
  "$DOTFILES_BIN"/pkg install bash
  "$DOTFILES_BIN"/pkg install zsh
  "$DOTFILES_BIN"/pkg install neovim

  # Install dotfiles support tools
  "$DOTFILES_MODULES_DIR"/zsh/install.sh
  "$DOTFILES_MODULES_DIR"/starship/install.sh
}

# shellcheck disable=SC2317
backup_dotfiles() {
  # Rename existing dotfiles
  local files=(~/.bash_profile ~/.bashrc ~/.zshenv ~/.zshrc)

  # move existing files
  for file in "${files[@]}"; do
    if [ -f "${file}" ] && [ ! -L "${file}" ]; then
      mv "${file}" "${file}.bak"
    fi
  done
}

link_dotfile_modules() {
  # Link core dotfiles modules
  for module in _stow _core bash zsh utility git; do
    "$DOTFILES_BIN"/dotfiles mod link "$module" || echo "Failed to link module: $module"
  done

  # Link packager specific dotfiles
  case "$("$DOTFILES_BIN"/os-info --family)" in
    "macos")
      "$DOTFILES_BIN"/dotfiles mod link homebrew
      ;;
    *) ;;
  esac
}

main() {
  echo "DOTFILES_DIR: $DOTFILES_DIR"
  echo "DOTFILES_DISABLE_SUDO: $DOTFILES_DISABLE_SUDO"

  clone_dotfiles
  source "${DOTFILES_DIR}"/lib/init.sh
  pushd "${DOTFILES_DIR}" >/dev/null
  install_core_packages
  backup_dotfiles
  link_dotfile_modules
  bin/set-default-shells
  popd >/dev/null
}

# Run the script
main "$@"
exit 0
