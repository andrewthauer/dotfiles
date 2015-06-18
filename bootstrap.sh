# Export dot files dir
export DOTFILES="$HOME/.dotfiles"

# Source some helper function (realpath)
source ./modules/shell/shell.zsh

# Create symlink to this directory
if [ ! -d "$DOTFILES" ] && [ ! -L "$DOTFILES" ]; then
  ln -s . "$DOTFILES"
fi

# Create symlink to prezto
prezto=$HOME/.zgen/sorin-ionescu/prezto-master
if [ -d "$prezto" ]; then
  ln -s "$prezto" "$HOME/.zprezto"
fi

# Setup RC file symlinks
for rcfile in ./rc/*.symlink; do
  src=$(realpath $rcfile)
  dest="$HOME/.$(basename $src .symlink)"

  # TODO - handle sub directories

  # Remove existing symlinks
  if [ -L "$dest" ]; then
    echo "Removing symlink for ${dest}"
    rm $dest
  fi

  # Create new symlink
  if [ -f "$rcfile" ]; then
    echo "Symlinking '$src' to '$dest'"
    ln -s "$src" "$dest"
  fi
done

# Upodate your default shell to zsh
# chsh -s /bin/zsh

# Reload zsh
cd $HOME
reload
