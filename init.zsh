#!/bin/zsh

# Export dot files dir
export DOTFILES="$HOME/.dotfiles"

# Source some helper functions
if [ -s "$DOTFILES/dotfiles/dotfiles.zsh" ]; then
  source "$DOTFILES/dotfiles/dotfiles.zsh"
fi

# Source some functions
dotfiles_source "$DOTFILES/zsh/functions/autoload-fpath"
autoload-fpath $DOTFILES/zsh/functions
