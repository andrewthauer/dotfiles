#!/bin/zsh

# Bootstrap
source $DOTFILES/init.zsh
dotfiles_require 'brew'

# Setup permissions
sudo chown -R "$USER":admin /usr/local

# -------------------------------------------
# Install homebrew

if ! command -v brew >/dev/null; then
  echo "Installing Homebrew ..."
    curl -fsS 'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby
    # append_to_zshrc '# recommended by brew doctor'
    # append_to_zshrc 'export PATH="/usr/local/bin:$PATH"' 1
    export PATH="/usr/local/bin:$PATH"
else
  echo "Homebrew already installed. Skipping ..."
fi

echo "Updating Homebrew formulas ..."
brew update
brew upgrade

echo "Install Homebrew Services ..."
brew tap homebrew/services

echo "Install Caskroom ..."
brew_install_or_upgrade caskroom/cask/brew-cask
brew_tap caskroom/versions

echo "Install Caskroom Repair ..."
brew install vitorgalvao/tiny-scripts/cask-repair
