#
# Initialize python module
#

# initialize pyenv
if [[ -x "$(command -v pyenv)" ]]; then
  eval "$(pyenv init - --no-rehash)"
fi

# load aliases
if [[ -x "$(command -v python)" ]]; then
  source "${DOTFILES_MODULES_DIR}/python/aliases.sh"
fi
