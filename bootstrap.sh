#!/bin/zsh

# Export dot files dir
export DOTFILES="$HOME/.dotfiles"

# Create symlink to this directory
if [ ! -d "$DOTFILES" ] && [ ! -L "$DOTFILES" ]; then
  ln -s $(pwd) "$DOTFILES"
fi

# Bootstrap
[ -s "init.zsh" ] && source "init.zsh"

# Symlink directories
dotfiles_symlink_dir "./rc"
dotfiles_symlink_dir "./secrets"

# Create symlink to prezto
dotfiles_require 'zgen'
if [ -d "$ZPREZTODIR" ]; then
  rm "$HOME/.zprezto"
  ln -s "$ZPREZTODIR" "$HOME/.zprezto"
fi

# Reload zsh
echo "Restart your shell"
