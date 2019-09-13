#
# Requires a script once
#
__SOURCED_SCRIPTS=()
require_once() {
  value=$1
  if [[ ! "${__SOURCED_SCRIPTS[@]}" =~ "${value}" ]]; then
    source "~/.shell/${value}-init.sh"
    __SOURCED_SCRIPTS+=(${value})
  fi
}

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
  if [[ -n ${ZSH_VERSION} ]]; then
    for file in ${~1}; do
      [ -f "$file" ] && source "$file"
    done
  else
    # NOTE: This does not work in bash
    for file in ${1}; do
      [ -f "$file" ] && source "$file"
    done
  fi
  unset file;
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
      # eval function name for profiling
      if [ -n "$PROFILE_STARTUP" ]; then
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

#
# Sources common shell scripts in ~/.shell
#
source_shell_scripts() {
  if [ -d "${HOME}/.shell" ]; then
    for file in ${HOME}/.shell/*.sh; do
      # eval function name for profiling
      if [ -n "$PROFILE_STARTUP" ]; then
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
