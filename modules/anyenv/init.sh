#
# Node.js environment initialization
#

no_rehash_arg="--no-rehash"

# Load custom installed anyenv
if [[ ! -z "${ANYENV_ROOT}" && -s "${ANYENV_ROOT}/bin/anyenv" ]]; then
  export PATH="${ANYENV_ROOT}/bin:${PATH}"
  eval "$(anyenv init - ${no_rehash_arg})"

# Load manually installed anyenv
elif [[ -s "${HOME}/.anyenv/bin/anyenv" ]]; then
  export PATH="${HOME}/.anyenv/bin:${PATH}"
  eval "$(anyenv init - ${no_rehash_arg})"

# Load package manager installed anyenv
elif [[ -x "$(command -v anyenv)" ]]; then
  eval "$(anyenv init - ${no_rehash_arg})"

# Return if requirements are not found
elif [[ ! -x "$(command -v anyenv)" ]]; then
  return 1
fi
