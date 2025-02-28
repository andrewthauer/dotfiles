#!/usr/bin/env bash

set -eou pipefail

main() {
  if [ "$(command -v mise)" ]; then
    echo "mise is already installed"
    exit 0
  fi

  case "$("$DOTFILES_DIR"/bin/os-info --family)" in
    "macos")
      brew install mise
      ;;
    *)
      curl https://mise.jdx.dev/install.sh | sh
      ;;
  esac
}

main "$@"
