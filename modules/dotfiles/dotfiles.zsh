function dotfiles-source () {
  file=$1
  [ -s "$file" ] && source "$file"
}

function dotfiles-require () {
  mod=$1
  dotfiles-import-module "${DOTFILES}/modules/${mod}"
}

function dotfiles-import-module () {
  moddir=$1

  setopt null_glob

  # if a directory wasn't given, assume they meant a DOTFILES module
  if [ ! -d $moddir ] ; then
    moddir=$DOTFILES/modules/$moddir
  fi

  # autoload functions
  [ -d "$moddir/functions" ] && {
    autoload-fpath $moddir/functions
  }

  # add bin dir to path
  [ -d "$moddir/bin" ] && {
    prepend-path $moddir/bin
  }

  # source zsh files
  for file ($moddir/*.zsh) ; do
    [ -f $file ] && source $file
  done
}

function dotfiles-unexport-file () {
  grep '^function' $1 | awk '{print $2}' | xargs -n1 unfunction
}

function dotfiles-zgen-check-modules () {
  # report oh-my-zsh modules that could be taken from prezto instead
  zgen list | grep oh-my-zsh | awk '{print $2}' | xargs basename | while read omz_module ; do
    if [ -d $ZPREZTODIR/modules/$omz_module ] ; then
      -dots-alert-message "oh-my-zsh module $omz_module is also in prezto"
    fi
  done
}

function dotfiles-symlink-file () {
  rcfile=$1
  dest_dir=$HOME

  # Setup RC file symlinks
  src=$(cd $(dirname $rcfile); pwd)/$(basename $rcfile)
  dest="$dest_dir/.$(basename $src .symlink)"

  # Remove existing symlinks
  if [ -L "$dest" ]; then
    echo "Removing symlink for $dest"
    rm $dest
  fi

  # Create new symlink
  if [ -f "$rcfile" ]; then
    echo "Symlinking '$src' to '$dest'"
    ln -s "$src" "$dest"
  fi
}
