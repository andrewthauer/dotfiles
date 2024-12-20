#!/usr/bin/env bash
#
# Setup homebrew
#

set -e

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_BIN="${DOTFILES_DIR:-$HOME/.dotfiles}/bin"

install_homebrew() {
  echo "Checking if homebrew is installed..."

  # Load homebrew shellenv to see if it's installed
  # shellcheck disable=SC1091
  source "$CURRENT_DIR"/.config/homebrew/shellenv.sh

  # Check if homebrew is installed
  if [ -x "$(command -v brew)" ]; then
    echo "Homebrew is already installed."
    return
  fi

  echo "Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

install_brews() {
  # Install brews using brew bundle (uses the Brewfile)
  if [ -x "$(command -v brew)" ]; then
    printf "Do you want run brew bundle [y/N]? "
    read -r answer
    case "${answer}" in [yY] | [yY][eE][sS])
      brewfile="${DOTFILES_DIR}/.config/homebrew/Brewfile"
      HOMEBREW_BUNDLE_FILE="$brewfile" brew bundle
      ;;
    esac
  fi
}

main() {
  case "$("$DOTFILES_BIN"/os-info --family)" in
    "macos")
      install_homebrew
      # install_brews
      ;;
    *) ;;
  esac
}

main "$@"
