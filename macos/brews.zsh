#!/usr/bin/env zsh
#
# Setup homebrew
#

# Setup permissions
sudo chown -R "$USER":admin /usr/local

#
# Install homebrew
#

if ! command -v brew >/dev/null; then
  echo "Installing Homebrew ..."
    curl -fsS 'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby
    export PATH="/usr/local/bin:$PATH"
else
  echo "Homebrew already installed. Skipping ..."
fi

echo "Updating Homebrew formulas ..."
brew update
brew upgrade

# Homebrew services
brew tap homebrew/services

# Homebrew cask
brew install caskroom/cask/brew-cask
brew tap caskroom/versions

# Homebrew repair
brew install vitorgalvao/tiny-scripts/cask-repair

#
# Install common brews
#

brew install 'curl'
brew install 'git'
brew install 'git-extras'
brew install 'ctags'
brew install 'httpie'
brew install 'imagemagick'
brew install 'tmux'
brew install 'the_silver_searcher'
brew install 'vim'

# text utils (i.e. envsubst)
brew install gettext
brew link gettext --force

#
# Common dev tools
#

brew install 'node'

brew install 'python'
brew install 'python3'
pip install virtualenv

brew install 'rbenv'
brew install 'ruby-build'

#
# Homebrew casks
#

# General apps
brew cask install 'firefoxdeveloperedition'
brew cask install 'google-chrome'
brew cask install 'keepassxc'
brew cask install 'keeweb'
brew cask install 'slate'

# Libraries
brew cask install 'flash'
brew cask install 'java'

# Dev tools
brew cask install 'atom'
brew cask install 'cheatsheet'
brew cask install 'dash'
brew cask install 'beyond-compare'
brew cask install 'docker'
brew cask install 'pgadmin'
brew cask install 'postico'
brew cask install 'sequel-pro'
brew cask install 'visual-studio-code'

# Other apps
brew cask install 'electrum'
brew cask install 'licecap'
brew cask install 'the-unarchiver'
brew cask install 'tunnelblick'
