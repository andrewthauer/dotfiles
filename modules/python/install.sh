#!/usr/bin/env bash
#
# Installs python toolchain
#

# install python
brew install pyenv
exec $SHELL -l

# install latest python version
VERSION=$(pyenv install -list | grep -v "[a-zA-Z]" | tail -n 1)
pyenv install $VERSION

# set default global version
pyenv global $VERSION
