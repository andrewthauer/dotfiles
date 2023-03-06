#
# Directory specific environments
#
# - https://direnv.net/
#

# Initialize direnv hooks for current shell
if ! command_exists "direnv"; then
  return 1
fi

# Disable direnv logging
export DIRENV_LOG_FORMAT=""

# Hook direnv
eval "$(direnv hook "$CURRENT_SHELL")"
