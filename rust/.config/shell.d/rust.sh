#
# Initialize rust environment
#
# - https://www.rust-lang.org
#

export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"

# Use asdf if installed
if [[ -d "${XDG_DATA_HOME}/asdf/plugins/rust" ]]; then
  echo "using asdf" >/dev/null

# Load rust manually
elif [[ -d "${CARGO_HOME}/bin" ]]; then
  prepend_path "${CARGO_HOME}/bin"

# Return if requirements not found
else
  return 1
fi
