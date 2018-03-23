#
# asdf - extendable version manager
# - https://github.com/asdf-vm/asdf
#

# Initialize
if [[ -d "${HOME}/.asdf" ]]; then
  source ${HOME}/.asdf/asdf.sh
  source ${HOME}/.asdf/completions/asdf.bash
fi

# Source module files
source "${0:h}/aliases.zsh"
