#!/usr/bin/env zsh

dir="${0:h}"

# Ensure dotfiles cmd is in path
if [[ ! -x "$(command -v dotfiles)" ]]; then
  path=("${dir}/bin" $path)
  fpath=("${dir}/bin" $fpath)
fi

# Setup completions
# source "${dir}/completions/dotfiles.bash"
source "${dir}/completions/dotfiles.zsh"
