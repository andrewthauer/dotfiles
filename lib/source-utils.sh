# --------------------------------------------------------------
# Sourcing related helpers
# --------------------------------------------------------------

#
# Sources files only once
#
# examples:
#   source_file "/path/to/file.sh"
#
__SOURCED_FILES=()
source_file() {
  file=$1
  if [[ -f ${file} ]] && [[ ! "${__SOURCED_FILES[@]}" =~ "${file}" ]]; then
    source "$file"
    __SOURCED_FILES+=(${file})
  fi
}

#
# Sources files in a glob
#
# examples:
#   source_files_in ${XDG_CONFIG_HOME}/profile.d/*.sh
#
source_files_in() {
  for file in $@; do
    if [[ -n "$PROFILE_STARTUP" ]]; then
      # eval function name for profiling
      fn=`basename $file`
      eval "$fn() { source $file }; $fn"
    else
      source_file "$file"
    fi
  done

  unset file;
}

#
# Require a module once for the shell session
#
# examples:
#   require_once "utils"
#
require_once() {
  module=$1
  file="${XDG_CONFIG_HOME}/profile.d/${1}.sh"
  source_file "$file"
}
