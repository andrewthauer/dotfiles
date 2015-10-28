#!/bin/zsh

# Bootstrap
source $DOTFILES/init.zsh
dotfiles_require 'brew'

echo "Updating Homebrew formulas ..."
brew update

# -------------------------------------------
# Install brews

brew_install_or_upgrade 'mysql'
brew_launchctl_restart 'mysql'

brew_cask_install_or_upgrade 'mysqlworkbench'
