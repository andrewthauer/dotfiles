#!/usr/bin/env bash

set -eou pipefail

DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &>/dev/null && pwd)"
PATH="$DOTFILES_HOME/bin:$PATH"

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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
  local brewfile="${CURRENT_DIR}/.config/homebrew/Brewfile"
  HOMEBREW_BUNDLE_FILE="$brewfile" brew bundle
}

main() {
  case "$(os-info --family)" in
    "macos")
      install_homebrew
      dotfiles module add homebrew
      install_brews
      ;;
    *)
      echo "Not implemented for this OS"
      exit 1
      ;;
  esac
}

main "$@"
