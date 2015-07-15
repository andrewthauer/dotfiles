#!/bin/sh

# Bootstrap
source ../init.zsh
dotfiles_require 'brew'

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

# -------------------------------------------
# Install brews

brew_install_or_upgrade 'ansible'
brew_install_or_upgrade 'ctags'
brew_install_or_upgrade 'git'
brew_install_or_upgrade 'imagemagick'
brew_install_or_upgrade 'node'
brew_install_or_upgrade 'nvm'
brew_install_or_upgrade 'rbenv'
brew_install_or_upgrade 'ruby-build'
brew_install_or_upgrade 'qt'
brew_install_or_upgrade 'vim'

brew_install_or_upgrade 'mysql'
brew_launchctl_restart 'mysql'

brew_install_or_upgrade 'redis'
brew_launchctl_restart 'redis'

# -------------------------------------------
# Install caskroom & apps

brew_install_or_upgrade caskroom/cask/brew-cask
brew_tap caskroom/versions
brew_cask_install_or_upgrade 'atom'
brew_cask_install_or_upgrade 'beyond-compare'
brew_cask_install_or_upgrade 'browserstacklocal'
brew_cask_install_or_upgrade 'cheatsheet'
brew_cask_install_or_upgrade 'firefoxdeveloperedition'
brew_cask_install_or_upgrade 'dash'
brew_cask_install_or_upgrade 'flash'
brew_cask_install_or_upgrade 'github'
brew_cask_install_or_upgrade 'google-chrome'
brew_cask_install_or_upgrade 'keepassx'
brew_cask_install_or_upgrade 'macvim'
brew_cask_install_or_upgrade 'mysqlworkbench'
brew_cask_install_or_upgrade 'rubymine'
brew_cask_install_or_upgrade 'screenhero'
brew_cask_install_or_upgrade 'sequel-pro'
brew_cask_install_or_upgrade 'slack'
brew_cask_install_or_upgrade 'slate'
brew_cask_install_or_upgrade 'spotify'
brew_cask_install_or_upgrade 'the-unarchiver'
brew_cask_install_or_upgrade 'sublime-text3'
brew_cask_install_or_upgrade 'vagrant'
brew_cask_install_or_upgrade 'vagrant-manager'
brew_cask_install_or_upgrade 'virtualbox'
brew_cask_install_or_upgrade 'visual-studio-code'
