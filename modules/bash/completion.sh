#
# Bash Completions
#

[[ -z ${BREW_PREFIX} ]] && BREW_PREFIX="$(brew --prefix)"

if [ -f "/etc/bash_completion" ]; then
  source "/etc/bash_completion"
elif [ -f "${BREW_PREFIX}/etc/bash_completion" ]; then
  source "${BREW_PREFIX}/etc/bash_completion"
fi
