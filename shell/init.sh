
#
# programming environments
#

if [[ -s "${HOME}/.nodenv/bin/nodenv" ]]; then
  export PATH="${HOME}/.nodenv/bin:${PATH}"
  eval "$(nodenv init - --no-rehash)"
fi

if [[ -s "${HOME}/.nodenv/bin/pyenv" ]]; then
  export PATH="${HOME}/.pyenv/bin:${PATH}"
  eval "$(pyenv init - --no-rehash)"
fi

if [[ -s "${HOME}/.nodenv/bin/rbenv" ]]; then
  export PATH="${HOME}/.rbenv/bin:${PATH}"
  eval "$(rbenv init - --no-rehash)"
fi

#
# fasd
#

if [[ -x "$(command -v fasd)" ]]; then
  eval "$(fasd --init auto)"
fi
