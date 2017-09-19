#!/usr/bin/env sh
#
# Homebrew
#

# Setup permissions
sudo chown -R "$USER":admin /usr/local

# Install homebrew
if ! command -v brew >/dev/null; then
  echo "Installing Homebrew ..."
    curl -fsS 'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby
    export PATH="/usr/local/bin:$PATH"
else
  echo "Homebrew already installed. Skipping ..."
fi

# Update homebrew
brew update

# Install homebrew-services
brew tap homebrew/services

# Install homebrew-cask
brew tap caskroom/cask

# Install homebrew-caskroom versions
brew tap caskroom/versions
