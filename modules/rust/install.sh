#!/usr/bin/env bash
#
# Installs the Rust language tools
#

set -e

DEFAULT_COMPONENTS=(
  rls
  rust-src
  rust-analysis
  rustfmt
)

DEFAULT_CRATES=(
  cargo-watch
  carge-make
  cargo-web
)

install_components() {
  for comp in "${DEFAULT_COMPONENTS[@]}"; do
    rustup component add "$comp"
  done
}

install_crates() {
  for crate in "${DEFAULT_CRATES[@]}"; do
    cargo install "$crate"
  done
}

# check if rust is installed with rustup
if [[ ! -x $(command -v rustup) ]]; then
  # install rust
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  mv ~/.rustup "${XDG_DATA_HOME}/rustup"
  mv ~/.cargo "${XDG_DATA_HOME}/cargo"
else
  # update rust
  rustup update
fi

# install some packages
install_components
install_crates
