#!/bin/zsh

# Bootstrap
source $DOTFILES/init.zsh
dotfiles_require 'brew'

echo "Updating Homebrew formulas ..."
brew update

# -------------------------------------------
# Install brews

brew_install_or_upgrade 'git-extras'
brew_install_or_upgrade 'ansible'
brew_install_or_upgrade 'ctags'
brew_install_or_upgrade 'imagemagick'
brew_install_or_upgrade 'qt'
brew_install_or_upgrade 'vim'

# -------------------------------------------
# Install caskroom apps

brew_cask_install_or_upgrade 'atom'
brew_cask_install_or_upgrade 'beyond-compare'
brew_cask_install_or_upgrade 'browserstacklocal'
brew_cask_install_or_upgrade 'dash'
brew_cask_install_or_upgrade 'github'
brew_cask_install_or_upgrade 'macvim'
brew_cask_install_or_upgrade 'rubymine'
brew_cask_install_or_upgrade 'sequel-pro'
brew_cask_install_or_upgrade 'sublime-text3'
brew_cask_install_or_upgrade 'vagrant'
brew_cask_install_or_upgrade 'vagrant-manager'
brew_cask_install_or_upgrade 'virtualbox'
brew_cask_install_or_upgrade 'visual-studio-code'
