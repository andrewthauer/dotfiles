#
# Initialize python module
#

# Initialize pyenv
if [[ -x "$(command -v pyenv)" || -s "${HOME}/.pyenv/bin/pyenv" ]]; then
  export PATH="${HOME}/.pyenv/bin:${PATH}"
  eval "$(pyenv init - --no-rehash)"
fi

# Load aliases
if [[ -x "$(command -v python)" ]]; then
  source "${DOTFILES_MOD_DIR}/python/aliases.sh"
fi
