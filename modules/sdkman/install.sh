#!/usr/bin/env bash
#
# Installs sdkman to manage jdks & sdks
#

set -e

# Directory of this script
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

# Export desired directory
export SDKMAN_DIR="${XDG_DATA_HOME}/sdkman"

# check if it's already installed
if [[ -d "${SDKMAN_DIR}" ]]; then
  echo "sdkman is already installed"
  exit 0
fi

# install sdkman
curl -s "https://get.sdkman.io" | bash

# Stow this dotfiles module
stow -t ~ -d ${DIR}/.. $(basename "${DIR}")

# restart shell
exec $SHELL -l
