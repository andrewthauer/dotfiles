#
# Python initialization
#

no_rehash_arg="--no-rehash"

# Use anyenv / pyenv if available
if [[ -x "$(command -v anyenv)" && -d "$(anyenv root)/envs/pyenv" ]]; then
  # Nothing to do

# Use asdf if available and plugin is installed
elif [[ -x "$(command -v asdf)" && -d "${ASDF_DIR}/plugins/python" ]]; then
  ASDF_PYTHON=

# Load custom installed pyenv
elif [[ ! -z "${PYENV_ROOT}" && -s "${PYENV_ROOT}/bin/pyenv" ]]; then
  export PATH="${PYENV_ROOT}/bin:${PATH}"
  eval "$(pyenv init - ${no_rehash_arg})"

# Load manually installed pyenv
elif [[ -s "${HOME}/.pyenv/bin/pyenv" ]]; then
  export PATH="${HOME}/.pyenv/bin:${PATH}"
  eval "$(pyenv init - ${no_rehash_arg})"

# Load package manager installed pyenv
elif [[ -x "$(command -v pyenv)" ]]; then
  eval "$(pyenv init - ${no_rehash_arg})"

# Return if requirements are not found
elif [[ ! -x "$(command -v python)" ]]; then
  return 1
fi
