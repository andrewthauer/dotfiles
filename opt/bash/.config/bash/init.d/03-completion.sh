#
# Bash Completion
#

# Load bash completions
if [[ -e "${BREW_PREFIX}/share/bash-completion/bash_completion" ]]; then
  export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"
  # shellcheck disable=SC1091
  source "${BREW_PREFIX}/share/bash-completion/bash_completion"
elif [[ -e "${BREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
  # shellcheck disable=SC1091
  source "${BREW_PREFIX}/etc/profile.d/bash_completion.sh"
elif [[ -e "/etc/bash_completion" ]]; then
  # shellcheck disable=SC1091
  source "/etc/bash_completion"
fi

# Load custom completions
if [[ -d "${XDG_DATA_HOME}/bash_completion.d" ]]; then
  for file in "${XDG_DATA_HOME}"/bash_completion.d/*; do
    # shellcheck disable=SC1090
    source "$file"
  done
fi
