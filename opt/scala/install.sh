#!/usr/bin/env bash
#
# Installs scala toolchain
#

set -e

install_with_brew() {
  # install build tool
  brew update
  (brew ls --versions sbt && brew upgrade sbt) || brew install sbt

  # install scala
  # brew ls --versions scala && brew upgrade scala || brew install scala
}

install_with_sdk() {
  if [[ ! -d "${SDKMAN_DIR:-~/.sdkman}" ]]; then
    echo "sdkman was not found"
    exit 0
  fi

  # need to source sdkman since it is a shell function
  # shellcheck disable=SC1090
  source "${SDKMAN_DIR:-~/.sdkman/bin/sdkman-init.sh}"

  # install build tool
  sdk install sbt

  # install latest version
  sdk install scala

  # reload shell
  exec "$SHELL" -l
}

main() {
  # Install scala
  PS3="How do you want to install scala?: "
  options=("homebrew" "sdkman" "quit")
  select opt in "${options[@]}"; do
    case $opt in
      "homebrew")
        echo "Using $opt ..."
        install_with_brew
        break
        ;;
      "sdkman")
        echo "Using $opt ..."
        install_with_sdk
        break
        ;;
      "quit") break ;;
      *) echo "invalid option $REPLY" ;;
    esac
  done
}

main
