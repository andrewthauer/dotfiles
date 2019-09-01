#!/usr/bin/env bash
#
# Installs go toolchain
#

set -e

# install version manager
brew install goenv
exec $SHELL -l

# install latest version
VERSION=$(goenv install --list | grep -v "[a-zA-Z]" | tail -n 1 | tr -d ' ')
goenv install $VERSION

# set default global version
goenv global $VERSION
