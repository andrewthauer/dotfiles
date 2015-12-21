# Dotfiles helpers

alias dotfiles="$DOTFILES"

function dotfiles_source () {
  file=$1
  [ -s "$file" ] && source "$file"
}

function dotfiles_require () {
  mod=$1
  dotfiles_import_module "${DOTFILES}/${mod}"
}

function dotfiles_import_module () {
  moddir=$1
  setopt null_glob

  # if a directory wasn't given, assume they meant a DOTFILES module
  if [ ! -d $moddir ] ; then
    moddir=$DOTFILES/$moddir
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
  for file ($moddir/*.zsh); do
    [ -f $file ] && source $file
  done
}

function dotfiles_unexport_file () {
  grep '^function' $1 | awk '{print $2}' | xargs -n1 unfunction
}

function dotfiles_zgen_check_modules () {
  # report oh-my-zsh modules that could be taken from prezto instead
  zgen list | grep oh-my-zsh | awk '{print $2}' | xargs basename | while read omz_module ; do
    if [ -d $ZPREZTODIR/modules/$omz_module ] ; then
      -dots-alert-message "oh-my-zsh module $omz_module is also in prezto"
    fi
  done
}

function dotfiles_get_symlink_dir () {
  dir=$1
  root_dir=$2
  if [ "$dir" = "${root_dir}" ]; then
    dir="$HOME"
  else
    dir="$HOME/.${dir}"
  fi
  echo $dir
}

function dotfiles_symlink_dir () {
  root_dir=$1

  # Symlink rc files
  for file in ${root_dir}/**/*; do
    # handle directories
    if [ -d "$file" ] && [ "${file:t}" != "local" ]; then
      dir=$(dotfiles_get_symlink_dir ${file#${root_dir}/} ${root_dir})
      if [ ! -d "$dir" ]; then
        echo "Creating directory '${dir}'"
        mkdir "$dir"
      fi
    fi

    # handle root files
    if [ "${file:e}" = "symlink" ]; then
      dir="${file:h}"
      dir=$(dotfiles_get_symlink_dir ${dir#${root_dir}/} ${root_dir})
      dotfiles_symlink_file $file $dir
    fi
  done
}

function dotfiles_symlink_file () {
  rcfile=$1
  dest_dir=$2

  # Default to home
  [ -z "$dest_dir" ] && dest_dir=$HOME

  # Prefix file with '.' if dir is ~
  prefix=""
  [ "$dest_dir" = $HOME ] && prefix="."

  # Setup RC file symlinks
  src=$(cd $(dirname $rcfile); pwd)/$(basename $rcfile)
  dest="$dest_dir/$prefix$(basename $src .symlink)"

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
