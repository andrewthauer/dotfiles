#!/usr/bin/env bash
#
# Installs python toolchain
#

set -e

# install version manager
brew install pyenv
exec $SHELL -l

# install latest version
VERSION=$(pyenv install --list | grep -v "[a-zA-Z]" | tail -n 1 | tr -d ' ')
pyenv install $VERSION

# set default global version
pyenv global $VERSION
