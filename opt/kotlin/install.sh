#!/usr/bin/env bash
#
# Installs kotlin toolchain
#

set -e

# Directory of this script
# DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

install_with_brew() {
  # install kotlin
  (brew ls --versions kotlin && brew upgrade kotlin) || brew install kotlin
}

install_with_sdk() {
  if [[ ! -d "${SDKMAN_DIR:-~/.sdkman}" ]]; then
    echo "sdkman was not found"
    exit 0
  fi

  # need to source sdkman since it is a shell function
  # shellcheck disable=SC1090
  source "${SDKMAN_DIR:-~/.sdkman/bin/sdkman-init.sh}"

  # install latest version
  sdk install kotlin

  # reload shell
  exec "$SHELL" -l
}

main() {
  # Install kotlin
  PS3="How do you want to install kotlin?: "
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
exit 0
