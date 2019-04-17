
#
# programming environments
#

if [[ -x "$(command -v nodenv)" || -s "${HOME}/.nodenv/bin/nodenv" ]]; then
  export PATH="${HOME}/.nodenv/bin:${PATH}"
  eval "$(nodenv init - --no-rehash)"
fi

if [[ -x "$(command -v pyenv)" || -s "${HOME}/.pyenv/bin/pyenv" ]]; then
  export PATH="${HOME}/.pyenv/bin:${PATH}"
  eval "$(pyenv init - --no-rehash)"
fi

if [[ -x "$(command -v rbenv)" || -s "${HOME}/.rbenv/bin/rbenv" ]]; then
  export PATH="${HOME}/.rbenv/bin:${PATH}"
  eval "$(rbenv init - --no-rehash)"
fi

#
# fasd
#

if [[ -x "$(command -v fasd)" ]]; then
  eval "$(fasd --init auto)"
fi
