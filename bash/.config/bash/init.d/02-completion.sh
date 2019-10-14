#
# Bash Completions
#

# Load bash completions
if [[ -f "/etc/bash_completion" ]]; then
  source "/etc/bash_completion"
elif [[ -n ${BREW_PREFIX} && -f "${BREW_PREFIX}/etc/bash_completion" ]]; then
  source "${BREW_PREFIX}/etc/bash_completion"
elif [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]]; then
  source "/usr/local/etc/profile.d/bash_completion.sh"
fi
