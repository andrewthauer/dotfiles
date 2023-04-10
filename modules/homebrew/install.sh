#!/usr/bin/env bash
#
# Setup homebrew
#

set -e

# Check if homebrew is installed
if [[ ! -x "$(command -v brew)" ]]; then
  echo "Installing homebrew..."

  # Install homebrew
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install brews using brew bundle (uses the Brewfile)
if [[ -x "$(command -v brew)" ]]; then
  printf "Do you want run brew bundle [y/N]? "
  read -r answer
  case "${answer}" in [yY] | [yY][eE][sS])
    brewfile="${DOTFILES_DIR}/.config/homebrew/Brewfile"
    HOMEBREW_BUNDLE_FILE="$brewfile" brew bundle
    ;;
  esac
fi
