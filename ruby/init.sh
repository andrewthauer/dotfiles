#
# Initialize Ruby environment
#

# initialize rbenv
if [[ -x "$(command -v rbenv)" || -s "${HOME}/.rbenv/bin/rbenv" ]]; then
  export PATH="${HOME}/.rbenv/bin:${PATH}"
  eval "$(rbenv init - --no-rehash)"
fi

# Load aliases
if [[ -x "$(command -v ruby)" ]]; then
  source "${DOTFILES_DIR}/ruby/aliases.sh"
fi
