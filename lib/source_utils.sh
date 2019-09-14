#
# Sources files only once
#
__SOURCED_FILES=()
source_file() {
  file=$1
  if [ -f ${file} ] && [[ ! "${__SOURCED_FILES[@]}" =~ "${file}" ]]; then
    source "$file"
    __SOURCED_FILES+=(${file})
  fi
}

#
# Require a module once for the shell session
#
require_once() {
  module=$1
  file="${HOME}/.shell/${1}-init.sh"
  source_file "$file"
}

#
# Sources files in a glob
#
# examples:
#   source_files_in ${HOME}/.shell
#   source_files_in ${HOME}/.shell sh
#
source_files_in() {
  if [[ -n ${ZSH_VERSION} ]]; then
    for file in ${~1}; do
      source_file "$file"
    done
  else
    # TODO/FIX: This does not work in bash
    for file in ${1}; do
      source_file "$file"
    done
  fi

  unset file;
}

#
# Sources bash specific scripts in ~/.bash
#
source_bash_scripts() {
  if [[ ! -d "${HOME}/.bash" ]]; then
    return 1
  fi

  for file in ${HOME}/.bash/*.sh; do
    source_file "$file"
  done

  unset file;
  unset -f $0

  return 0
}

#
# Sources zsh specific scripts in ~/.zsh
#
source_zsh_scripts() {
  if [[ ! -d "${HOME}/.zsh" ]]; then
    return 1
  fi

  for file in ${HOME}/.zsh/*.zsh; do
    if [ -n "$PROFILE_STARTUP" ]; then
      # eval function name for profiling
      fn=`basename $file`
      eval "$fn() { source $file }; $fn"
    else
      [ -f "$file" ] && source_file "$file"
    fi
  done

  unset file;
  unset -f $0

  return 0
}

#
# Sources common shell scripts in ~/.shell
#
source_shell_scripts() {
  if [[ ! -d "${HOME}/.shell" ]]; then
    return 1
  fi

  for file in ${HOME}/.shell/*.sh; do
    if [ -n "$PROFILE_STARTUP" ]; then
      # eval function name for profiling
      fn=$(basename $file)
      eval "$fn() { source $file }; $fn"
    else
      source_file "$file"
    fi
  done

  unset file;
  unset -f $0

  return 0
}
