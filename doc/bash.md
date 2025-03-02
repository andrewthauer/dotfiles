# Bash

## Snippets

## Absolute Directory Name

```sh
# Summary:
#   Returns the absolute path
#
# Usage:
#   abs-dirname path/to
abs_dirname() {
  local path
  path="$(realpath "$1")"
  echo "${path%/*}"
}
```

### Command Exists

```sh
# Summary:
#   Check if a command exists
#
# Usage:
#   command-exists "cmd_name"
command_exists() {
  local cmd_name=$1
  [ -z "$cmd_name" ] && return 1
  command -v "$cmd_name" >/dev/null 2>&1
  return $?
}
```

### Contains

```sh
# Summary:
#   Checks one string is contained in the other
#
# Usage:
#   contains string substring
#
# Returns:
#   Returns 0 if the specified string contains the specified substring,
#   otherwise returns 1.
contains() {
  local string="$1"
  local substring="$2"

  if test "${string#*"$substring"}" != "$string"; then
    return 0 # $substring is in $string
  else
    return 1 # $substring is not in $string
  fi
}
```

### Favicon

```sh
#!/usr/bin/env bash
# Summary:
#   Create a favicon
#
# Usage:
#   favicon /path/to/image

file=$1

if [ -z "$file" ]; then
  echo "No source file provided"
  exit 1
fi

if [ ! -x "$(command -v convert)" ]; then
  echo "ImageMagick not installed"
  exit 1
fi
convert "$file" -define icon:auto-resize=64,48,32,16 favicon.ico
```

### Find Latest Backup Directory

```sh
# Summary:
#   Finds the latest file based on a pattern
#
# Usage:
#   find-latest ./directory/to/search "*pattern*"

# Simple pattern
# local pattern=$1
# ls -t $pattern | head -1
find_latest() {
  local dir=$1
  local pattern=$2

  [ -z "${dir}" ] && echo "Directory not provided" && return 1
  [ ! -d "${dir}" ] && echo "Directory does not exist" && return 1
  [ -z "${pattern}" ] && echo "Pattern not provided" && return 1

  # glob directory -> filter by pattern -> sort by date -> one result
  # shellcheck disable=SC2016
  ls "${dir}"/**/*(e:'[[ $REPLY =~ ${pattern} ]]':.om[1])
}
```

### Function Exists

```sh
# Summary:
#   Check if a function exists
#
# Usage:
#   function-exists "func_name"
function_exists() {
  local function_name=$1
  [ -z "$function_name" ] && return 1
  declare -F "$function_name" >/dev/null 2>&1
  return $?
}
```

### Join By

```sh
# Summary:
#   Joins the args >= 2 by the first arg delimeter
#
# Usage:
#   join_by , a "b c" d #a,b c,d
#   join_by / var local tmp #var/local/tmp
#   join_by , "${FOO[@]}" #a,b,c
join_by() {
  local IFS="$1"
  shift
  echo "$*"
}
```

### Tar with Timestamp

```sh
# Summary:
#   Creates an timestamped tarball
#
# Usage:
#   tar-with-timestamp /path/to/archive
tar_with_timestamp() {
  local src=${1}
  local timestamp
  timestamp="$(date +%Y_%m_%d_%H_%M_%S)"
  local target="${src}_${timestamp}.tar.gz"

  tar -zcvf "${target}" "${src}"
}
```

### Timestamp

```sh
# Summary:
#   Print a timestamp
#
# Usage:
#   timestamp
#
#         Format/result           |       Command              |          Output
# --------------------------------+----------------------------+------------------------------
# YYYY-MM-DD_hh:mm:ss             | date +%F_%T                | $(date +%F_%T)
# YYYYMMDD_hhmmss                 | date +%Y%m%d_%H%M%S        | $(date +%Y%m%d_%H%M%S)
# YYYYMMDD_hhmmss (UTC version)   | date --utc +%Y%m%d_%H%M%SZ | $(date --utc +%Y%m%d_%H%M%SZ)
# YYYYMMDD_hhmmss (with local TZ) | date +%Y%m%d_%H%M%S%Z      | $(date +%Y%m%d_%H%M%S%Z)
# YYYYMMSShhmmss                  | date +%Y%m%d%H%M%S         | $(date +%Y%m%d%H%M%S)
# YYYYMMSShhmmssnnnnnnnnn         | date +%Y%m%d%H%M%S%N       | $(date +%Y%m%d%H%M%S%N)
# YYMMDD_hhmmss                   | date +%y%m%d_%H%M%S        | $(date +%y%m%d_%H%M%S)
# Seconds since UNIX epoch:       | date +%s                   | $(date +%s)
# Nanoseconds only:               | date +%N                   | $(date +%N)
# Nanoseconds since UNIX epoch:   | date +%s%N                 | $(date +%s%N)
# ISO8601 UTC timestamp           | date --utc +%FT%TZ         | $(date --utc +%FT%TZ)
# ISO8601 UTC timestamp + ms      | date --utc +%FT%T.%3NZ     | $(date --utc +%FT%T.%3NZ)
# ISO8601 Local TZ timestamp      | date +%FT%T%Z              | $(date +%FT%T%Z)
# YYYY-MM-DD (Short day)          | date +%F\(%a\)             | $(date +%F\(%a\))
# YYYY-MM-DD (Long day)           | date +%F\(%A\)             | $(date +%F\(%A\))

date +%Y_%m_%d_%H_%M_%S
```

## Lazy Loading

The folllowing are some helpers that can be used to lazy load an expensive
operation until the first time the function or command is called.

```sh
#
# lazy load function helper
#
# usage:
#   lazyfunc [lazy_function] [commands_to_hook...]
#
# example:
#   lazyfunc _nodenv_init nodenv node npm
#
# example:
#   # Detailed example using pyenv
#   export PYENV_ROOT="${XDG_DATA_HOME}/pyenv"
#
#   _pyenv_init() {
#     # expensive operation
#     eval "$(pyenv init - --no-rehash)"
#
#     # Rehash in the background
#     # (pyenv rehash &) 2> /dev/null
#   }
#
#   _pyenv_lazy_init() {
#     unset -f "$0"
#
#     # faster alternative to full 'pyenv init'
#     export PYENV_SHELL="zsh"
#     prepend_path "${PYENV_ROOT}/shims"
#
#     # lazy initialize
#     lazyfunc _pyenv_init pyenv
#   }
#
#   # Load package manager installed pyenv into shell session
#   if command_exists "pyenv"; then
#     _pyenv_lazy_init
#
#   # Load manually installed pyenv into the shell session
#   elif [ -s "${PYENV_ROOT}/bin/pyenv" ]; then
#     prepend_path "${PYENV_ROOT}/bin"
#     _pyenv_lazy_init
#
#   # Return if requirements not found
#   else
#     unset PYENV_ROOT
#     unset -f _pyenv_lazy_init
#     unset -f _pyenv_init
#     return 1
#   fi
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
```
