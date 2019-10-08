#
# Initialize node environment
#
# - https://github.com/nodenv/nodenv
#

export NODENV_ROOT="${XDG_DATA_HOME}/nodenv"

_nodenv_init() {
  # expensive operation
  # eval "$(nodenv init - --no-rehash)"

  # faster alternative to `nodenv init`
  export NODENV_SHELL="${SHELL}"
  export PATH="${NODENV_ROOT}/shims:${PATH}"

  # Rehash in the background
  # (nodenv rehash &) 2> /dev/null

  unset -f "$0"
}

# Load package manager installed nodenv into shell session
if command_exists "nodenv"; then
  _nodenv_init

# Load manually installed nodenv into the shell session
elif [[ -s "${NODENV_ROOT:-$HOME/.nodenv}/bin/nodenv" ]]; then
  export PATH="${NODENV_ROOT}/bin:${PATH}"
  _nodenv_init

# Return if requirements not found
elif ! command_exists "node"; then
  unset -f _nodenv_init
  return 1
fi

#
# XDG specifications
#

export NPM_CONFIG_DEVDIR="${XDG_CACHE_HOME}/node-gyp"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/config"
export NPM_CONFIG_CACHE="${XDG_CACHE_HOME}/npm"
# export NPM_CONFIG_TMP="${XDG_RUNTIME_DIR}/npm"

#
# Aliases
#

# npm list
alias npm-list="npm list --depth=0 2>/dev/null"
alias npm-list-g="npm list -g --depth=0 2>/dev/null"

# npm outdated
alias npm-outdated="npm outdated --depth 0 -q"
alias npm-outdated-g="npm outdated -g --depth 0 -q"

# nodenv
alias nodenv-alias="nodenv alias"
alias nodenv-dpi="nodenv default-packages install --all"
