#!/usr/bin/env bash
#
# Installs dotnet toolchain
#

# install dotnet
brew cask install dotnet-sdk
exec $SHELL -l
