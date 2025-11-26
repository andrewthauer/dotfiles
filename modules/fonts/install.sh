#!/usr/bin/env bash

set -eou pipefail

DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &>/dev/null && pwd)"
PATH="$DOTFILES_HOME/bin:$PATH"

main() {
  case "$(os-info --family)" in
    darwin) pkg --type brew install font-fira-code font-fira-mono font-fira-code-nerd-font ;;
    arch) pkg --type aur install ttf-fira-code ttf-fira-mono ttf-firacode-nerd ;;
    debian) pkg --type apt install fonts-firacode ;;
    *) echo "Unsupported OS for font installation" ;;
  esac

}

main "$@"
