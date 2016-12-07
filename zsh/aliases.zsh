#!/usr/bin/env sh

# common bash aliases
source "${DOTFILES}/bash/bash_aliases.sh"

# editor shortcuts
alias e="edit"
alias ezsh="${EDITOR} ~/.zshrc"

# reloading
alias src="source ~/.zshrc"
alias reload!="zgen update && source ${HOME}/.zshrc"
