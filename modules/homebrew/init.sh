#
# Initialize brew module
#

# load aliases
if [[ -x "$(command -v brew)" ]]; then
  source "${DOTFILES_MOD_DIR}/homebrew/aliases.sh"
fi
