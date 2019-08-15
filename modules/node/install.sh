#!/usr/bin/env bash
#
# Installs node toolchain
#

# install node
brew install node-build nodenv
exec $SHELL -l

# install latest node version
VERSION=$(nodenv install -list | grep -v "[a-zA-Z]" | tail -n 1)
nodenv install $VERSION

# set default global version
nodenv global $VERSION
