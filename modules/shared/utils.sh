#
# Core utils used by other modules
#

#
# Check if a command exists
#
# usage:
#   command_exists "command"
#
# example:
#   command_exists "node" && echo "exists!"
#
function command_exists {
  command -v "$1" >/dev/null 2>&1

  # use fastest shell specific method
  # if [[ -n $ZSH_VERSION ]]; then
  #   echo "$+commands[$1]" >/dev/null 2>&1
  # elif [[ -n $BASH_VERSION ]]; then
  #   command -v "$1" >/dev/null 2>&1
  # fi
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
function function_exists {
  declare -f -F $1 > /dev/null
  return $?
}

#
# lazy load function helper
#
# usage:
#   __lazyfunc [lazy_function] [commands_to_hook...]
#
# example:
#   __lazyfunc _nodenv_init nodenv node npm
#
function __lazyfunc {
  local lazyfunc="$1"
  local hooks=(${@:2})

  for cmd in "${hooks[@]}"; do
    eval "${cmd}() { __lazyfunc_exec ${lazyfunc} ${hooks[@]}; ${cmd} \$@; }"
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
  local hooks=(${@:2})
  unset -f "${hooks[@]}"
  eval "${lazyfunc}"
  unset "${lazyfunc}"
}
