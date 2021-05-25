#!/usr/bin/env bash
#
# Installs java toolchain
#

set -e

# Directory of this script
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

install_jenv() {
  brew install jenv

  # make sure JAVA_HOME is set
  jenv enable-plugin export
}

install_maven() {
  if confirm "Do you want to install maven"; then
    jenv enable-plugin maven
  fi
}

install_gradle() {
  if confirm "Do you want to install gradle"; then
    jenv enable-plugin gradle
  fi
}

main() {
  # Install java versions
  install_jenv
  install_java_latest

  # Add versions to jenv
  "${DIR}"/.local/bin/jenv-add-all
  "${DIR}"/.local/bin/jenv-global-latest

  # Install java tools
  install_maven
  install_gradle

  # reload the current shell
  exec "$SHELL" -l
}

main
exit 0
