#!/usr/bin/env bash
#
# Installs ruby toolchain
#

# install rbenv
brew install ruby-build rbenv
exec $SHELL -l

# install latest ruby version
VERSION=$(rbenv install -list | grep -v "[a-zA-Z]" | tail -n 1)
rbenv install $VERSION

# set default global version
rbenv global $VERSION
