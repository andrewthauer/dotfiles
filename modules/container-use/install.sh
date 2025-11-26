#!/usr/bin/env bash

set -eou pipefail

main() {
  case "$(os-info --family)" in
    "macos") pkg --type brew install dagger/tap/container-use ;;
    *) echo "Not implemented for this OS" ;;
  esac
}

main "$@"
