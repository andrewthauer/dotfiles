#!/usr/bin/env bash
#
# Setup homebrew
#

set -e

# Prompt for admin password upfront
sudo -v

# Check if homebrew is installed
if [[ ! -x "$(command -v brew)" ]]; then
  # Take owernship of /usr/local
  sudo chown -R "$USER":admin /usr/local

  # Install homebrew or linuxbrew
  if [[ "$OSTYPE" == darwin* ]]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
  fi
fi

if [[ -x "$(command -v brew)" ]]; then
  # Install brews using brew bundle (uses the ~/.Brewfile)
  brew bundle --global
fi

# brew cask repair
# fork homebrew-cask to your account - only needed once
# cd "$(brew --repository)/Library/Taps/caskroom/homebrew-cask/Casks"
# hub fork
