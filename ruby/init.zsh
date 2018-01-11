#
# Ruby environment initialization
#

# Add rbenv to the path
if (( ! $+commands[rbenv] )); then
  export PATH="${HOME}/.rbenv/shims:${HOME}/.rbenv/bin:${PATH}"
fi

# Load rbenv
if [[ -d "${HOME}/.rbenv" ]]; then
  eval "$(rbenv init - --no-rehash)"
fi
