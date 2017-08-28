#
# Rust environment initialization
#

# Add rust to path
if [[ -d "${HOME}/.cargo" ]]; then
  # export PATH="${PATH}:$HOME/.cargo/bin"
fi

# Setup rust-auto-complet-er
if (( $+commands[rustc] )); then
  export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
fi
