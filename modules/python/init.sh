#
# Python initialization
#

# Use asdf if available and plugin is installed
if [[ -x "$(command -v asdf)" && -d "${ASDF_DIR}/plugins/python" ]]; then
  ASDF_PYTHON=

# Load custom installed pyenv
elif [[ ! -z "${PYENV_ROOT}" && -s "${PYENV_ROOT}/bin/pyenv" ]]; then
  export PATH="${PYENV_ROOT}/bin:${PATH}"
  eval "$(pyenv init - --no-rehash)"

# Load manually installed pyenv
elif [[ -s "{$HOME/.pyenv/bin/pyenv" ]]; then
  export PATH="${HOME}/.pyenv/bin:${PATH}"
  eval "$(pyenv init - --no-rehash)"

# Load package manager installed pyenv
elif [[ -x "$(command -v pyenv)" ]]; then
  eval "$(pyenv init - --no-rehash)"

# Return if requirements are not found
elif [[ ! -x "$(command -v python)" ]]; then
  return 1
fi
