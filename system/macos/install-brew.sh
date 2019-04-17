#!/usr/bin/env sh
#
# Setup homebrew & brews
#

set -e

# Prompt for admin password upfront
sudo -v

# Make sure this is macOS
system_type=$(uname -s)
if ! [ "$system_type" = "Darwin" ]; then
  echo "Homebrew is only supported on macOS"
  exit 1
fi

# Install homebrew
if ! [ -x "$(command -v brew)" ]; then
  curl -fsS 'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby

  # Take owernship of /usr/local
  sudo chown -R "$USER":admin /usr/local

  # Install brews using brew bundle
  # NOTE: This uses the ~/Brewfile
  brew bundle --global
fi

# brew cask repair
# fork homebrew-cask to your account - only needed once
# cd "$(brew --repository)/Library/Taps/caskroom/homebrew-cask/Casks"
# hub fork
