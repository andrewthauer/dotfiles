#
# Initialize ruby environment
#
# - https://github.com/rbenv/rbenv
#

export RBENV_ROOT="${XDG_DATA_HOME}/rbenv"

_rbenv_init() {
  # expensive operation
  eval "$(rbenv init - --no-rehash)"

  # Rehash in the background
  # (rbenv rehash &) 2> /dev/null
}

_rbenv_lazy_init() {
  unset -f "$0"

  # faster alternative to full 'rbenv init'
  export RBENV_SHELL="${SHELL}"
  export PATH="${RBENV_ROOT}/shims:${PATH}"

  # lazy initialize
  lazyfunc _rbenv_init rbenv
}

# Load package manager installed rbenv into shell session
if command_exists "rbenv"; then
  _rbenv_lazy_init

# Load manually installed rbenv into the shell session
elif [[ -s "${RBENV_ROOT}/bin/rbenv" ]]; then
  export PATH="${RBENV_ROOT}/bin:${PATH}"
  _rbenv_lazy_init

# Return if requirements not found
elif ! command_exists "ruby"; then
  unset -f _rbenv_init
  return 1
fi

#
# Bundler
#

if command_exists "bundle"; then
  # Change bundler home to xdg cache
  export BUNDLE_USER_HOME="${XDG_CACHE_HOME}/bundle"

  # For bundler
  if [[ -z "${GITHUB_TOKEN}" ]]; then
    BUNDLE_GITHUB__COM="${GITHUB_TOKEN}:x-oauth-basic"
  fi

  # Aliases
  alias be="bundle exec"
fi
