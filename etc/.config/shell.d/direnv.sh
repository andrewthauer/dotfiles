#
# Directory specific environments
#
# - https://direnv.net/
#

# Initialize direnv hooks for current shell
if command_exists "direnv"; then
  eval "$(direnv hook "$CURRENT_SHELL")"
  # export DIRENV_LOG_FORMAT=
fi
