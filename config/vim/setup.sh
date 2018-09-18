#!/usr/bin/env bash

# Get current directory name
DIR="$(dirname ${BASH_SOURCE[0]})"

# Ensure directories exist
mkdir -p "${DIR}/settings"
mkdir -p "${DIR}/pack/plugins/opt"
mkdir -p "${DIR}/pack/plugins/start"

# Install plugins
git clone https://github.com/editorconfig/editorconfig-vim "${DIR}/pack/plugins/start/editorconfig-vim"
git clone https://github.com/vim-scripts/Zenburn.git "${DIR}/pack/plugins/start/Zenburn"
