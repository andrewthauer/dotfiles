#!/usr/bin/env sh
#
# Setup Node
#

# Current version of NVM & node to install
NVM_VER="{NVM_VER:-0.33.4}"
NODE_VERSION="{NODE_VERSION:-8}"

# Will be a dependency
brew install 'node'

# NOTE: This is the preferred way to install NVM as the Homebrew version is unsupported
curl -o- https://raw.githubusercontent.com/creationix/nvm/v${NVM_VER}/install.sh | bash

# Make sure nvm is sourced
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Setup the default version of node
nvm install $NODE_VERSION
nvm use $NODE_VERSION

# Install desired npm version
npm install -g npm@$NPM_VERSION

# Set the default node version
nvm alias default $NODE_VERSION

# TODO: Verify zshrc is setup to load with zshrc
#   -- or use zsh-nvm plugin
#   -- or use oh-my-zsh/prezto plugin
#   -- or use custom plugin
#   -- or append to ~/.zshrc
