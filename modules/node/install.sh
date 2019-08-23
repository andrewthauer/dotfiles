#!/usr/bin/env bash
#
# Installs node toolchain
#

# install version manager
brew install node-build nodenv
exec $SHELL -l

# install latest version
VERSION=$(nodenv install --list | grep -v "[a-zA-Z]" | tail -n 1 | tr -d ' ')
nodenv install $VERSION

# set default global version
nodenv global $VERSION
