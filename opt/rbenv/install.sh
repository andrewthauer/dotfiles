#!/usr/bin/env bash
#
# Installs ruby toolchain
#

# install version manager
brew install ruby-build rbenv
# shellcheck disable=SC2093
exec "$SHELL" -l

# install latest version
VERSION=$(rbenv install --list | grep -v "[a-zA-Z]" | tail -n 1 | tr -d ' ')
rbenv install "$VERSION"

# set default global version
rbenv global "$VERSION"
