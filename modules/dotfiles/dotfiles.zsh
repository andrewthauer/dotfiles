# module def:   (look at oh-my-zsh and prezto, can we merge/incorporate?)
#   bin/*                   install or symlink?
#   topic/*.zsh             source
#   fpath                   function autoloads
#   topic/path.zsh          builds path
#   topic/completion.zsh    adds completions (look at prezto/oh-my-zsh)
#   topic/*.symlink         copy in as symlinks
#
#   * ability to partially include (completions, but not aliases, for example)
#   * look at command history on startup to suggest modules to add from list-modules ('suggest' module)
#   * check aliases when commands are run to see if one could have been used ('suggest' module)

function dotfiles-import-local-module () {
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
