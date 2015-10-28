#!/bin/zsh

# Bootstrap
source $DOTFILES/init.zsh
dotfiles_require 'brew'

echo "Updating Homebrew formulas ..."
brew update

# -------------------------------------------
# Install caskroom apps

brew_cask_install_or_upgrade 'cheatsheet'
brew_cask_install_or_upgrade 'firefoxdeveloperedition'
brew_cask_install_or_upgrade 'flash'
brew_cask_install_or_upgrade 'google-chrome'
brew_cask_install_or_upgrade 'keepassx'
brew_cask_install_or_upgrade 'screenhero'
brew_cask_install_or_upgrade 'slack'
brew_cask_install_or_upgrade 'slate'
brew_cask_install_or_upgrade 'spotify'
brew_cask_install_or_upgrade 'the-unarchiver'
