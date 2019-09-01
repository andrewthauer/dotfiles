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
#   if command_exists "node"; then echo "exists!"
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
#   if function_exists "command_exists"; then echo "exists!"
#
function function_exists {
  declare -f -F $1 > /dev/null
  return $?
}

#
# lazy load function helper
#
# usage:
#   __lazyfunc [command to hook] [lazy function]
#
# example:
#   __lazyfunc node _nodenv_init
#
# see: https://dev.to/zanehannanau/bash-lazy-completion-evaluation-2a2d
#
function __lazyfunc {
  if command_exists "$1" || [[ -n $LAZYFUNC_FORCE_REDEFINE ]]; then
    local fn="$1"
    shift
    eval "$fn () { unset -f "$fn" ; eval \"\$( $@ )\" ; $fn \$@ ; }"
  fi
}
