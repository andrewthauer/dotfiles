#
# SSH helper aliases
#

# Skip if ssh is not installed
if [[ ! -x "$(command -v ssh)" ]]; then
  return
fi

#
# Aliases
#

alias ssh-config="$EDITOR ~/.ssh/config"
