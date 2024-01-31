#
# Directory specific environments
#
# - https://direnv.net/
#

# Disable direnv logging
export DIRENV_LOG_FORMAT="${DIRENV_LOG_FORMAT:-""}"

# Hook direnv
eval "$(direnv hook "$CURRENT_SHELL")"
