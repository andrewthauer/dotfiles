#
# Initialize kubernetes environment
#

if ! command_exists "terraform"; then
  return 1
fi

#
# Aliases
#

alias tf='terraform'
