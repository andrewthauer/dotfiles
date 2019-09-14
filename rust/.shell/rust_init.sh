#
# Initialize rust environment
#
# - https://www.rust-lang.org
#

_rust_init() {
  unset -f $0
  # prepend cargo to the path if not already added
  CARGO_BIN_PATH="$HOME/.cargo/bin"
  # [[ ":$PATH:" =~ ":$CARGO_BIN_PATH:" ]] || export PATH="$CARGO_BIN_PATH:$PATH"
  export PATH="$CARGO_BIN_PATH:$PATH"
  unset CARGO_BIN_PATH
}

# initialize rust
if [ -s "${HOME}/.cargo" ]; then
  _rust_init
else
  unset -f _rust_init
fi
