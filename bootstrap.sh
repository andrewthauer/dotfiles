#!/bin/zsh

# Export dot files dir
export DOTFILES="$HOME/.dotfiles"

# Create symlink to this directory
if [ ! -d "$DOTFILES" ] && [ ! -L "$DOTFILES" ]; then
  ln -s $(pwd) "$DOTFILES"
fi

# Bootstrap
[ -s "init.zsh" ] && source "init.zsh"

get_dotfile_dir() {
  dir=$1
  if [ "$dir" = "./rc" ]; then
    dir="$HOME"
  else
    dir="$HOME/.${dir}"
  fi
  echo $dir
}

# Symlink rc files
for rcfile in ./rc/**/*; do
  # handle directories
  if [ -d "$rcfile" ] && [ "${rcfile:t}" != "local" ]; then
    dir=$(get_dotfile_dir ${rcfile#./rc/})
    if [ ! -d "$dir" ]; then
      echo "Creating directory '${dir}'"
      mkdir "$dir"
    fi
  fi

  # handle root files
  if [ "${rcfile:e}" = "symlink" ]; then
    dir="${rcfile:h}"
    dir=$(get_dotfile_dir ${dir#./rc/})
    dotfiles_symlink_file $rcfile $dir
  fi
done

# Create symlink to prezto
dotfiles_require 'zgen'
if [ -d "$ZPREZTODIR" ]; then
  rm "$HOME/.zprezto"
  ln -s "$ZPREZTODIR" "$HOME/.zprezto"
fi

# Reload zsh
echo "Restart your shell"
