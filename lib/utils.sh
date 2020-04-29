# --------------------------------------------------------------
# Various utility functions
#
# These are used by other packages so this file must be
# sourced before other packages are loaded.
#
# shellcheck disable=SC2148
# --------------------------------------------------------------

if [[ -n "${ZSH_VERSION}" ]]; then
  # Do not throw errors when file globs do not match anything
  setopt NULL_GLOB
fi

#
# Check if a command exists
#
# usage:
#   command_exists "command"
#
# example:
#   command_exists "node" && echo "exists!"
#
function command_exists() {
  # use fastest shell specific method
  if [[ -n "$ZSH_VERSION" ]]; then
    # shellcheck disable=SC2203,SC2193
    [[ $+commands[$1] == 1 ]]
  else
    command -v "$1" >/dev/null 2>&1
  fi
}

#
# Checks if a function exists
#
# usage:
#   function_exists "func_name"
#
# example:
#   function_exists "command_exists" && echo "exists!"
#
function function_exists() {
  # declare -f -F "$1" > /dev/null 2>&1
  typeset -f "$1" >/dev/null 2>&1
}

#
# Prepends a path to the path variable (avoiding duplicates)
#
# usage:
#   prepend_path [path_to_prepend]
#   prepend_path [first_path] [second_path]
#
# examples:
#   prepend_path "/some/path"
#   # PATH="/some/path:/usr/bin:/bin"
#
#   prepend_path "/path/abc" "/path/xyz"
#   # PATH="/path/abc:/path/xyz:/usr/bin:/bin"
#
function prepend_path() {
  paths=("$1")
  for ((i = $#; i > 0; i--)); do
    arg=${paths[i]}
    if [ -d "$arg" ] && [[ ":$PATH:" != *":$arg:"* ]]; then
      PATH="$arg${PATH:+":$PATH"}"
    fi
  done
}

#
# Appends paths to the path variable (avoiding duplicates)
#
# usage:
#   append_path [path_to_append]
#   append_path [first_path] [second_path]
#
# examples:
#   append_path "/some/path"
#   # PATH="/usr/bin:/bin:/some/path"
#
#   append_path "/path/abc" "/path/xyz"
#   # PATH="/usr/bin:/bin:/path/abc:/path/xyz"
#
function append_path() {
  for arg in "$@"; do
    if [ -d "$arg" ] && [[ ":$PATH:" != *":$arg:"* ]]; then
      PATH="${PATH:+"$PATH:"}$arg"
    fi
  done
}

#
# Sources files only once
#
# examples:
#   source_file "/path/to/file.sh"
#
__SOURCED_FILES=()
source_file() {
  file=$1
  if [[ -f ${file} ]] && [[ ! "${__SOURCED_FILES[*]}" =~ ${file} ]]; then
    # shellcheck disable=SC1090
    source "$file"
    __SOURCED_FILES+=("${file}")
  fi
}

#
# Sources files in a glob
#
# examples:
#   source_files_in ${XDG_CONFIG_HOME}/profile.d/*.sh
#
source_files_in() {
  for file in "$@"; do
    if [[ -n "$PROFILE_STARTUP" ]]; then
      # eval function name for profiling
      fn=$(basename "$file")
      eval "$fn() { source_file $file }; $fn"
    else
      source_file "$file"
    fi
  done

  unset file
}

#
# Source a shared library module (once)
#
# examples:
#   source_shell_lib "some_lib"
#
source_shell_lib() {
  # module="$1"
  file="${HOME}/.local/lib/${1}.sh"
  source_file "$file"
}

#
# lazy load function helper
#
# usage:
#   lazyfunc [lazy_function] [commands_to_hook...]
#
# example:
#   lazyfunc _nodenv_init nodenv node npm
#
function lazyfunc() {
  local lazyfunc="$1"
  local hooks=("${@:2}")

  for cmd in "${hooks[@]}"; do
    eval "${cmd}() { __lazyfunc_exec ${lazyfunc} ${hooks[*]}; ${cmd} \$@; }"
  done
}

#
# lazy load function executor
#
# usage:
#   __lazyfunc_exec [lazy_function] [commands_to_hook...]
#
__lazyfunc_exec() {
  local lazyfunc=$1
  local hooks=("${@:2}")
  unset -f "${hooks[@]}"
  eval "${lazyfunc}"
  unset "${lazyfunc}"
}
