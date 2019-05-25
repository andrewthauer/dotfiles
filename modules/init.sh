#
# Load comon modules
# - work across sh/bash/zsh/etc
#

source "${DOTFILES_MOD_DIR}/docker/init.sh"
source "${DOTFILES_MOD_DIR}/git/init.sh"
source "${DOTFILES_MOD_DIR}/dotnet/init.sh"
source "${DOTFILES_MOD_DIR}/homebrew/init.sh"
source "${DOTFILES_MOD_DIR}/node/init.sh"
source "${DOTFILES_MOD_DIR}/python/init.sh"
source "${DOTFILES_MOD_DIR}/ruby/init.sh"
source "${DOTFILES_MOD_DIR}/rust/init.sh"
source "${DOTFILES_MOD_DIR}/utility/init.sh"

# load the dotfiles
source "${DOTFILES_DIR}/lib/dotfiles/init.sh"

# Initials fasd if exists
if [[ -x "$(command -v fasd)" ]]; then
  eval "$(fasd --init auto)"
fi
