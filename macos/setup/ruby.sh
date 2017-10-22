#!/usr/bin/env sh
#
# Setup Ruby
#

# Default version of ruby to install
RUBY_VERSION="${RUBY_VERSION:-2.4.0}"

# Install ruby & rbenv stuff
brew install 'rbenv'
brew install 'ruby-build'

# Initialize rbenv
eval "$(rbenv init -)"

# Install default ruby version
if ! rbenv versions | grep -Fq "$RUBY_VERSION"; then
  rbenv install -s $RUBY_VERSION
fi

# Set default ruby version
rbenv global $RUBY_VERSION
rbenv shell $RUBY_VERSION

# Install bundler
gem install bundler
