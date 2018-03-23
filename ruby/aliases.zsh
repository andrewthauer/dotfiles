#
# Ruby helpers & aliases
#

# Skip if ruby is not installed
if (( ! $+commands[ruby] )); then
  return
fi

# Common aliases
alias be="bundle exec"
alias rspec="bundle exec rspec"
alias rake="bundle exec rake"
alias rails="bundle exec rails"
alias cap="bundle exec capistrano"
