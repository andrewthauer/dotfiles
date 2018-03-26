#
# Ruby initialization
#

# rbenv support (https://github.com/rbenv/rbenv)
if [[ -d "${HOME}/.rbenv" ]]; then
  # Add rbenv to the path
  if ! [ -x "$(command -v rbenv)" ]; then
    export PATH="${HOME}/.rbenv/bin:${PATH}"
  fi

  # Initialize rbenv (prepends ~/.rbenv/shims to path)
  eval "$(rbenv init - --no-rehash)"
fi

#
# Aliases & helpers
#

# Skip if ruby is not installed
if ! [[ -x "$(command -v ruby)" ]]; then
  return
fi

# Common aliases
alias be="bundle exec"
alias rspec="bundle exec rspec"
alias rake="bundle exec rake"
alias rails="bundle exec rails"
alias cap="bundle exec capistrano"
