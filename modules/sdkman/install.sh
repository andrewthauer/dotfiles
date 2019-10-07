#!/usr/bin/env bash
#
# Installs sdkman to manage jdks & sdks
#

set -e

export SDKMAN_DIR="${XDG_DATA_HOME}/sdkman"

# check if it's already installed
if [[ -d "${SDKMAN_DIR}" ]]; then
  echo "sdkman is already installed"
  exit 0
fi

# install sdkman
curl -s "https://get.sdkman.io" | bash

# restart shell
exec $SHELL -l
