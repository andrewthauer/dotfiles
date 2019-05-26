#
# Initialize rust module
#

# initialize rust
if [[ -x "$(command -v rustc)" || -s "${HOME}/.cargo" ]]; then
  # prepend cargo to the path if not already added
  CARGO_BIN_PATH="$HOME/.cargo/bin"
  [[ ":$PATH:" =~ ":$CARGO_BIN_PATH:" ]] || export PATH="$CARGO_BIN_PATH:$PATH"
fi
