#
# Ruby helpers & aliases
#

# Load rbenv
if [[ -d "${HOME}/.rbenv" ]]; then
  export PATH="${HOME}/.rbenv/shims:${HOME}/.rbenv/bin:${PATH}"
  # NOTE: reshash slows startup time
  eval "$(rbenv init - --no-rehash)"
fi

# Gems
alias gem_uninstall_all="gem uninstall -aIx"

# Common aliases
alias be="bundle exec"
alias rspec="bundle exec rspec"
alias rake="bundle exec rake"
