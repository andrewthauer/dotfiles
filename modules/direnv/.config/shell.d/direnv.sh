#
# Directory specific environments
#
# - https://direnv.net/
#

# Customize logging or default
export DIRENV_LOG_FORMAT="${DIRENV_LOG_FORMAT:-"direnv: %s"}"

# Hook direnv
eval "$(direnv hook "$SHELL_TYPE")"
