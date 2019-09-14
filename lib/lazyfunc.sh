#
# Utilities for lazy loading functions by trigger/hooks
#

#
# lazy load function helper
#
# usage:
#   lazyfunc [lazy_function] [commands_to_hook...]
#
# example:
#   lazyfunc _nodenv_init nodenv node npm
#
function lazyfunc {
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
