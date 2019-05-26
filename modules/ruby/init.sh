#
# Initialize ruby module
#

# initialize rbenv
if [[ -x "$(command -v rbenv)" ]]; then
  eval "$(rbenv init - --no-rehash)"
fi

# load aliases
if [[ -x "$(command -v ruby)" ]]; then
  source "${DOTFILES_MOD_DIR}/ruby/aliases.sh"
fi
