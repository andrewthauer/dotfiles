#!/usr/bin/env zsh

# rbenv support
if [[ -d "${HOME}/.rbenv" ]]; then
  export PATH="${HOME}/.rbenv/shims:${HOME}/.rbenv/bin:${PATH}"
  eval "$(rbenv init -)"
fi
