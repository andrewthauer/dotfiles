# --------------------------------------------------------------
# Various utility functions
#
# These are used by other packages so this file must be
# sourced before other packages are loaded.
# --------------------------------------------------------------

if [ -n "${ZSH_VERSION}" ]; then
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
  # shellcheck disable=SC1009
  if [ -n "$ZSH_VERSION" ]; then
    # shellcheck disable=SC2193,SC2203
    [[ $+commands[$1] == 1 ]]
  else
    command -v "$1" >/dev/null 2>&1
  fi
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
  i=$#
  while [ "$i" -gt 0 ]; do
    eval "dir=\${$i}"
    # shellcheck disable=SC2154
    case ":$PATH:" in
      *":$dir:"*) ;;
      *) PATH="$dir${PATH:+:$PATH}" ;;
    esac
    i=$((i - 1))
  done
  export PATH
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
  for dir; do
    case ":$PATH:" in
      *":$dir:"*) ;;
      *) PATH="${PATH:+$PATH:}$dir" ;;
    esac
  done
  export PATH
}

#
# Sources files only once
#
# examples:
#   source_file "/path/to/file.sh"
#
__SOURCED_FILES=()
source_file() {
  local file=$1
  if [ -f "${file}" ] && [[ ! "${__SOURCED_FILES[*]}" =~ ${file} ]]; then
    [ -n "$DOTFILES_TRACE" ] && echo "sourcing: ${file}"

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
    if [ -n "$PROFILE_STARTUP" ]; then
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
# Export all environment files in a glob
#
# examples:
#   export_env_files_in ${XDG_CONFIG_HOME}/environment.d/*.conf
#
export_env_files_in() {
  for file in "$@"; do
    export_env_file "$file"
  done

  unset file
}

#
# Export all name=value pairs in a file
#
# examples:
#   export_env_files_in ${XDG_CONFIG_HOME}/environment.d/*.conf
#
# @see https://gist.github.com/mihow/9c7f559807069a03e302605691f85572
#
export_env_file() {
  file="${1}"

  if [ -f "$file" ]; then
    set -o allexport
    source_file "$file"
    set +o allexport
  fi

  unset file
}
