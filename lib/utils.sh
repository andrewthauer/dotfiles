#
# General utilities
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
  # use fastest shell specific method
  if [[ -n "$ZSH_VERSION" ]]; then
    [ $+commands[$1] ]
  else
    command -v "$1" > /dev/null 2>&1
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
function function_exists {
  # declare -f -F "$1" > /dev/null 2>&1
  typeset -f "$1" > /dev/null 2>&1
}
