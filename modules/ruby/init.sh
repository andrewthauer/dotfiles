#
# Ruby initialization
#

no_rehash_arg="--no-rehash"

# Use anyenv / rbenv if available
if [[ -x "$(command -v anyenv)" && -d "$(anyenv root)/envs/rbenv" ]]; then
  echo skip

# Use asdf if available and plugin is installed
elif [[ -x "$(command -v asdf)" && -d "${ASDF_DIR}/plugins/ruby" ]]; then
  ASDF_RUBY=

# Load custom installed rbenv
elif [[ ! -z "${RBENV_ROOT}" && -s "${RBENV_ROOT}/bin/rbenv" ]]; then
  export PATH="${RBENV_ROOT}/bin:${PATH}"
  eval "$(rbenv init - ${no_rehash_arg})"

# Load manually installed rbenv
elif [[ -s "${HOME}/.rbenv/bin/rbenv" ]]; then
  export PATH="${HOME}/.rbenv/bin:${PATH}"
  eval "$(rbenv init - ${no_rehash_arg})"

# Load package manager installed rbenv
elif [[ -x "$(command -v rbenv)" ]]; then
  eval "$(rbenv init - ${no_rehash_arg})"

# Return if requirements are not found
elif [[ ! -x "$(command -v ruby)" ]]; then
  return 1
fi

#
# Aliases & helpers
#

# Common aliases
alias be="bundle exec"
