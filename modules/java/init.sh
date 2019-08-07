#
# Initialize java module
#

# initialize jenv
if [[ -x "$(command -v jenv)" ]]; then
  eval "$(jenv init - --no-rehash)"
fi

# load aliases
if [[ -x "$(command -v java)" ]]; then
  source "${DOTFILES_MODULES_DIR}/java/aliases.sh"
fi
