#!/usr/bin/env bash

set -eou pipefail

install_krew() {
  (
    set -x
    cd "$(mktemp -d)" &&
      OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
      ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
      KREW="krew-${OS}_${ARCH}" &&
      curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
      tar zxvf "${KREW}.tar.gz" &&
      ./"${KREW}" install krew
  )
}

main() {
  case "$("$DOTFILES_DIR"/bin/os-info --family)" in
    "macos")
      brew install kubectl
      ;;
    *)
      "$DOTFILES_DIR"/bin/pkg install "kubectl"
      ;;
  esac

  install_krew
}

main "$@"
