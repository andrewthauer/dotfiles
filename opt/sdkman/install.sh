#!/usr/bin/env bash
#
# Installs java toolchain
#

set -e

# Directory of this script
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

# Export desired directory
export SDKMAN_DIR="${XDG_DATA_HOME}/sdkman"

install_sdkman() {
  # check if it's already installed
  if [[ -d "${SDKMAN_DIR}" ]]; then
    echo "sdkman is already installed"
    exit 0
  fi

  # install sdkman
  curl -s "https://get.sdkman.io" | bash

  # restart shell
  exec $SHELL -l
}

install_java_latest() {
  # need to source sdkman since it is a shell function
  source "${SDKMAN_DIR:-~/.sdkman}/bin/sdkman-init.sh"

  # install latest version
  sdk install java
}

install_maven() {
  if confirm "Do you want to install maven"; then
    sdk install maven
    cp -n $DIR/.config/maven/settings.example.xml $DOTFILES_DIR/@local/.config/maven/settings.xml
  fi
}

install_gradle() {
  if confirm "Do you want to install gradle"; then
    sdk install gradle
  fi
}

main() {
  # Install java versions
  install_sdkman
  install_java_latest

  # Add versions to jenv
  ${DIR}/.local/bin/jenv-add-all
  ${DIR}/.local/bin/jenv-global-latest

  # Install java tools
  install_maven
  install_gradle

  # reload the current shell
  exec $SHELL -l
}

main
exit 0
