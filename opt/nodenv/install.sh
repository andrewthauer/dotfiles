#!/usr/bin/env bash
#
# Installs node toolchain
#

set -e

# install version manager
brew update
(brew ls --versions node-build && brew upgrade node-build) || brew install node-build
(brew ls --versions nodenv && brew upgrade nodenv) || brew install nodenv

# install latest version
VERSION=$(nodenv install --list | grep -v "[a-zA-Z]" | tail -n 1 | tr -d ' ')
nodenv install "$VERSION"

# set default global version
nodenv global "$VERSION"
