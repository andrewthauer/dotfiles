#
# Core Utilities
#

#
# Sources files in a glob
#
# note:
#   source_files_in [dir] [?ext]
#
# examples:
#   source_files_in ${HOME}/.shell
#   source_files_in ${HOME}/.shell sh
#
source_files_in() {
  # $pattern=$1
  echo "$1"

  # for file in $(ls ${HOME}/.shell | grep "\\-init.sh" | sort); do

  if [ -n $ZSH_VERSION ]; then
    echo zsh
    echo $=~pattern
    for file in $=~1; do
      echo $file
      [ -f "$file" ] && source "$file"
    done
  elif [ -n $BASH_VERSION ]; then
    echo bash
    for file in $pattern; do
      [ -f "$file" ] && source "$file"
    done
  fi

  unset file;
}

#
# Sources common shell scripts in ~/.shell
#
source_shell_scripts() {
  if [ -d "${HOME}/.shell" ]; then
    for file in ${HOME}/.shell/*.sh; do
      # eval function name for profiling
      if [ -n "$ZPROF" ]; then
        fn=`basename $file`
        eval "$fn() { source $file }; $fn"
      else
        [ -f "$file" ] && source "$file"
      fi
    done

    unset file;
  fi
  unset -f $0
}

# Sources bash specific scripts in ~/.bash
#
source_bash_scripts() {
  if [ -d "${HOME}/.bash" ]; then
    for file in ${HOME}/.bash/*.sh; do
      [ -f "$file" ] && source "$file"
    done
    unset file;
  fi
  unset -f $0
}

#
# Sources zsh specific scripts in ~/.zsh
#
source_zsh_scripts() {
  if [ -d "${HOME}/.zsh" ]; then
    for file in ${HOME}/.zsh/*.zsh; do
      [ -f "$file" ] && source "$file"
    done
    unset file;
  fi
  unset -f $0
}
