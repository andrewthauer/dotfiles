#!/bin/zsh

# Bootstrap
source $DOTFILES/init.zsh
dotfiles_require 'brew'

echo "Updating Homebrew formulas ..."
brew update

# -------------------------------------------
# Install brews

brew_install_or_upgrade 'postgres'
brew_launchctl_restart 'postgres'

brew_cask_install_or_upgrade 'pgadmin'
brew_cask_install_or_upgrade 'postico'
