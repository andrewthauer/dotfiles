#!/usr/bin/env bash
#
# Installs kotlin toolchain
#

set -e

install_with_brew() {
  # install kotlin
  brew ls --versions kotlin && brew upgrade kotlin || brew install kotlin
}

install_with_sdk() {
  # need to source sdkman since it is a shell function
  source "${DOTFILES_DIR}/sdkman/.shell/sdkman-init.sh"

  # install latest version
  sdk install kotlin

  # reload shell
  exec $SHELL -l
}

main() {
  PS3="How do you want to install kotlin?: "
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
