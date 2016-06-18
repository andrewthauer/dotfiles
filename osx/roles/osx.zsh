#!/bin/zsh

# Bootstrap
source $DOTFILES/init.zsh
dotfiles_require 'brew'

# -------------------------------------------
# Install brew casks

brew_cask_install_or_upgrade 'cheatsheet'
brew_cask_install_or_upgrade 'flash'
brew_cask_install_or_upgrade 'firefoxdeveloperedition'
brew_cask_install_or_upgrade 'electrum'
brew_cask_install_or_upgrade 'keepassx'
brew_cask_install_or_upgrade 'google-chrome'
brew_cask_install_or_upgrade 'java'
brew_cask_install_or_upgrade 'licecap'
brew_cask_install_or_upgrade 'logitech-myharmony'
brew_cask_install_or_upgrade 'omnigraffle'
brew_cask_install_or_upgrade 'skype'
brew_cask_install_or_upgrade 'slack'
brew_cask_install_or_upgrade 'slate'
brew_cask_install_or_upgrade 'spotify'
brew_cask_install_or_upgrade 'steam'
brew_cask_install_or_upgrade 'the-unarchiver'
brew_cask_install_or_upgrade 'tunnelblick'
brew_cask_install_or_upgrade 'vlc'
