#
# Ruby initialization
#

# Use asdf if available and plugin is installed
if [[ -x "$(command -v asdf)" && -d "${ASDF_DIR}/plugins/ruby" ]]; then
  ASDF_RUBY=

# Load custom installed rbenv
elif [[ ! -z "${RBENV_ROOT}" && -s "${RBENV_ROOT}/bin/rbenv" ]]; then
  export PATH="${RBENV_ROOT}/bin:${PATH}"
  eval "$(rbenv init - --no-rehash)"

# Load manually installed rbenv
elif [[ -s "{$HOME/.rbenv/bin/rbenv" ]]; then
  export PATH="${HOME}/.rbenv/bin:${PATH}"
  eval "$(rbenv init - --no-rehash)"

# Load package manager installed rbenv
elif [[ -x "$(command -v rbenv)" ]]; then
  eval "$(rbenv init - --no-rehash)"

# Return if requirements are not found
elif [[ ! -x "$(command -v ruby)" ]]; then
  return 1
fi

#
# Aliases & helpers
#

# Common aliases
alias be="bundle exec"
