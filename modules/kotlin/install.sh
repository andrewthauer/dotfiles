#!/usr/bin/env bash
#
# Installs kotlin toolchain
#

set -e

install_with_sdk() {
  # need to source sdkman since it is a shell function
  source "${DOTFILES_DIR}/modules/sdkman/init.sh"

  # install latest version
  sdk install kotlin

  # reload shell
  exec $SHELL -l
}

install_with_sdk
