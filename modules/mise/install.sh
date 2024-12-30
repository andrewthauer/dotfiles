#!/usr/bin/env bash

set -eou pipefail

main() {
  case "$("$DOTFILES_DIR"/bin/os-info --family)" in
    "macos")
      brew install mise
      ;;
    *)
      curl https://mise.jdx.dev/install.sh | sh
      ;;
  esac
}
