#!/usr/bin/env bash

DIR="${DOTFILES_MODULES_DIR}/dotfiles"

if [[ "${ZSH_NAME}" == "zsh" ]]; then
  # Ensure dotfiles cmd is in path
  if [[ ! -x "$(command -v dotfiles)" ]]; then
    path=("${DIR}/bin" $path)
    fpath=("${DIR}/bin" $fpath)
  fi

  # Setup completions
  source "${DIR}/completions/dotfiles.zsh"
else
  # Setup completions
  source "${DIR}/completions/dotfiles.bash"
fi

# shortcut aliases
alias dot="dotfiles"
alias doti="dotfiles init"
