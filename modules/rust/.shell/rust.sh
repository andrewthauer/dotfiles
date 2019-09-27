#
# Initialize rust environment
#
# - https://www.rust-lang.org
#

export CARGO_HOME="${XDG_DATA_HOME}/cargo"

_rust_init() {
  export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
  export PATH="${CARGO_HOME}/bin:${PATH}"
  unset -f "$0"
}

# initialize rust
if [[ -s "${CARGO_HOME}" ]]; then
  _rust_init
else
  unset CARGO_HOME
  unset -f _rust_init
fi
