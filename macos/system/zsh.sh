#!/usr/bin/env sh
#
# Install Z-Shell (ZSH)
#

# Brew install
brew install zsh

# Set ZSH as Default Shell
$ chsh -s $(which zsh)

# create a zshrc file
if [ ! -f "$HOME/.zshrc" ]; then
  touch "$HOME/.zshrc"

  # TODO: Write out sample zshrc file
fi

# Reload shell
source ~/.zshrc
