#!/bin/zsh

# Bootstrap
source $DOTFILES/init.zsh
dotfiles_require 'brew'

echo "Updating Homebrew formulas ..."
brew update

# -------------------------------------------
# Install brews

brew_install_or_upgrade 'ansible'
brew_install_or_upgrade 'rbenv'
brew_install_or_upgrade 'ruby-build'
brew_install_or_upgrade 'qt'

brew_install_or_upgrade 'mysql'
brew_launchctl_restart 'mysql'

brew_install_or_upgrade 'redis'
brew_launchctl_restart 'redis'

brew_install_or_upgrade 'postgres'
brew_launchctl_restart 'postgres'
