#!/usr/bin/env bash

DIR="${DOTFILES_MODULES_DIR}/dotfiles"

if [[ -n "${ZSH_NAME}" ]]; then
  # Ensure dotfiles cmd is in path
  if [[ ! $+commands[dotfiles] ]]; then
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
