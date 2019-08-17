#
# Initialize rust module
#

_rust_init() {
  # prepend cargo to the path if not already added
  CARGO_BIN_PATH="$HOME/.cargo/bin"
  [[ ":$PATH:" =~ ":$CARGO_BIN_PATH:" ]] || export PATH="$CARGO_BIN_PATH:$PATH"
  unset -f "$0"
}

# initialize rust
if [[ -s "${HOME}/.cargo" ]]; then
  _rust_init
fi

if command_exists "rustc"; then
  # load aliases
  source "${DOTFILES_MODULES_DIR}/rust/aliases.sh"
fi
