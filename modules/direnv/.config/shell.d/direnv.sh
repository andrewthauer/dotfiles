#
# Directory specific environments
#
# - https://direnv.net/
#

# Initialize direnv for bash
if [ -n "${BASH_VERSION}" ]; then
  eval "$(direnv hook bash)"

# Initialize direnv for zsh
elif [ -n "${ZSH_VERSION}" ]; then
  eval "$(direnv hook zsh)"

# No shell support
else
  return 1
fi
