#!/usr/bin/env bash
#
# Installs dotnet toolchain
#

set -e

# install dotnet
brew cask install dotnet-sdk
exec $SHELL -l
