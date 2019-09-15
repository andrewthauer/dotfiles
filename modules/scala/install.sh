#!/usr/bin/env bash
#
# Installs scala toolchain
#

set -e

install_with_brew() {
  # install build tool
  brew update
  brew ls --versions sbt && brew upgrade sbt || brew install sbt

  # install scala
  # brew ls --versions scala && brew upgrade scala || brew install scala
}

install_with_sdk() {
  # need to source sdkman since it is a shell function
  source "${DOTFILES_DIR}/sdkman/.shell/sdkman-init.sh"

  # install build tool
  sdk install sbt

  # install latest version
  sdk install scala

  # reload shell
  exec $SHELL -l
}

main() {
  PS3="How do you want to install scala?: "
  options=("homebrew" "sdkman" "quit")
  select opt in "${options[@]}"; do
  case $opt in
    "homebrew")   echo "Using $opt ..."; install_with_brew; break;;
    "sdkman")     echo "Using $opt ..."; install_with_sdk; break;;
    "quit")       break;;
    *)            echo "invalid option $REPLY";;
  esac
  done
}

main
exit 0
