# Export dot files dir
export DOTFILES="$HOME/.dotfiles"

# Create symlink to this directory
if [ ! -d "$DOTFILES" ] && [ ! -L "$DOTFILES" ]; then
  ln -s . "$DOTFILES"
fi

# Bootstrap
source ../bootstrap.zsh

# Create symlink to prezto
dotfiles-require 'zgen'
if [ -d "$ZPREZTODIR" ]; then
  rm "$HOME/.zprezto"
  ln -s "$ZPREZTODIR" "$HOME/.zprezto"
fi

# Symlink rc files
for rcfile in ./rc*.symlink; do
  dotfiles-symlink-file $rcfile
done

# Reload zsh
echo "Restart your shell"
