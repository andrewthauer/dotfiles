#!/usr/bin/env bash
#
# Installs java toolchain
#

set -e

# Directory of this script
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

install_sdkman() {
  "${DIR}/../sdkman/install.sh"
}

install_jenv() {
  brew install jenv

  # make sure JAVA_HOME is set
  jenv enable-plugin export
}

install_with_brew() {
  # install latest version
  brew cask install --force java

  # install java 8
  # brew cask install --force homebrew/cask-versions/adoptopenjdk8
}

install_with_sdk() {
  # need to source sdkman since it is a shell function
  source "${SDKMAN_DIR:-~/.sdkman/bin/sdkman-init.sh}"

  # install latest version
  sdk install java
}

install_java() {
  PS3="How do you want to install java?: "
  options=("homebrew" "sdkman" "skip" "quit")
  select opt in "${options[@]}"; do
  case $opt in
    "homebrew")   echo "Using $opt ..."; install_with_brew; break;;
    "sdkman")     echo "Using $opt ..."; install_with_sdk; break;;
    "skip")       break;;
    "quit")       exit 0;;
    *)            echo "invalid option $REPLY";;
  esac
  done
}

install_maven() {
  if confirm "Do you want to install maven"; then
    sdk install maven
    jenv enable-plugin maven
  fi
}

install_gradle() {
  if confirm "Do you want to install gradle"; then
    sdk install gradle
    jenv enable-plugin gradle
  fi
}

main() {
  # Install java versions
  install_sdkman
  install_jenv
  install_java

  # Add versions to jenv
  ${DIR}/.local/bin/jenv-add-all
  ${DIR}/.local/bin/jenv-global-latest

  # Install java tools
  install_maven
  install_gradle

  # Stow this dotfiles module
  stow -t ~ -d ${DIR}/.. $(basename "${DIR}")

  # reload the current shell
  exec $SHELL -l
}

main
exit 0
