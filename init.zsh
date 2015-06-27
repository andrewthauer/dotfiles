# Export dot files dir
export DOTFILES="$HOME/.dotfiles"

# Source some helper functions
if [ -s "$DOTFILES/modules/dotfiles/dotfiles.zsh" ]; then
  source "$DOTFILES/modules/dotfiles/dotfiles.zsh"
fi

# Source some functions
dotfiles_source "$DOTFILES/modules/zsh/functions/autoload-fpath"
autoload-fpath $DOTFILES/modules/zsh/functions
