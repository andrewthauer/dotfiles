#!/usr/bin/env bash

set -eou pipefail

main() {
  case "$(os-info --family)" in
    "macos")
      brew install dagger/tap/container-use
      ;;
    *)
      echo "Not implemented for this OS"
      exit 1
      ;;
  esac
}

main "$@"
