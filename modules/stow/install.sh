#!/usr/bin/env bash

set -eou pipefail

main() {
  # Stow this directory to the home directory first to ensure we ignore
  # certain files & directories and set some default values for stow
  local module_name="stow"
  stow -t "${HOME}" -d "${DOTFILES_HOME}/modules" --stow "${module_name}"
}

main "$@"
