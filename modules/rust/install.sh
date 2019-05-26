#!/usr/bin/env bash
#
# Installs the Rust language tools
#

# install rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# set the cargo path
export PATH="${HOME}/.cargo/bin:${PATH}"

# install some components
rustup component add \
  rls \
  rust-src \
  rust-analysis \
  rustfmt \
  cargo-watch \
  carge-make \
  cargo-web
