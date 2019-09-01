#!/usr/bin/env bash
#
# Installs scala toolchain
#

set -e

install_with_brew() {
  # install build tool
  brew install sbt

  # install scala
  # brew install scala
}

install_with_sdk() {
  # need to source sdkman since it is a shell function
  source "${DOTFILES_DIR}/modules/sdkman/init.sh"

  # install build tool
  sdk install sbt

  # install latest version
  sdk install scala

  # reload shell
  exec $SHELL -l
}

run() {
  PS3="How do you want to install scala?: "
  options=("SDKMAN" "homebrew" "Quit")
  select opt in "${options[@]}"; do
  case $opt in
    "SDKMAN")     echo "Using $opt ..."; install_with_sdk; break;;
    "homebrew")   echo "Using $opt ..."; install_with_brew; break;;
    "Quit")       break;;
    *)            echo "invalid option $REPLY";;
  esac
  done
}

run
exit 0
