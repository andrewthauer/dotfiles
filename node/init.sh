#
# Initialize Node environment
#

# Initialize nodenv
if [[ -x "$(command -v nodenv)" || -s "${HOME}/.nodenv/bin/nodenv" ]]; then
  export PATH="${HOME}/.nodenv/bin:${PATH}"
  eval "$(nodenv init - --no-rehash)"
fi

# Load aliases
if [[ -x "$(command -v node)" ]]; then
  source "${DOTFILES_DIR}/node/aliases.sh"
fi
