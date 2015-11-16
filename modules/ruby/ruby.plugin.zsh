# -------------------------------------
# Ruby stuff

# enable rbenv shims and autocompletion
export PATH="${HOME}/.rbenv/shims:${HOME}/.rbenv/bin:${PATH}"
eval "$(rbenv init - zsh)"

# gem helper
gem_install_or_update() {
  if gem list "$1" --installed > /dev/null; then
    echo "Updating %s ..." "$1"
    gem update "$@"
  else
    echo "Installing %s ..." "$1"
    gem install "$@"
    rbenv rehash
  fi
}

# aliases
alias be="bundle exec"
