#!/usr/bin/env sh
#
# Installs the Rust language tools
#

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

export PATH="${HOME}/.cargo/bin:${PATH}"

# install some components
rustup component add rls rust-src rust-analysis rustfmt
